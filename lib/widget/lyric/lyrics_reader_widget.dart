import 'dart:async';

import 'package:flutter/material.dart';

import 'lyric_ui/lyric_ui.dart';
import 'lyric_ui/ui_netease.dart';
import 'lyrics_log.dart';
import 'lyrics_reader_model.dart';
import 'lyrics_reader_paint.dart';

///SelectLineBuilder
///[int] is select progress
///[VoidCallback] call VoidCallback.call(),select current
typedef SelectLineBuilder = Widget Function(int, VoidCallback);
typedef EmptyBuilder = Widget? Function();

///Lyrics Reader Widget
///[size] config widget size,default is screenWidth,screenWidth
///[ui]  config lyric style
///[position] music progress,unit is millisecond
///[selectLineBuilder] call select line widget
///[playing] if playing status is null,no highlight.
///
class LyricsReader extends StatefulWidget {
  final Size? size;
  final LyricsReaderModel? model;
  final LyricUI ui;
  final bool? playing;
  final int position;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final SelectLineBuilder? selectLineBuilder;
  final EmptyBuilder? emptyBuilder;

  @override
  State<StatefulWidget> createState() => LyricReaderState();

  LyricsReader({Key? key,
    this.position = 0,
    this.model,
    this.padding,
    this.size,
    this.selectLineBuilder,
    LyricUI? lyricUi,
    this.onTap,
    this.playing,
    this.emptyBuilder,
  }) : ui = lyricUi ?? UINetease(), super(key: key);
}

class LyricReaderState extends State<LyricsReader>
    with TickerProviderStateMixin {
  late LyricsReaderPaint lyricPaint;

  StreamController<int> centerLyricIndexStream = StreamController.broadcast();
  AnimationController? _flingController;
  AnimationController? _highlightController;
  AnimationController? _lineController;

  var mSize = Size.infinite;

  var isDrag = false;

  /// 等待恢复
  var isWait = false;

  ///缓存下lineIndex避免重复获取
  var cacheLine = -1;

  BoxConstraints? cacheBox;

  @override
  void initState() {
    super.initState();
    lyricPaint = LyricsReaderPaint(widget.model, widget.ui)
      ..centerLyricIndexChangeCall = (index) {
        centerLyricIndexStream.add(index);
      };
  }

  var isShowSelectLineWidget = false;

  ///show select line
  void setSelectLine(bool isShow) {
    if (!mounted) return;
    setState(() {
      isShowSelectLineWidget = isShow;
    });
  }

  @override
  void didUpdateWidget(covariant LyricsReader oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.size?.toString() != widget.size?.toString() ||
        oldWidget.model != widget.model ||
        oldWidget.ui != widget.ui) {
      lyricPaint.model = widget.model;
      lyricPaint.lyricUI = widget.ui;
      handleSize();
      selectLine(widget.model?.getCurrentLine(widget.position) ?? 0);
      scrollToPlayLine();
      handleHighlight();
    }
    if (oldWidget.position != widget.position) {
      selectLine(widget.model?.getCurrentLine(widget.position) ?? 0);
      if (cacheLine != lyricPaint.playingIndex) {
        lyricPaint.highlightWidth = 0;
        cacheLine = lyricPaint.playingIndex;
        handleHighlight();
        scrollToPlayLine();
      }
    }
    if (oldWidget.playing != widget.playing) {
      if (widget.playing == null) {
        lyricPaint.highlightWidth = 0;
      } else {
        if (widget.playing == true) {
          _highlightController?.forward();
        } else {
          _highlightController?.stop();
        }
      }
    }
  }

  ///select current play line
  void scrollToPlayLine() {
    safeLyricOffset(widget.model?.computeScroll(
            lyricPaint.playingIndex, lyricPaint.playingIndex, widget.ui) ??
        0);
  }

  void selectLine(int line) {
    lyricPaint.playingIndex = line;
  }

  ///update progress after verify
  safeLyricOffset(double offset) {
    if (isDrag || isWait) return;
    if (_flingController?.isAnimating == true) return;
    realUpdateOffset(offset);
  }

  void realUpdateOffset(double offset) {
    if (widget.ui.enableLineAnimation()) {
      animationOffset(offset);
    } else {
      lyricPaint.lyricOffset = offset;
    }
  }

  ///update progress use animation
  void animationOffset(double offset) {
    disposeLine();
    _lineController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    var animate = Tween<double>(
      begin: lyricPaint.lyricOffset,
      end: offset,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_lineController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          disposeLine();
        }
      });
    animate
      .addListener(() {
        var value = animate.value;
        lyricPaint.lyricOffset = value.clamp(lyricPaint.maxOffset, 0);
      });
    _lineController?.forward();
  }

  ///calculate all line draw info
  refreshLyricHeight(Size size) {
    lyricPaint.clearCache();
    widget.model?.lyrics.forEach((element) {
      var drawInfo = LyricDrawInfo()
        ..playingExtTextPainter = getTextPaint(
            element.extText, widget.ui.getPlayingExtTextStyle(),
            size: size)
        ..otherExtTextPainter = getTextPaint(
            element.extText, widget.ui.getOtherExtTextStyle(),
            size: size)
        ..playingMainTextPainter = getTextPaint(
            element.mainText, widget.ui.getPlayingMainTextStyle(),
            size: size)
        ..otherMainTextPainter = getTextPaint(
            element.mainText, widget.ui.getOtherMainTextStyle(),
            size: size);
      if (widget.ui.enableHighlight()) {
        setTextInlineInfo(drawInfo, widget.ui, element.mainText!);
        setTextSpanDrawInfo(
            widget.ui,
            element.spanList ?? element.defaultSpanList,
            TextPainter(
              textDirection: TextDirection.ltr,
            ));
      }
      element.drawInfo = drawInfo;
    });
  }

  /// 获取文本高度
  TextPainter getTextPaint(String? text, TextStyle style,
      {Size? size, TextPainter? linePaint}) {
    text ??= "";
    linePaint ??= TextPainter(
        textDirection: TextDirection.ltr,
      );
    linePaint.textAlign = lyricPaint.lyricUI.getLyricTextAligin();
    linePaint
      ..text = TextSpan(text: text, style: style.copyWith(height: 1))
      ..layout(maxWidth: (size ?? mSize).width);
    return linePaint;
  }

  void setTextInlineInfo(LyricDrawInfo drawInfo, LyricUI ui, String text) {
    var linePaint = drawInfo.playingMainTextPainter!;
    var metrics = linePaint.computeLineMetrics();
    var targetLineHeight = 0.0;
    var start = 0;
    List<LyricInlineDrawInfo> lineList = [];
    for (var element in metrics) {
      //起始偏移量X
      var startOffsetX = 0.0;
      switch (ui.getLyricTextAligin()) {
        case TextAlign.right:
          startOffsetX = linePaint.width - element.width;
          break;
        case TextAlign.center:
          startOffsetX = (linePaint.width - element.width) / 2;
          break;
        default:
          break;
      }
      var offsetX = element.width;
      switch (ui.getLyricTextAligin()) {
        case TextAlign.right:
          offsetX = linePaint.width;
          break;
        case TextAlign.center:
          offsetX = (linePaint.width - element.width) / 2 + element.width;
          break;
        default:
          break;
      }
      var end = linePaint
          .getPositionForOffset(Offset(offsetX, targetLineHeight))
          .offset;
      var lineText = text.substring(start, end);
      LyricsLog.logD("获取行内信息：第${element.lineNumber}行，内容：$lineText");
      lineList.add(LyricInlineDrawInfo()
        ..raw = lineText
        ..number = element.lineNumber
        ..width = element.width
        ..height = element.height
        ..offset = Offset(startOffsetX, targetLineHeight));
      start = end;
      targetLineHeight += element.height;
    }
    drawInfo.inlineDrawList = lineList;
  }

  ///handle widget size
  ///default screenWidth,screenWidth
  ///if outside box has limit,then select min value
  handleSize() {
    mSize = Size(cacheBox?.maxWidth ?? 0, cacheBox?.maxHeight ?? 0);
    refreshLyricHeight(mSize);
  }

  @override
  Widget build(BuildContext context) {
    return buildTouchReader(Stack(
      children: [
        buildReaderWidget(),
        if (widget.selectLineBuilder != null &&
            isShowSelectLineWidget &&
            lyricPaint.centerY != 0)
          buildSelectLineWidget()
      ],
    ));
  }

  Positioned buildSelectLineWidget() {
    return Positioned(
      top: (widget.padding?.top ?? 0),
      left: 0,
      right: 0,
      child: SizedBox(
        height: lyricPaint.centerY * 2,
        child: Center(
          child: StreamBuilder<int>(
              stream: centerLyricIndexStream.stream,
              builder: (context, snapshot) {
                var centerIndex = snapshot.data ?? 0;
                if (lyricPaint.model.isNullOrEmpty) {
                  return Container();
                }
                return widget.selectLineBuilder!.call(
                    lyricPaint.model?.lyrics[centerIndex].startTime ?? 0, () {
                  setSelectLine(false);
                  disposeFiling();
                  disposeSelectLineDelay();
                });
              }),
        ),
      ),
    );
  }

  ///build reader widget
  Container buildReaderWidget() {
    return Container(
      padding: widget.padding ?? EdgeInsets.zero,
      color: Colors.transparent,
      width: widget.size?.width,
      height: widget.size?.height,
      child: LayoutBuilder(
        builder: (c, box) {
          if (cacheBox?.toString() != box.toString()) {
            cacheBox = box;
            handleSize();
          }
          if (widget.model.isNullOrEmpty) {
            return widget.emptyBuilder?.call() ?? Container();
          }
          return CustomPaint(
            painter: lyricPaint,
            size: mSize,
          );
        },
      ),
    );
  }

  ///support touch event
  Widget buildTouchReader(child) {
    return GestureDetector(
      onVerticalDragEnd: handleDragEnd,
      onTap: widget.onTap,
      onTapDown: (event) {
        disposeSelectLineDelay();
        disposeFiling();
        isDrag = true;
      },
      onTapUp: (event) {
        isDrag = false;
        resumeSelectLineOffset();
      },
      onVerticalDragStart: (event) {
        disposeFiling();
        disposeSelectLineDelay();
        setSelectLine(true);
      },
      onVerticalDragUpdate: (event) =>
          {lyricPaint.lyricOffset += event.primaryDelta ?? 0},
      child: child,
    );
  }

  handleDragEnd(DragEndDetails event) {
    isDrag = false;
    _flingController = AnimationController.unbounded(vsync: this)
      ..addListener(() {
        if (_flingController == null) return;
        var flingOffset = _flingController!.value;
        lyricPaint.lyricOffset = flingOffset.clamp(lyricPaint.maxOffset, 0);
        if (!lyricPaint.checkOffset(flingOffset)) {
          disposeFiling();
          resumeSelectLineOffset();
          return;
        }
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed ||
            status == AnimationStatus.dismissed) {
          disposeFiling();
          resumeSelectLineOffset();
        }
      })
      ..animateWith(ClampingScrollSimulation(
        position: lyricPaint.lyricOffset,
        velocity: event.primaryVelocity ?? 0,
      ));
  }

  Timer? waitTimer;

  ///handle select line
  resumeSelectLineOffset() {
    isWait = true;
    var waitSecond = 0;
    waitTimer?.cancel();
    waitTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      waitSecond += 100;
      if (waitSecond == 400) {
        realUpdateOffset(widget.model?.computeScroll(
                lyricPaint.centerLyricIndex,
                lyricPaint.playingIndex,
                widget.ui) ??
            0);
        return;
      }
      if (waitSecond == 3000) {
        disposeSelectLineDelay();
        setSelectLine(false);
        scrollToPlayLine();
      }
    });
  }

  disposeSelectLineDelay() {
    isWait = false;
    waitTimer?.cancel();
  }

  disposeFiling() {
    _flingController?.dispose();
    _flingController = null;
  }

  disposeLine() {
    _lineController?.dispose();
    _lineController = null;
  }

  disposeHighlight() {
    _highlightController?.dispose();
    _highlightController = null;
  }

  @override
  void dispose() {
    disposeSelectLineDelay();
    disposeFiling();
    disposeLine();
    disposeHighlight();
    centerLyricIndexStream.close();
    super.dispose();
  }

  ///计算span宽度
  void setTextSpanDrawInfo(
      LyricUI ui, List<LyricSpanInfo> spanList, TextPainter painter) {
    painter.textAlign = lyricPaint.lyricUI.getLyricTextAligin();
    for (var element in spanList) {
      painter
        ..text = TextSpan(
            text: element.raw,
            style: ui.getPlayingMainTextStyle().copyWith(height: 1))
        ..layout();
      element.drawHeight = painter.height;
      element.drawWidth = painter.width;
    }
  }

  /// enable highlight animation
  /// if playing status is null,no highlight.
  void handleHighlight() {
    var lyrics = widget.model?.lyrics;
    if (!widget.ui.enableHighlight() ||
        widget.playing == null ||
        widget.model.isNullOrEmpty ||
        lyricPaint.playingIndex >= lyrics!.length) return;
    var line = lyrics[lyricPaint.playingIndex];
    var lineDuration = (line.endTime ?? 0) - (line.startTime ?? 0);
    List<TweenSequenceItem> items = [];
    var width = 0.0;
    var duration = 0;
    double? firstBegin;
    for (LyricSpanInfo element in (line.spanList ?? line.defaultSpanList)) {
      if (widget.position >= element.end) {
        width += element.drawWidth;
        duration += element.duration;
        continue;
      }
      var ratio = (widget.position - element.start) / element.duration;
      if (ratio < 0) {
        ratio = 0;
      }
      var begin = width += (ratio * element.drawWidth);
      firstBegin ??= begin;
      items.add(TweenSequenceItem(
          tween: Tween(begin: begin, end: width += element.drawWidth),
          weight: element.duration / (lineDuration - duration)));
    }
    disposeHighlight();
    if (items.isEmpty) {
      lyricPaint.highlightWidth = width;
      return;
    }
    _highlightController = AnimationController(
      duration: Duration(milliseconds: lineDuration - duration),
      vsync: this,
    );
    var animate = TweenSequence(items)
        .chain(CurveTween(curve: Curves.easeInOut))
        .animate(_highlightController!)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          disposeHighlight();
        }
      });
    animate
      .addListener(() {
        lyricPaint.highlightWidth = animate.value;
      });
    if (widget.playing == true) {
      _highlightController?.forward();
    } else {
      lyricPaint.highlightWidth = firstBegin ?? width;
    }
  }
}
