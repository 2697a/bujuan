/// [TypeWriterText]'s library.
library typewritertext;

import 'dart:async';
import 'package:flutter/material.dart';

/// A simple typewriter text animation wrapper for flutter.
class TypeWriterText extends StatefulWidget {
  /// Create a wrapper widget to animate [Text] with typewriter animation.
  ///
  ///```dart
  ///const TypeWriterText(
  ///   text: Text("your text"),
  ///   duration: Duration(milliseconds:50),
  /// );
  ///```
  const TypeWriterText(
      {Key? key,
        required this.text,
        required this.duration,
        this.alignment,
        this.maintainSize = true,
        this.repeat = false,
        this.play = true})
      : super(key: key);

  ///Requires [Text] widget as it's value.
  final Text text;

  ///Repeat animation.
  ///
  ///Default value is `false`.
  final bool repeat;

  ///Define how fast text changes.
  final Duration duration;

  ///Align the text within the occupied size.
  final Alignment? alignment;

  ///To maintain occupied size of final text while animation played.
  ///
  ///Default value is `true`.
  final bool maintainSize;

  ///To set whether animation should be played or not.
  ///
  ///Default value is `true`.
  final bool? play;

  @override
  State<TypeWriterText> createState() => _TypeWriterTextState();
}

class _TypeWriterTextState extends State<TypeWriterText> {
  int index = 0;

  ///A generated list of [String] from [widget.text.data].
  List<String> get _textList => [
    for (int x = 0; x < widget.text.data!.characters.length; x++)
      widget.text.data!.characters.string.substring(0, x + 1)
  ];

  ///A [String] that displayed in [TypeWriterText] animation.
  ///
  ///Default value is empty string.
  String _textContent = "";

  /// Periodically change text
  Timer? timer;

  @override
  void initState() {
    super.initState();
    if (_textList.isNotEmpty && mounted) {
      //Set the first displayed [String] from [_textList].
      setState(() => _textContent = _textList.first);

      //Setting the displayed [String] from time to time.
      timer = Timer.periodic(widget.duration, (timer) {
        if (timer.tick >= _textList.length && widget.repeat == false) {
          //End the animation.
          timer.cancel();
        } else {
          //Set the rest [String] from [textList] to be displayed.
          if (widget.repeat == true) {
            setState(() {
              index = timer.tick ~/ _textList.length;
              int textIndex = timer.tick - _textList.length * index;
              _textContent = _textList[textIndex];
            });
          } else {
            setState(() {
              _textContent = _textList[timer.tick];
            });
          }
        }
      });
    }
  }

  @override
  void dispose() {
    if (timer?.isActive == true) timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.play == false) {
      ///If play is `false`, return original [Text].
      return widget.text;
    } else {
      ///If play is `true`, return animated text.
      return LayoutBuilder(builder: (_, constraints) {
        ///Used as a dummy final text so we can get the final width and height.
        TextPainter textPainter = TextPainter(
            locale: widget.text.locale,
            maxLines: widget.text.maxLines,
            strutStyle: widget.text.strutStyle,
            text: TextSpan(
                text: widget.text.data!,
                style: widget.text.style,
                locale: widget.text.locale,
                semanticsLabel: widget.text.semanticsLabel),
            textAlign: widget.text.textAlign ?? TextAlign.start,
            textDirection: widget.text.textDirection ?? TextDirection.ltr,
            textHeightBehavior: widget.text.textHeightBehavior,
            textScaleFactor: widget.text.textScaleFactor ?? 1.0,
            textWidthBasis: widget.text.textWidthBasis ?? TextWidthBasis.parent)
          ..layout(
              maxWidth: constraints.maxWidth, minWidth: constraints.minWidth);

        return Container(
            alignment: widget.alignment,
            width: widget.maintainSize == true ? textPainter.width : null,
            height: widget.maintainSize == true ? textPainter.height : null,
            child: Text(
              _textContent,
              key: widget.text.key,
              locale: widget.text.locale,
              maxLines: widget.text.maxLines,
              overflow: widget.text.overflow,
              semanticsLabel: widget.text.semanticsLabel,
              softWrap: widget.text.softWrap,
              strutStyle: widget.text.strutStyle,
              style: widget.text.style,
              textAlign: widget.text.textAlign,
              textDirection: widget.text.textDirection,
              textHeightBehavior: widget.text.textHeightBehavior,
              textScaleFactor: widget.text.textScaleFactor,
              textWidthBasis: widget.text.textWidthBasis,
            ));
      });
    }
  }
}