import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event.dart';
import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event_list/ns_window_delegate_event_list_item.dart';
import 'package:flutter/cupertino.dart';

class NSWindowDelegateEventList extends StatelessWidget {
  const NSWindowDelegateEventList(
      {super.key, required this.events, required this.controller});

  final List<NSWindowDelegateEvent> events;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      itemCount: events.length,
      itemBuilder: (context, index) {
        final event = events[index];
        return NSWindowDelegateEventListItem(event: event);
      },
    );
  }
}
