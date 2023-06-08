import 'dart:async';

import 'package:example/main_area/ns_window_delegate_demo/event_delegate.dart';
import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event.dart';
import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event_handler.dart';
import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event_list/ns_window_delegate_event_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:macos_window_utils/macos_window_utils.dart';

class NSWindowDelegateDemo extends StatefulWidget {
  const NSWindowDelegateDemo({super.key});

  @override
  State<NSWindowDelegateDemo> createState() => _NSWindowDelegateDemoState();
}

class _NSWindowDelegateDemoState extends State<NSWindowDelegateDemo> {
  final _eventHandler = NSWindowDelegateEventHandler();
  late NSWindowDelegateHandle _delegateHandle;
  final _scrollController = ScrollController();
  late StreamSubscription<List<NSWindowDelegateEvent>> _streamSubscription;

  @override
  void initState() {
    final eventDelegate = EventDelegate(eventHandler: _eventHandler);
    _delegateHandle = WindowManipulator.addNSWindowDelegate(eventDelegate);

    _streamSubscription = _eventHandler.onChangedStream.listen((event) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });

    super.initState();
  }

  @override
  void dispose() {
    _delegateHandle.removeFromHandler();
    _streamSubscription.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: _eventHandler.onChangedStream,
        initialData: _eventHandler.events,
        builder: (context, snapshot) {
          final events = snapshot.data;

          if (events == null) {
            return Container();
          }

          return NSWindowDelegateEventList(
            events: events,
            controller: _scrollController,
          );
        },
      ),
    );
  }
}
