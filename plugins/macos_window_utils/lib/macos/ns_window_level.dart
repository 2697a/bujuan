/// This enum maps to the `NSWindow.Level` structure in Swift.
enum _Base {
  floating,
  mainMenu,
  modalPanel,
  normal,
  popUpMenu,
  screenSaver,
  statusBar,
  submenu,
  tornOffMenu,
}

/// A class that represents the level of an `NSWindow`.
class NSWindowLevel {
  final _Base _base;
  final int offset;

  String get baseName => _base.name;

  const NSWindowLevel._withValues(this._base, this.offset);

  /// Useful for floating palettes.
  static NSWindowLevel floating =
      const NSWindowLevel._withValues(_Base.floating, 0);

  /// Reserved for the application’s main menu.
  static NSWindowLevel mainMenu =
      const NSWindowLevel._withValues(_Base.mainMenu, 0);

  /// The level for a modal panel.
  static NSWindowLevel modalPanel =
      const NSWindowLevel._withValues(_Base.modalPanel, 0);

  /// The default level for NSWindow objects.
  static NSWindowLevel normal =
      const NSWindowLevel._withValues(_Base.normal, 0);

  /// The level for a pop-up menu.
  static NSWindowLevel popUpMenu =
      const NSWindowLevel._withValues(_Base.popUpMenu, 0);

  /// The level for a screen saver.
  static NSWindowLevel screenSaver =
      const NSWindowLevel._withValues(_Base.screenSaver, 0);

  /// The level for a status window.
  static NSWindowLevel statusBar =
      const NSWindowLevel._withValues(_Base.statusBar, 0);

  /// Reserved for submenus. Synonymous with `NSTornOffMenuWindowLevel`, which
  /// is preferred.
  static NSWindowLevel submenu =
      const NSWindowLevel._withValues(_Base.submenu, 0);

  /// The level for a torn-off menu. Synonymous with `NSSubmenuWindowLevel`.
  static NSWindowLevel tornOffMenu =
      const NSWindowLevel._withValues(_Base.tornOffMenu, 0);

  /// Returns a new instance of [NSWindowLevel] with a given offset.
  NSWindowLevel withOffset(int offset) {
    return NSWindowLevel._withValues(_base, offset);
  }
}
