/// Constants that control the presentation of the app, typically for
/// fullscreen apps such as games or kiosks.
enum NSAppPresentationOption {
  /// The dock is normally hidden, but automatically appears when moused near.
  autoHideDock,

  /// The dock is entirely hidden and disabled.
  hideDock,

  /// The menu bar is normally hidden, but automatically appears when moused near.
  autoHideMenuBar,

  /// The menu bar is entirely hidden and disabled.
  hideMenuBar,

  /// All Apple Menu items are disabled.
  disableAppleMenu,

  /// The process switching user interface (Command + Tab to cycle through apps) is disabled.
  disableProcessSwitching,

  /// The force quit panel (displayed by pressing Command + Option + Esc) is disabled
  disableForceQuit,

  /// The panel that shows the Restart, Shut Down, and Log Out options that are displayed as a result of pushing the power key is disabled.
  disableSessionTermination,

  /// The app’s “Hide” menu item is disabled.
  disableHideApplication,

  /// The menu bar transparency appearance is disabled.
  disableMenuBarTransparency,

  /// The app is in fullscreen mode.
  fullScreen,

  /// When in fullscreen mode the window toolbar is detached from window and hides and shows with autoHidden menuBar.
  autoHideToolbar,

  /// The behavior that allows the user to shake the mouse to locate the cursor is disabled.
  disableCursorLocationAssistance,
}
