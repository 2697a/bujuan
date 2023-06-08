import 'package:flutter/cupertino.dart';

import 'command.dart';
import 'command_list_entry.dart';
import 'description_box.dart';
export 'command.dart';

class CommandList extends StatelessWidget {
  const CommandList(
      {super.key,
      required this.commands,
      required this.selectedIndex,
      required this.setIndex});

  final List<Command> commands;
  final int selectedIndex;
  final void Function(int) setIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(child: _buildScrollView()),
        _buildDescriptionBox(),
      ],
    );
  }

  Widget _buildDescriptionBox() {
    if (commands.isEmpty) {
      return Container();
    }

    return SizedBox(
      width: 233.0,
      child: DescriptionBox(
        text: commands[selectedIndex].description,
      ),
    );
  }

  Widget _buildScrollView() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: commands
            .asMap()
            .map((int index, Command command) {
              final widget = CommandListEntry(
                index: index,
                selectedIndex: selectedIndex,
                command: command,
                select: () => setIndex(index),
              );

              return MapEntry(index, widget);
            })
            .values
            .toList(),
      ),
    );
  }
}
