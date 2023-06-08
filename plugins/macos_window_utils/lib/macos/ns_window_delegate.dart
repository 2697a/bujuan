import 'dart:ui';

/// A set of optional methods that a window’s delegate can implement to respond
/// to events, such as window resizing, moving, exposing, and minimizing.
///
/// Please note that `enableWindowDelegate` needs to be set to true in the
/// [WindowManipulator.initialize] call for this class to work.
///
/// Example:
/// ```dart
/// // Class definition.
/// class _MyDelegate extends NSWindowDelegate {
///   @override
///   void windowDidEnterFullScreen() {
///     print('The window has entered fullscreen mode.');
///
///     super.windowDidEnterFullScreen();
///   }
/// }
///
/// // Adding the delegate.
/// final delegate = _MyDelegate();
/// final handle = WindowManipulator.addNSWindowDelegate(delegate);
/// ...
/// handle.removeFromHandler();
/// ```
abstract class NSWindowDelegate {
  // === Managing Sheets ===

  /// Notifies the delegate that the window is about to open a sheet.
  void windowWillBeginSheet() {}

  /// Tells the delegate that the window has closed a sheet.
  void windowDidEndSheet() {}

  // === Sizing Windows ===

  /// Tells the delegate that the window is being resized (whether by the user
  /// or through one of the `setFrame...` methods other than
  /// `setFrame(_:display:)`).
  void windowWillResize({required Size to}) {}

  /// Tells the delegate that the window has been resized.
  void windowDidResize() {}

  /// Tells the delegate that the window is about to be live resized.
  void windowWillStartLiveResize() {}

  /// Tells the delegate that a live resize operation on the window has ended.
  void windowDidEndLiveResize() {}

  // === Minimizing Windows ===

  /// Tells the delegate that the window is about to be minimized.
  void windowWillMiniaturize() {}

  /// Tells the delegate that the window has been minimized.
  void windowDidMiniaturize() {}

  /// Tells the delegate that the window has been deminimized.
  void windowDidDeminiaturize() {}

  // === Zooming Window ===

  /// Called by NSWindow’s `zoom(_:)` method while determining the frame a
  /// window may be zoomed to.
  void windowWillUseStandardFrame({required Rect defaultFrame}) {}

  /// Asks the delegate whether the specified window should zoom to the
  /// specified frame.
  void windowShouldZoom({required Rect toFrame}) {}

  // === Managing Full-Screen Presentation ===

  /// The window is about to enter full-screen mode.
  void windowWillEnterFullScreen() {}

  /// The window has entered full-screen mode.
  void windowDidEnterFullScreen() {}

  /// The window is about to exit full-screen mode.
  void windowWillExitFullScreen() {}

  /// The window has left full-screen mode.
  void windowDidExitFullScreen() {}

  // === Custom Full-Screen Presentation Animations ===

  // not implemented

  // === Moving Windows ===

  /// Tells the delegate that the window is about to move.
  void windowWillMove() {}

  /// Tells the delegate that the window has moved.
  void windowDidMove() {}

  /// Tells the delegate that the window has changed screens.
  void windowDidChangeScreen() {}

  /// Tells the delegate that the window has changed screen display profiles.
  void windowDidChangeScreenProfile() {}

  /// Tells the delegate that the window backing properties changed.
  void windowDidChangeBackingProperties() {}

  // === Closing Windows ===

  /// Tells the delegate that the user has attempted to close a window or the
  /// window has received a `performClose(_:)` message.
  void windowShouldClose() {}

  /// Tells the delegate that the window is about to close.
  void windowWillClose() {}

  // === Managing Key Status ===

  /// Tells the delegate that the window has become the key window.
  void windowDidBecomeKey() {}

  /// Tells the delegate that the window has resigned key window status.
  void windowDidResignKey() {}

  // === Managing Main Status ===

  /// Tells the delegate that the window has become main.
  void windowDidBecomeMain() {}

  /// Tells the delegate that the window has resigned main window status.
  void windowDidResignMain() {}

  // === Managing Field Editors ===

  // not implemented

  // Updating Windows

  // not implemented

  // === Exposing Windows ===

  /// Tells the delegate that the window has been exposed.
  void windowDidExpose() {}

  // === Managing Occlusion State ===

  /// Tells the delegate that the window changed its occlusion state.
  void windowDidChangeOcclusionState() {}

  // === Dragging Windows ===

  // not implemented

  // === Getting the Undo Manager ===

  // not implemented

  // === Managing Titles ===

  // not implemented

  // === Managing Restorable State ===

  // not implemented

  // === Managing Presentation in Version Browsers ===

  /// Tells the delegate the window is about to enter version browsing.
  void windowWillEnterVersionBrowser() {}

  /// Tells the delegate that the window has entered version browsing.
  void windowDidEnterVersionBrowser() {}

  /// Tells the delegate that the window is about to leave version browsing.
  void windowWillExitVersionBrowser() {}

  /// Tells the delegate that the window has left version browsing.
  void windowDidExitVersionBrowser() {}
}
