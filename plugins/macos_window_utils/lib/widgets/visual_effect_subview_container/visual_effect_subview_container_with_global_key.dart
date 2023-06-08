import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:macos_window_utils/macos_window_utils.dart';
import 'package:macos_window_utils/widgets/visual_effect_subview_container/visual_effect_subview_container_resize_event_relay.dart';

import 'visual_effect_subview_container_property_storage.dart';

class VisualEffectSubviewContainerWithGlobalKey extends StatefulWidget {
  final Widget child;
  final double alphaValue;
  final double? cornerRadius;
  final int cornerMask;
  final NSVisualEffectViewMaterial material;
  final NSVisualEffectViewState state;
  final EdgeInsets padding;
  final VisualEffectSubviewContainerResizeEventRelay? resizeEventRelay;

  static const topLeftCorner = VisualEffectSubviewProperties.topLeftCorner;
  static const topRightCorner = VisualEffectSubviewProperties.topRightCorner;
  static const bottomRightCorner =
      VisualEffectSubviewProperties.bottomRightCorner;
  static const bottomLeftCorner =
      VisualEffectSubviewProperties.bottomLeftCorner;

  /// A visual effect subview container which needs to be provided a global key.
  ///
  /// This widget is intended to be used by the [VisualEffectSubviewContainer]
  /// widget. As a user of the [macos_window_utils] package it is recommended to
  /// use that widget instead, as it takes care of the global key creation by
  /// itself.
  const VisualEffectSubviewContainerWithGlobalKey(
      {required GlobalKey key,
      required this.child,
      this.alphaValue = 1.0,
      this.cornerRadius,
      this.cornerMask = 0xf,
      required this.material,
      required this.state,
      required this.padding,
      this.resizeEventRelay})
      : super(key: key);

  @override
  State<VisualEffectSubviewContainerWithGlobalKey> createState() =>
      _VisualEffectSubviewContainerWithGlobalKeyState();
}

class _VisualEffectSubviewContainerWithGlobalKeyState
    extends State<VisualEffectSubviewContainerWithGlobalKey> {
  int? _visualEffectSubviewId;
  final _propertyStorage = VisualEffectSubviewContainerPropertyStorage();

  VisualEffectSubviewProperties _getInitialVisualEffectSubviewProperties() {
    return VisualEffectSubviewProperties(
      alphaValue: widget.alphaValue,
      cornerRadius: widget.cornerRadius,
      cornerMask: widget.cornerMask,
      material: widget.material,
    );
  }

  /// Creates a new visual effect subview and adds it to the application window.
  void _addVisualEffectSubviewToApplicationWindow() async {
    final properties = _getInitialVisualEffectSubviewProperties();
    _visualEffectSubviewId =
        await WindowManipulator.addVisualEffectSubview(properties);
    _propertyStorage.updateProperties(properties);

    // Use a timer to run this code after the [build] method has run.
    Timer(const Duration(), () {
      _updateVisualEffectSubview();
    });
  }

  /// Initializes a resize event relay, if one is provided.
  void _initializeResizeEventRelay() {
    if (widget.resizeEventRelay == null) {
      return;
    }

    widget.resizeEventRelay!.registerForceUpdateFunction(() {
      _updateVisualEffectSubview();
    });
  }

  @override
  void initState() {
    _addVisualEffectSubviewToApplicationWindow();
    _initializeResizeEventRelay();

    super.initState();
  }

  /// Removes the previously added visual effect subview from the application
  /// window.
  void _removeVisualEffectSubviewFromApplicationWindow() {
    if (_visualEffectSubviewId == null) {
      return;
    }

    WindowManipulator.removeVisualEffectSubview(_visualEffectSubviewId!);
  }

  @override
  void dispose() {
    _removeVisualEffectSubviewFromApplicationWindow();

    super.dispose();
  }

  /// Modifies the visual effect subview.
  ///
  /// This method takes the current position and size of the visual effect
  /// subview and compares the values of all of the subview's properties to
  /// their previous values. If any differences are identified, the visual
  /// effect subview will be updated on the Swift side.
  void _modifyVisualEffectSubview(
      {required double xPosition,
      required double yPosition,
      required double width,
      required double height}) {
    if (_visualEffectSubviewId == null) {
      return;
    }

    final newProperties = VisualEffectSubviewProperties(
      frameX: xPosition,
      frameY: yPosition,
      frameWidth: width,
      frameHeight: height,
      alphaValue: widget.alphaValue,
      cornerMask: widget.cornerMask,
      cornerRadius: widget.cornerRadius,
      material: widget.material,
      state: widget.state,
    );

    final delta = _propertyStorage.getDeltaProperties(newProperties);
    if (!delta.isEmpty) {
      WindowManipulator.updateVisualEffectSubviewProperties(
          _visualEffectSubviewId!, delta);
      _propertyStorage.updateProperties(newProperties);
    }
  }

  /// Determines the position and size of this widget relative to the
  /// application window and modifies the visual effect subview accordingly.
  void _updateVisualEffectSubview() {
    final renderObject = (widget.key as GlobalKey)
        .currentContext!
        .findRenderObject() as RenderBox;
    final position = renderObject.localToGlobal(Offset.zero);

    final windowHeight = MediaQuery.of(context).size.height;

    final xPosition = position.dx + widget.padding.left;
    final yPosition = windowHeight -
        renderObject.size.height -
        position.dy +
        widget.padding.bottom;
    final width =
        renderObject.size.width - widget.padding.left - widget.padding.right;
    final height =
        renderObject.size.height - widget.padding.bottom - widget.padding.top;

    _modifyVisualEffectSubview(
      xPosition: xPosition,
      yPosition: yPosition,
      width: width,
      height: height,
    );
  }

  /// Update the visual effect subview only if no resize event relay has been
  /// provided that forbids automatically updating it inside the build method.
  void _updateVisualEffectSubviewFromBuildMethodIfPermitted() {
    if (widget.resizeEventRelay != null) {
      if (widget.resizeEventRelay!.disableUpdateOnBuild) {
        return;
      }
    }

    // Use a timer to make sure this code is run outside of the [build] method
    // since retrieving this widget's render object is not possible inside it.
    Timer(const Duration(), () {
      _updateVisualEffectSubview();
    });
  }

  @override
  Widget build(BuildContext context) {
    _updateVisualEffectSubviewFromBuildMethodIfPermitted();

    return widget.child;
  }
}
