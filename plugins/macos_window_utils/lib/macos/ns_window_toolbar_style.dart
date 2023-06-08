/// Available toolbar styles.
enum NSWindowToolbarStyle {
  /// A style indicating that the system determines the toolbar’s appearance and
  /// location.
  automatic,

  /// A style indicating that the toolbar appears below the window title.
  expanded,

  /// A style indicating that the toolbar appears below the window title with
  /// toolbar items centered in the toolbar.
  preference,

  /// A style indicating that the toolbar appears next to the window title.
  unified,

  /// A style indicating that the toolbar appears next to the window title and
  /// with reduced margins to allow more focus on the window’s contents.
  unifiedCompact,
}
