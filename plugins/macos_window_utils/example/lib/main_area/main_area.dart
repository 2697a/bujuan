import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_demo.dart';
import 'package:example/main_area/window_manipulator_demo/window_manipulator_demo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class MainArea extends StatefulWidget {
  const MainArea({super.key, required this.setState});

  final void Function(void Function()) setState;

  @override
  State<MainArea> createState() => _MainAreaState();
}

class _MainAreaState extends State<MainArea> {
  final _tabController = MacosTabController(length: 2, initialIndex: 0);

  @override
  void initState() {
    _tabController.addListener(() => setState(() {}));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8.0),
        _SegmentedControl(
          tabController: _tabController,
        ),
        Expanded(
          child: IndexedStack(
            index: _tabController.index,
            children: [
              WindowManipulatorDemo(
                setState: widget.setState,
              ),
              const NSWindowDelegateDemo(),
            ],
          ),
        ),
      ],
    );
  }
}

class _SegmentedControl extends StatelessWidget {
  const _SegmentedControl({
    required this.tabController,
  });

  final MacosTabController tabController;

  @override
  Widget build(BuildContext context) {
    return MacosSegmentedControl(
      tabs: const [
        MacosTab(
          label: 'WindowManipulator demo',
        ),
        MacosTab(
          label: 'NSWindowDelegate demo',
        ),
      ],
      controller: tabController,
    );
  }
}
