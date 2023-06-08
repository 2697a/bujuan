import 'package:flutter/services.dart';
import 'package:macos_window_utils/macos/ns_window_delegate.dart';
import 'package:macos_window_utils/ns_window_delegate_handler/ns_window_delegate_handle.dart';

export 'package:macos_window_utils/ns_window_delegate_handler/ns_window_delegate_handle.dart';

/// A class that handles [NSWindowDelegate]s and their appropriate method
/// channel.
class NSWindowDelegateHandler {
  final channel = const MethodChannel('macos_window_utils/ns_window_delegate');
  final delegates = <NSWindowDelegateHandle, NSWindowDelegate>{};

  NSWindowDelegateHandler() {
    channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case "windowWillBeginSheet":
          for (final delegate in delegates.values) {
            delegate.windowWillBeginSheet();
          }
          return null;

        case "windowDidEndSheet":
          for (final delegate in delegates.values) {
            delegate.windowDidEndSheet();
          }
          return null;

        case "windowWillResize":
          for (final delegate in delegates.values) {
            final to = _getSizeFromArguments(call.arguments);
            delegate.windowWillResize(to: to);
          }
          return null;

        case "windowDidResize":
          for (final delegate in delegates.values) {
            delegate.windowDidResize();
          }
          return null;

        case "windowWillStartLiveResize":
          for (final delegate in delegates.values) {
            delegate.windowWillStartLiveResize();
          }
          return null;

        case "windowDidEndLiveResize":
          for (final delegate in delegates.values) {
            delegate.windowDidEndLiveResize();
          }
          return null;

        case "windowWillMiniaturize":
          for (final delegate in delegates.values) {
            delegate.windowWillMiniaturize();
          }
          return null;

        case "windowDidMiniaturize":
          for (final delegate in delegates.values) {
            delegate.windowDidMiniaturize();
          }
          return null;

        case "windowDidDeminiaturize":
          for (final delegate in delegates.values) {
            delegate.windowDidDeminiaturize();
          }
          return null;

        case "windowWillUseStandardFrame":
          for (final delegate in delegates.values) {
            final defaultFrame = _getRectFromArguments(call.arguments);
            delegate.windowWillUseStandardFrame(defaultFrame: defaultFrame);
          }
          return null;

        case "windowShouldZoom":
          for (final delegate in delegates.values) {
            final toFrame = _getRectFromArguments(call.arguments);
            delegate.windowShouldZoom(toFrame: toFrame);
          }
          return null;

        case "windowWillEnterFullScreen":
          for (final delegate in delegates.values) {
            delegate.windowWillEnterFullScreen();
          }
          return null;

        case "windowDidEnterFullScreen":
          for (final delegate in delegates.values) {
            delegate.windowDidEnterFullScreen();
          }
          return null;

        case "windowWillExitFullScreen":
          for (final delegate in delegates.values) {
            delegate.windowWillExitFullScreen();
          }
          return null;

        case "windowDidExitFullScreen":
          for (final delegate in delegates.values) {
            delegate.windowDidExitFullScreen();
          }
          return null;

        case "windowWillMove":
          for (final delegate in delegates.values) {
            delegate.windowWillMove();
          }
          return null;

        case "windowDidMove":
          for (final delegate in delegates.values) {
            delegate.windowDidMove();
          }
          return null;

        case "windowDidChangeScreen":
          for (final delegate in delegates.values) {
            delegate.windowDidChangeScreen();
          }
          return null;

        case "windowDidChangeScreenProfile":
          for (final delegate in delegates.values) {
            delegate.windowDidChangeScreenProfile();
          }
          return null;

        case "windowDidChangeBackingProperties":
          for (final delegate in delegates.values) {
            delegate.windowDidChangeBackingProperties();
          }
          return null;

        case "windowShouldClose":
          for (final delegate in delegates.values) {
            delegate.windowShouldClose();
          }
          return null;

        case "windowWillClose":
          for (final delegate in delegates.values) {
            delegate.windowWillClose();
          }
          return null;

        case "windowDidBecomeKey":
          for (final delegate in delegates.values) {
            delegate.windowDidBecomeKey();
          }
          return null;

        case "windowDidResignKey":
          for (final delegate in delegates.values) {
            delegate.windowDidResignKey();
          }
          return null;

        case "windowDidBecomeMain":
          for (final delegate in delegates.values) {
            delegate.windowDidBecomeMain();
          }
          return null;

        case "windowDidResignMain":
          for (final delegate in delegates.values) {
            delegate.windowDidResignMain();
          }
          return null;

        case "windowDidExpose":
          for (final delegate in delegates.values) {
            delegate.windowDidExpose();
          }
          return null;

        case "windowDidChangeOcclusionState":
          for (final delegate in delegates.values) {
            delegate.windowDidChangeOcclusionState();
          }
          return null;

        case "windowWillEnterVersionBrowser":
          for (final delegate in delegates.values) {
            delegate.windowWillEnterVersionBrowser();
          }
          return null;

        case "windowDidEnterVersionBrowser":
          for (final delegate in delegates.values) {
            delegate.windowDidEnterVersionBrowser();
          }
          return null;

        case "windowWillExitVersionBrowser":
          for (final delegate in delegates.values) {
            delegate.windowWillExitVersionBrowser();
          }
          return null;

        case "windowDidExitVersionBrowser":
          for (final delegate in delegates.values) {
            delegate.windowDidExitVersionBrowser();
          }
          return null;
      }

      return null;
    });
  }

  Size _getSizeFromArguments(dynamic arguments) {
    final map = Map<String, double>.from(arguments);
    final width = map['width']!;
    final height = map['height']!;
    return Size(width, height);
  }

  Rect _getRectFromArguments(dynamic arguments) {
    final map = Map<String, double>.from(arguments);
    final x = map['x']!;
    final y = map['y']!;
    final w = map['w']!;
    final h = map['h']!;
    return Offset(x, y) & Size(w, h);
  }

  /// Adds a delegate to this [NSWindowDelegateHandler].
  ///
  /// Returns a [NSWindowDelegateHandle] which can be used to remove the
  /// delegate from this handler.
  ///
  /// Example:
  /// ```dart
  /// final someDelegate = ...
  /// final handler = NSWindowDelegateHandler();
  /// final handle = handler.addDelegate(someDelegate);
  /// ...
  /// handle.removeFromHandler();
  /// ```
  NSWindowDelegateHandle addDelegate(NSWindowDelegate delegate) {
    final handle = NSWindowDelegateHandle.create(this);
    delegates[handle] = delegate;
    return handle;
  }

  /// Removes the [handle]'s delegate from this [NSWindowDelegateHandler].
  void removeDelegate(NSWindowDelegateHandle handle) {
    delegates.remove(handle);
  }
}
