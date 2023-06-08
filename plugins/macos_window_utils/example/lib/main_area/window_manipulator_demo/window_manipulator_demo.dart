import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import 'command_list/command_list.dart';
import 'command_list_provider/command_list_provider.dart';

class WindowManipulatorDemo extends StatefulWidget {
  const WindowManipulatorDemo({
    Key? key,
    required this.setState,
  }) : super(key: key);

  final void Function(void Function()) setState;

  @override
  State<WindowManipulatorDemo> createState() => _WindowManipulatorDemoState();
}

class _WindowManipulatorDemoState extends State<WindowManipulatorDemo> {
  final FocusNode _focusNode = FocusNode();
  String _searchTerm = '';
  int _selectedIndex = 0;

  List<Command> get _filteredCommands => CommandListProvider.getCommands()
      .where((Command command) =>
          command.name.toLowerCase().contains(_searchTerm.toLowerCase()))
      .toList();

  void _setSelectedIndex(int newIndex) {
    if (_filteredCommands.isEmpty) {
      _selectedIndex = 0;
      return;
    }

    _selectedIndex = newIndex.clamp(0, _filteredCommands.length - 1);
  }

  void _addToSelectedIndex(int value) {
    _setSelectedIndex(_selectedIndex + value);
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: (FocusNode _, KeyEvent event) {
        if (event is KeyDownEvent || event is KeyRepeatEvent) {
          if (event.logicalKey == LogicalKeyboardKey.arrowDown) {
            setState(() {
              _addToSelectedIndex(1);
            });

            return KeyEventResult.handled;
          }

          if (event.logicalKey == LogicalKeyboardKey.arrowUp) {
            widget.setState(() {
              _addToSelectedIndex(-1);
            });

            return KeyEventResult.handled;
          }
        }

        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.enter) {
            setState(() {
              final commands = _filteredCommands;
              final selectedCommand = commands[_selectedIndex];
              selectedCommand.function();
            });

            return KeyEventResult.handled;
          }
        }

        return KeyEventResult.ignored;
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSearchTextField(
              onChanged: (value) => setState(() {
                _setSelectedIndex(0);
                _searchTerm = value;
              }),
            ),
          ),
          Expanded(
            child: CommandList(
              selectedIndex: _selectedIndex,
              commands: _filteredCommands,
              setIndex: (int newIndex) => setState(() {
                _setSelectedIndex(newIndex);
              }),
            ),
          ),
        ],
      ),
    );
  }
}
