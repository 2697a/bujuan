import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'lyric.dart';
import 'lyric_controller.dart';
import 'lyric_painter.dart';

class LyricWidget extends StatefulWidget {
  final List<Lyric> lyrics;
  final List<Lyric> remarkLyrics;
  final Size size;
  final LyricController controller;
  TextStyle lyricStyle;
  TextStyle remarkStyle;
  TextStyle currLyricStyle;
  TextStyle currRemarkLyricStyle;
  TextStyle draggingLyricStyle;
  TextStyle draggingRemarkLyricStyle;
  final double lyricGap;
  final double remarkLyricGap;
  bool enableDrag;

  //歌词画笔数组
  List<TextPainter> lyricTextPaints = [];

  //翻译/音译歌词画笔数组
  List<TextPainter> subLyricTextPaints = [];

  //字体最大宽度
  double lyricMaxWidth;

  LyricWidget(
      {Key key,
      @required this.lyrics,
      this.remarkLyrics,
      @required this.size,
      this.controller,
      this.lyricStyle,
      this.remarkStyle,
      this.currLyricStyle,
      this.lyricGap: 12,
      this.remarkLyricGap: 10,
      this.draggingLyricStyle,
      this.draggingRemarkLyricStyle,
      this.enableDrag: true,
      this.lyricMaxWidth,
      this.currRemarkLyricStyle})
      : assert(enableDrag != null),
        assert(lyrics != null && lyrics.isNotEmpty),
        assert(size != null),
        assert(controller != null) {
    this.lyricStyle ??= TextStyle(color: Colors.grey, fontSize: 16);
    this.remarkStyle ??= TextStyle(color: Colors.grey, fontSize: 16);
    this.currLyricStyle ??=
        TextStyle(color: Theme.of(Get.context).accentColor, fontSize: 16,fontWeight: FontWeight.bold);
    this.currRemarkLyricStyle ??= this.currLyricStyle;
    this.draggingLyricStyle ??= lyricStyle.copyWith(color: Colors.greenAccent);
    this.draggingRemarkLyricStyle ??=
        remarkStyle.copyWith(color: Colors.greenAccent);

    //歌词转画笔
    lyricTextPaints.addAll(lyrics
        .map(
          (l) => TextPainter(
              textAlign: TextAlign.center,
              text: TextSpan(text: l.lyric, style: lyricStyle),
              textDirection: TextDirection.ltr),
        )
        .toList());

    //翻译/音译歌词转画笔
    if (remarkLyrics != null && remarkLyrics.isNotEmpty) {
      subLyricTextPaints.addAll(remarkLyrics
          .map((l) => TextPainter(
              text: TextSpan(text: l.lyric, style: remarkStyle),
              textDirection: TextDirection.ltr))
          .toList());
    }
  }

  @override
  _LyricWidgetState createState() => _LyricWidgetState();
}

class _LyricWidgetState extends State<LyricWidget> {
  LyricPainter _lyricPainter;
  double totalHeight = 0;

  @override
  void initState() {
    widget.controller.draggingComplete = () {
      cancelTimer();
      widget.controller.progress = widget.controller.draggingProgress;
      _lyricPainter.draggingLine = null;
      widget.controller.isDragging = false;
    };
    WidgetsBinding.instance.addPostFrameCallback((call) {
      totalHeight = computeScrollY(widget.lyrics.length - 1);
    });
    widget.controller.addListener(() {
      var curLine =
          findLyricIndexByDuration(widget.controller.progress, widget.lyrics);
      if (widget.controller.oldLine != curLine) {
        _lyricPainter.currentLyricIndex = curLine;
        if (!widget.controller.isDragging) {
          if (widget.controller.vsync == null) {
            _lyricPainter.offset = -computeScrollY(curLine);
          } else {
            animationScrollY(curLine, widget.controller.vsync);
          }
        }
        widget.controller.oldLine = curLine;
      }
    });
    super.initState();
  }

  ///因空行高度与非空行高度不一致，获取非空行的位置
  int getNotEmptyLineHeight(List<Lyric> lyrics) =>
      lyrics.indexOf(lyrics.firstWhere((lyric) => lyric.lyric.trim().isNotEmpty,
          orElse: () => lyrics.first));

  @override
  Widget build(BuildContext context) {
    if (widget.lyricMaxWidth == null ||
        widget.lyricMaxWidth == double.infinity) {
      widget.lyricMaxWidth = MediaQuery.of(context).size.width;
    }

    _lyricPainter = LyricPainter(
        widget.lyrics, widget.lyricTextPaints, widget.subLyricTextPaints,
        vsync: widget.controller.vsync,
        subLyrics: widget.remarkLyrics,
        lyricTextStyle: widget.lyricStyle,
        subLyricTextStyle: widget.remarkStyle,
        currLyricTextStyle: widget.currLyricStyle,
        lyricGapValue: widget.lyricGap,
        lyricMaxWidth: widget.lyricMaxWidth,
        subLyricGapValue: widget.remarkLyricGap,
        draggingLyricTextStyle: widget.draggingLyricStyle,
        draggingSubLyricTextStyle: widget.draggingRemarkLyricStyle,
        currSubLyricTextStyle: widget.currRemarkLyricStyle);
    _lyricPainter.currentLyricIndex =
        findLyricIndexByDuration(widget.controller.progress, widget.lyrics);
    if (widget.controller.isDragging) {
      _lyricPainter.draggingLine = widget.controller.draggingLine;
      _lyricPainter.offset = widget.controller.draggingOffset;
    } else {
      _lyricPainter.offset = -computeScrollY(_lyricPainter.currentLyricIndex);
    }
    return widget.enableDrag
        ? GestureDetector(
            onVerticalDragUpdate: (e) {
              cancelTimer();
              double temOffset = (_lyricPainter.offset + e.delta.dy);
              if (temOffset < 0 && temOffset >= -totalHeight) {
                widget.controller.draggingOffset = temOffset;
                widget.controller.draggingLine =
                    getCurrentDraggingLine(temOffset + widget.lyricGap);
                _lyricPainter.draggingLine = widget.controller.draggingLine;
                widget.controller.draggingProgress =
                    widget.lyrics[widget.controller.draggingLine].startTime +
                        Duration(milliseconds: 1);
                widget.controller.isDragging = true;
                _lyricPainter.offset = temOffset;
              }
            },
            onVerticalDragEnd: (e) {
              cancelTimer();
              widget.controller.draggingTimer = Timer(
                  widget.controller.draggingTimerDuration ??
                      Duration(seconds: 3), () {
                resetDragging();
              });
            },
            child: buildCustomPaint(),
          )
        : buildCustomPaint();
  }

  CustomPaint buildCustomPaint() {
    return CustomPaint(
      painter: _lyricPainter,
      size: widget.size,
    );
  }

  void resetDragging() {
    _lyricPainter.currentLyricIndex =
        findLyricIndexByDuration(widget.controller.progress, widget.lyrics);

    widget.controller.previousRowOffset = -widget.controller.draggingOffset;
    animationScrollY(_lyricPainter.currentLyricIndex, widget.controller.vsync);
    _lyricPainter.draggingLine = null;
    widget.controller.isDragging = false;
  }

  int getCurrentDraggingLine(double offset) {
    for (int i = 0; i < widget.lyrics.length; i++) {
      var scrollY = computeScrollY(i);
      if (offset > -1) {
        offset = 0;
      }
      if (offset >= -scrollY) {
        return i;
      }
    }
    return widget.lyrics.length;
  }

  void cancelTimer() {
    if (widget.controller.draggingTimer != null) {
      if (widget.controller.draggingTimer.isActive) {
        widget.controller.draggingTimer.cancel();
        widget.controller.draggingTimer = null;
      }
    }
  }

  animationScrollY(currentLyricIndex, TickerProvider tickerProvider) {
    var animationController = widget.controller.animationController;
    if (animationController != null) {
      animationController.stop();
    }
    animationController = AnimationController(
        vsync: tickerProvider, duration: Duration(milliseconds: 300))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.dispose();
          animationController = null;
        }
      });
    // 计算当前行偏移量
    var currentRowOffset = computeScrollY(currentLyricIndex);
    //如果偏移量相同不执行动画
    if (currentRowOffset == widget.controller.previousRowOffset) {
      return;
    }
    // 起始为上一行，结束点为当前行
    Animation animation = Tween<double>(
            begin: widget.controller.previousRowOffset, end: currentRowOffset)
        .animate(animationController);
    widget.controller.previousRowOffset = currentRowOffset;
    animationController.addListener(() {
      _lyricPainter.offset = -animation.value;
    });
    animationController.forward();
  }

  //根据当前时长获取歌词位置
  int findLyricIndexByDuration(Duration curDuration, List<Lyric> lyrics) {
    for (int i = 0; i < lyrics.length; i++) {
      if (curDuration >= lyrics[i].startTime &&
          curDuration <= lyrics[i].endTime) {
        return i;
      }
    }
    return 0;
  }

  /// 计算传入行和第一行的偏移量
  double computeScrollY(int curLine) {
    double totalHeight = 0;
    for (var i = 0; i < curLine; i++) {
      var currPaint = widget.lyricTextPaints[i]
        ..text =
            TextSpan(text: widget.lyrics[i].lyric, style: widget.lyricStyle);
      currPaint.layout(maxWidth: widget.lyricMaxWidth);
      totalHeight += currPaint.height + widget.lyricGap;
    }
    if (widget.remarkLyrics != null) {
      //增加 当前行之前的翻译歌词的偏移量
      widget.remarkLyrics
          .where(
              (subLyric) => subLyric.endTime <= widget.lyrics[curLine].endTime)
          .toList()
          .forEach((subLyric) {
        var currentPaint = widget
            .subLyricTextPaints[widget.remarkLyrics.indexOf(subLyric)]
          ..text = TextSpan(text: subLyric.lyric, style: widget.remarkStyle);
        currentPaint.layout(maxWidth: widget.lyricMaxWidth);
        ;
        totalHeight += widget.remarkLyricGap + currentPaint.height;
      });
    }
    return totalHeight;
  }
}
