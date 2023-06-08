import 'package:example/main_area/ns_window_delegate_demo/ns_window_delegate_event.dart';
import 'package:flutter/widgets.dart';
import 'package:macos_window_utils/macos/ns_window_delegate.dart';

import 'ns_window_delegate_event_handler.dart';

/// A [NSWindowDelegate] that adds [NSWindowDelegateEvent]s to a given
/// [NSWindowDelegateEventHandler] as they occur.
class EventDelegate extends NSWindowDelegate {
  /// Creates an [EventDelegate].
  EventDelegate({required this.eventHandler});

  /// The [NSWindowDelegateEventHandler] to add events to.
  final NSWindowDelegateEventHandler eventHandler;

  @override
  void windowWillBeginSheet() {
    final event = NSWindowDelegateEvent(name: 'windowWillBeginSheet');
    eventHandler.addEvent(event);

    super.windowWillBeginSheet();
  }

  @override
  void windowDidEndSheet() {
    final event = NSWindowDelegateEvent(name: 'windowDidEndSheet');
    eventHandler.addEvent(event);

    super.windowDidEndSheet();
  }

  @override
  void windowWillResize({required Size to}) {
    final event = NSWindowDelegateEvent(name: 'windowWillResize (to: $to)');
    eventHandler.addEvent(event);

    super.windowWillResize(to: to);
  }

  @override
  void windowDidResize() {
    final event = NSWindowDelegateEvent(name: 'windowDidResize');
    eventHandler.addEvent(event);

    super.windowDidResize();
  }

  @override
  void windowWillStartLiveResize() {
    final event = NSWindowDelegateEvent(name: 'windowWillStartLiveResize');
    eventHandler.addEvent(event);

    super.windowWillStartLiveResize();
  }

  @override
  void windowDidEndLiveResize() {
    final event = NSWindowDelegateEvent(name: 'windowDidEndLiveResize');
    eventHandler.addEvent(event);

    super.windowDidEndLiveResize();
  }

  @override
  void windowWillMiniaturize() {
    final event = NSWindowDelegateEvent(name: 'windowWillMiniaturize');
    eventHandler.addEvent(event);

    super.windowWillMiniaturize();
  }

  @override
  void windowDidMiniaturize() {
    final event = NSWindowDelegateEvent(name: 'windowDidMiniaturize');
    eventHandler.addEvent(event);

    super.windowDidMiniaturize();
  }

  @override
  void windowDidDeminiaturize() {
    final event = NSWindowDelegateEvent(name: 'windowDidDeminiaturize');
    eventHandler.addEvent(event);

    super.windowDidDeminiaturize();
  }

  @override
  void windowWillUseStandardFrame({required Rect defaultFrame}) {
    final event = NSWindowDelegateEvent(
        name: 'windowWillUseStandardFrame (defaultFrame: $defaultFrame)');
    eventHandler.addEvent(event);

    super.windowWillUseStandardFrame(defaultFrame: defaultFrame);
  }

  @override
  void windowShouldZoom({required Rect toFrame}) {
    final event =
        NSWindowDelegateEvent(name: 'windowShouldZoom (toFrame: $toFrame)');
    eventHandler.addEvent(event);

    super.windowShouldZoom(toFrame: toFrame);
  }

  @override
  void windowWillEnterFullScreen() {
    final event = NSWindowDelegateEvent(name: 'windowWillEnterFullScreen');
    eventHandler.addEvent(event);

    super.windowWillEnterFullScreen();
  }

  @override
  void windowDidEnterFullScreen() {
    final event = NSWindowDelegateEvent(name: 'windowDidEnterFullScreen');
    eventHandler.addEvent(event);

    super.windowDidEnterFullScreen();
  }

  @override
  void windowWillExitFullScreen() {
    final event = NSWindowDelegateEvent(name: 'windowWillExitFullScreen');
    eventHandler.addEvent(event);

    super.windowWillExitFullScreen();
  }

  @override
  void windowDidExitFullScreen() {
    final event = NSWindowDelegateEvent(name: 'windowDidExitFullScreen');
    eventHandler.addEvent(event);

    super.windowDidExitFullScreen();
  }

  @override
  void windowWillMove() {
    final event = NSWindowDelegateEvent(name: 'windowWillMove');
    eventHandler.addEvent(event);

    super.windowWillMove();
  }

  @override
  void windowDidMove() {
    final event = NSWindowDelegateEvent(name: 'windowDidMove');
    eventHandler.addEvent(event);

    super.windowDidMove();
  }

  @override
  void windowDidChangeScreen() {
    final event = NSWindowDelegateEvent(name: 'windowDidChangeScreen');
    eventHandler.addEvent(event);

    super.windowDidChangeScreen();
  }

  @override
  void windowDidChangeScreenProfile() {
    final event = NSWindowDelegateEvent(name: 'windowDidChangeScreenProfile');
    eventHandler.addEvent(event);

    super.windowDidChangeScreenProfile();
  }

  @override
  void windowDidChangeBackingProperties() {
    final event =
        NSWindowDelegateEvent(name: 'windowDidChangeBackingProperties');
    eventHandler.addEvent(event);

    super.windowDidChangeBackingProperties();
  }

  @override
  void windowShouldClose() {
    final event = NSWindowDelegateEvent(name: 'windowShouldClose');
    eventHandler.addEvent(event);

    super.windowShouldClose();
  }

  @override
  void windowWillClose() {
    final event = NSWindowDelegateEvent(name: 'windowWillClose');
    eventHandler.addEvent(event);

    super.windowWillClose();
  }

  @override
  void windowDidBecomeKey() {
    final event = NSWindowDelegateEvent(name: 'windowDidBecomeKey');
    eventHandler.addEvent(event);

    super.windowDidBecomeKey();
  }

  @override
  void windowDidResignKey() {
    final event = NSWindowDelegateEvent(name: 'windowDidResignKey');
    eventHandler.addEvent(event);

    super.windowDidResignKey();
  }

  @override
  void windowDidBecomeMain() {
    final event = NSWindowDelegateEvent(name: 'windowDidBecomeMain');
    eventHandler.addEvent(event);

    super.windowDidBecomeMain();
  }

  @override
  void windowDidResignMain() {
    final event = NSWindowDelegateEvent(name: 'windowDidResignMain');
    eventHandler.addEvent(event);

    super.windowDidResignMain();
  }

  @override
  void windowDidExpose() {
    final event = NSWindowDelegateEvent(name: 'windowDidExpose');
    eventHandler.addEvent(event);

    super.windowDidExpose();
  }

  @override
  void windowDidChangeOcclusionState() {
    final event = NSWindowDelegateEvent(name: 'windowDidChangeOcclusionState');
    eventHandler.addEvent(event);

    super.windowDidChangeOcclusionState();
  }

  @override
  void windowWillEnterVersionBrowser() {
    final event = NSWindowDelegateEvent(name: 'windowWillEnterVersionBrowser');
    eventHandler.addEvent(event);

    super.windowWillEnterVersionBrowser();
  }

  @override
  void windowDidEnterVersionBrowser() {
    final event = NSWindowDelegateEvent(name: 'windowDidEnterVersionBrowser');
    eventHandler.addEvent(event);

    super.windowDidEnterVersionBrowser();
  }

  @override
  void windowWillExitVersionBrowser() {
    final event = NSWindowDelegateEvent(name: 'windowWillExitVersionBrowser');
    eventHandler.addEvent(event);

    super.windowWillExitVersionBrowser();
  }

  @override
  void windowDidExitVersionBrowser() {
    final event = NSWindowDelegateEvent(name: 'windowDidExitVersionBrowser');
    eventHandler.addEvent(event);

    super.windowDidExitVersionBrowser();
  }
}
