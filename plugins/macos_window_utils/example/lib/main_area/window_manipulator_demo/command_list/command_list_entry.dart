import 'dart:async';

import 'package:flutter/cupertino.dart';

import 'command.dart';

class CommandListEntry extends StatefulWidget {
  const CommandListEntry(
      {super.key,
      required this.index,
      required this.selectedIndex,
      required this.command,
      required this.select});

  final int index;
  final int selectedIndex;
  final Command command;
  final void Function() select;

  @override
  State<CommandListEntry> createState() => _CommandListEntryState();
}

class _CommandListEntryState extends State<CommandListEntry> {
  final GlobalKey _globalKey = GlobalKey();

  bool get _isSelected => widget.index == widget.selectedIndex;

  TextStyle _getTextStyle({required BuildContext context}) {
    if (_isSelected) {
      return DefaultTextStyle.of(context)
          .style
          .copyWith(color: const Color.fromRGBO(255, 255, 255, 1.0));
    }

    return DefaultTextStyle.of(context).style;
  }

  Color _getBackgroundColor({required bool isIndexOdd}) {
    if (_isSelected) return const Color.fromRGBO(42, 98, 217, 1.0);
    if (isIndexOdd) return const Color.fromRGBO(128, 128, 128, 0.15);
    return const Color.fromRGBO(128, 128, 128, 0.0);
  }

  void _ensureVisible() {
    final currentContext = _globalKey.currentContext;

    if (currentContext == null) {
      return;
    }

    Scrollable.ensureVisible(currentContext,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtStart);
    Scrollable.ensureVisible(currentContext,
        alignmentPolicy: ScrollPositionAlignmentPolicy.keepVisibleAtEnd);
  }

  @override
  void initState() {
    // Run `_ensureVisible` using a Timer to make sure that it is run after the
    // widget has been built.
    if (_isSelected) {
      Timer(const Duration(), () {
        _ensureVisible();
      });
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isSelected) {
      _ensureVisible();
    }

    return GestureDetector(
      onTap: _isSelected ? widget.command.function : widget.select,
      child: Container(
        key: _globalKey,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: _getBackgroundColor(isIndexOdd: widget.index.isOdd)),
        child: Text(
          widget.command.name,
          softWrap: false,
          overflow: TextOverflow.ellipsis,
          style: _getTextStyle(
            context: context,
          ),
        ),
      ),
    );
  }
}
