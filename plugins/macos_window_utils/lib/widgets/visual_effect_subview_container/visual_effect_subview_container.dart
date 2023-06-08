import 'package:flutter/widgets.dart';
import 'package:macos_window_utils/macos_window_utils.dart';

import 'visual_effect_subview_container_resize_event_relay.dart';
import 'visual_effect_subview_container_with_global_key.dart';

/// A container that applies a visual effect subview to its content
class VisualEffectSubviewContainer extends StatefulWidget {
  final Widget child;
  final double alphaValue;
  final double? cornerRadius;
  final int cornerMask;
  final NSVisualEffectViewMaterial material;
  final NSVisualEffectViewState state;
  final EdgeInsets padding;
  final VisualEffectSubviewContainerResizeEventRelay? resizeEventRelay;

  static const topLeftCorner =
      VisualEffectSubviewContainerWithGlobalKey.topLeftCorner;
  static const topRightCorner =
      VisualEffectSubviewContainerWithGlobalKey.topRightCorner;
  static const bottomRightCorner =
      VisualEffectSubviewContainerWithGlobalKey.bottomRightCorner;
  static const bottomLeftCorner =
      VisualEffectSubviewContainerWithGlobalKey.bottomLeftCorner;

  /// Creates a [VisualEffectSubviewContainer].
  ///
  /// The [alphaValue] is applied to the visual effect subview. It does not
  /// affect the opacity of the [child]. Similarly, the [padding] only affects
  /// the subview, and does not affect the [child] either.
  ///
  /// The [cornerRadius] argument specifies the radius of the visual effect
  /// view's corners. Which corners are affected is dependent on the
  /// [cornerMask] argument.
  ///
  /// Usage example:
  ///
  /// ```dart
  /// VisualEffectSubviewContainer(
  ///   material: NSVisualEffectViewMaterial.hudWindow,
  ///   cornerRadius: 32.0,
  ///   cornerMask: VisualEffectSubviewContainer.topLeftCorner +
  ///       VisualEffectSubviewContainer.topRightCorner +
  ///       VisualEffectSubviewContainer.bottomRightCorner,
  ///   child: Container(width: 128.0, height: 128.0),
  /// );
  /// ```
  ///
  /// By default, a [VisualEffectSubviewContainer] updates its visual effect
  /// view whenever its [build] method runs. If manual control over its update
  /// behavior is desired, it can be supplied a
  /// [VisualEffectSubviewContainerResizeEventRelay] through which its update
  /// behavior can be controlled manually.
  const VisualEffectSubviewContainer(
      {Key? key,
      required this.child,
      this.alphaValue = 1.0,
      this.cornerRadius,
      this.cornerMask = 0xf,
      required this.material,
      this.state = NSVisualEffectViewState.followsWindowActiveState,
      this.padding = EdgeInsets.zero,
      this.resizeEventRelay})
      : super(key: key);

  @override
  State<VisualEffectSubviewContainer> createState() =>
      _VisualEffectSubviewContainerState();
}

class _VisualEffectSubviewContainerState
    extends State<VisualEffectSubviewContainer> {
  final _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return VisualEffectSubviewContainerWithGlobalKey(
      key: _globalKey,
      child: widget.child,
      alphaValue: widget.alphaValue,
      cornerRadius: widget.cornerRadius,
      cornerMask: widget.cornerMask,
      material: widget.material,
      state: widget.state,
      padding: widget.padding,
      resizeEventRelay: widget.resizeEventRelay,
    );
  }
}
