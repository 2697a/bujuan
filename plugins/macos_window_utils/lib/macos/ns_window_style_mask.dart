/// Constants that specify the style of a window.
enum NSWindowStyleMask {
  /// The window displays none of the usual peripheral elements. Useful only for
  /// display or caching purposes. A window that uses
  /// `NSWindowStyleMaskBorderless` can't become key or rust, unless the value
  /// of `canBecomeKey` or `canBecomeMain` is true.
  borderless,

  /// The window displays a title bar.
  titled,

  /// The window displays a close button.
  closable,

  /// The window displays a minimize button.
  miniaturizable,

  /// The window can be resized by the user.
  resizable,

  /// This constant has no effect, because all windows that include a toolbar
  /// use the unified style.
  unifiedTitleAndToolbar,

  /// The window can appear full screen. A fullscreen window does not draw its
  /// title bar, and may have special handling for its toolbar. (This mask is
  /// automatically toggled when `toggleFullScreen(_:)` is called.)
  fullScreen,

  /// When set, the window's contentView consumes the full size of the window.
  /// Although you can combine this constant with other window style masks, it
  /// is respected only for windows with a title bar. Note that using this mask
  /// opts in to layer-backing. Use the `contentLayoutRect` or the
  /// `contentLayoutGuide` to lay out views underneath the title bar–toolbar
  /// area.
  fullSizeContentView,

  /// The window is a panel or a subclass of `NSPanel`.
  utilityWindow,

  /// The window is a document-modal panel (or a subclass of `NSPanel`).
  docModalWindow,

  /// The window is a panel or a subclass of `NSPanel` that does not activate
  /// the owning app.
  nonactivatingPanel,

  /// The window is a HUD panel.
  hudWindow,
}
