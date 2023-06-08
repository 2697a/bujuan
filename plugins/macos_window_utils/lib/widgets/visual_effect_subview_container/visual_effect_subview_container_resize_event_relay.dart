class VisualEffectSubviewContainerResizeEventRelay {
  /// If true, the [VisualEffectSubviewContainer] will not automatically trigger
  /// update events when its `build` method runs.
  final bool disableUpdateOnBuild;

  /// A resize event relay for the [VisualEffectSubviewContainer] widget.
  ///
  /// This class is used to manually relay resize events to
  /// [VisualEffectSubviewContainer] widgets. By default, a
  /// [VisualEffectSubviewContainer] widget triggers an update whenever its
  /// [build] method runs. If desired, it can be provided a
  /// [VisualEffectSubviewContainerResizeEventRelay] in order to control the
  /// container's update behavior manually. When a resize event relay is
  /// provided, calling its `onResize()` method will forcefully update the
  /// container's visual effect subview.
  VisualEffectSubviewContainerResizeEventRelay(
      {required this.disableUpdateOnBuild});

  void Function()? _forceUpdate;

  /// Registers a force update function.
  ///
  /// This method is intended to be called by the [VisualEffectSubviewContainer]
  /// widget it has been provided to and should not be called elsewhere.
  void registerForceUpdateFunction(void Function() forceUpdate) {
    _forceUpdate = forceUpdate;
  }

  /// Relays a resize event to the [VisualEffectSubviewContainer] and forcefully
  /// triggers an update of its visual effect subview.
  ///
  /// This method can also be called if other properties (such as the widget's
  /// position relative to the window) change without triggering a rebuild.
  void onResize() {
    if (_forceUpdate == null) {
      return;
    }

    _forceUpdate!();
  }
}
