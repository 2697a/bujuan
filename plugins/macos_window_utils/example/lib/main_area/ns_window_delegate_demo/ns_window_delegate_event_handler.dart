import 'dart:async';
import 'dart:collection';

import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event.dart';

/// A class that handles [NSWindowDelegateEvent]s.
class NSWindowDelegateEventHandler {
  /// A list of captured events.
  final _events = <NSWindowDelegateEvent>[];

  /// A stream controller for a stream that streams changes to [events].
  final _onChangedStreamController =
      StreamController<List<NSWindowDelegateEvent>>.broadcast();

  /// An [UnmodifiableListView] of the [NSWindowDelegateEvent]s captured by this
  /// [NSWindowDelegateEventHandler].
  List<NSWindowDelegateEvent> get events => UnmodifiableListView(_events);

  /// A stream that streams changes to [events].
  Stream<List<NSWindowDelegateEvent>> get onChangedStream =>
      _onChangedStreamController.stream;

  /// Adds a captured event to [events].
  ///
  /// If the newly added event matches the previously added event, its number of
  /// occurrences is incremented, rather than inserting a new
  /// [NSWindowDelegateEvent].
  void addEvent(NSWindowDelegateEvent event) {
    if (_events.isEmpty) {
      _events.add(event);
      _onChangedStreamController.add(events);
      return;
    }

    final lastEvent = _events.last;
    if (lastEvent.name == event.name) {
      _events.removeLast();
      final newLastEvent = lastEvent.withIncrementedNumberOfOccurrences();
      _events.add(newLastEvent);
      _onChangedStreamController.add(events);
      return;
    }

    _events.add(event);
    _onChangedStreamController.add(events);
  }
}
