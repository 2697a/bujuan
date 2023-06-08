import 'package:flutter/cupertino.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DescriptionBox extends StatelessWidget {
  const DescriptionBox({super.key, this.text});

  final String? text;

  BoxDecoration get _defaultBoxDecoration => const BoxDecoration(
        border: Border(
            left: BorderSide(
          color: Color.fromRGBO(128, 128, 128, 0.4),
        )),
      );

  EdgeInsets get _defaultPadding => const EdgeInsets.all(8.0);

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return Container(
        padding: _defaultPadding,
        decoration: _defaultBoxDecoration,
        child: const Center(
          child: Opacity(
            opacity: 0.5,
            child: Text(
              'This command has no description.',
              textAlign: TextAlign.center,
              textScaleFactor: 0.8,
              style: TextStyle(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: _defaultBoxDecoration,
      child: Markdown(
        data: text!,
        padding: _defaultPadding,
        styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
        styleSheet: MarkdownStyleSheet(
          code: const TextStyle(
            backgroundColor: Color.fromRGBO(128, 128, 128, 0.4),
          ),
        ),
      ),
    );
  }
}
