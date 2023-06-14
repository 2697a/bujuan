// fix ERROR: The name 'platformViewRegistry' is being referenced through the
// prefix 'ui', but it isn't defined in any of the libraries imported using
// that prefix.

// Reference: https://github.com/flutter/flutter/issues/41563#issuecomment-794384561

class platformViewRegistry {
  /// Shim for registerViewFactory
  /// https://github.com/flutter/engine/blob/master/lib/web_ui/lib/ui.dart#L72
  static void registerViewFactory(
      String viewTypeId, dynamic Function(int viewId) viewFactory,
      {bool isVisible = true}) {}
}
