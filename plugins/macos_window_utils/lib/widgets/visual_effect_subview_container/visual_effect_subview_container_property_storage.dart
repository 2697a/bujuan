import 'package:macos_window_utils/macos_window_utils.dart';

/// Storage for a [VisualEffectSubviewProperties] instance.
///
/// Provides methods to identify changes in said instance that need to be
/// transmitted to the
/// Swift side.
class VisualEffectSubviewContainerPropertyStorage {
  VisualEffectSubviewProperties _currentProperties =
      VisualEffectSubviewProperties();

  /// Returns which properties have changed.
  _VisualEffectSubviewContainerPropertyChange _getPropertyChange(
      VisualEffectSubviewProperties newProperties) {
    final hasFrameSizeChanged =
        newProperties.frameWidth != _currentProperties.frameWidth ||
            newProperties.frameHeight != _currentProperties.frameHeight;
    final hasFramePositionChanged =
        newProperties.frameX != _currentProperties.frameX ||
            newProperties.frameY != _currentProperties.frameY;
    final hasAlphaValueChanged =
        newProperties.alphaValue != _currentProperties.alphaValue;
    final hasCornerRadiusChanged =
        newProperties.cornerRadius != _currentProperties.cornerRadius;
    final hasCornerMaskChanged =
        newProperties.cornerMask != _currentProperties.cornerMask;
    final hasEffectChanged =
        newProperties.material != _currentProperties.material;
    final hasStateChanged = newProperties.state != _currentProperties.state;

    return _VisualEffectSubviewContainerPropertyChange(
      hasFrameSizeChanged: hasFrameSizeChanged,
      hasFramePositionChanged: hasFramePositionChanged,
      hasAlphaValueChanged: hasAlphaValueChanged,
      hasCornerRadiusChanged: hasCornerRadiusChanged,
      hasCornerMaskChanged: hasCornerMaskChanged,
      hasEffectChanged: hasEffectChanged,
      hasStateChanged: hasStateChanged,
    );
  }

  /// Returns a [VisualEffectSubviewProperties] instance in which only the
  /// fields whose values need to be transmitted to the Swift side are
  /// populated.
  ///
  /// Note that the frame's size and position are represented as an `NSSize` or
  /// an `NSPoint` object respectively. For this reason, those two properties
  /// are treated as a single value.
  VisualEffectSubviewProperties getDeltaProperties(
      VisualEffectSubviewProperties newProperties) {
    final propertyChange = _getPropertyChange(newProperties);

    double? frameWidth, frameHeight;
    if (propertyChange.hasFrameSizeChanged) {
      frameWidth = newProperties.frameWidth;
      frameHeight = newProperties.frameHeight;
    }

    double? frameX, frameY;
    if (propertyChange.hasFramePositionChanged) {
      frameX = newProperties.frameX;
      frameY = newProperties.frameY;
    }

    final alphaValue =
        propertyChange.hasAlphaValueChanged ? newProperties.alphaValue : null;
    final cornerRadius = propertyChange.hasCornerRadiusChanged
        ? newProperties.cornerRadius
        : null;
    final cornerMask =
        propertyChange.hasCornerMaskChanged ? newProperties.cornerMask : null;
    final effect =
        propertyChange.hasEffectChanged ? newProperties.material : null;
    final state = propertyChange.hasStateChanged ? newProperties.state : null;

    return VisualEffectSubviewProperties(
      frameWidth: frameWidth,
      frameHeight: frameHeight,
      frameX: frameX,
      frameY: frameY,
      alphaValue: alphaValue,
      cornerRadius: cornerRadius,
      cornerMask: cornerMask,
      material: effect,
      state: state,
    );
  }

  /// Updates the internal [VisualEffectSubviewProperties] instance.
  ///
  /// The value of a property only gets overwritten if its value in the
  /// [newProperties] object is non-null.
  void updateProperties(VisualEffectSubviewProperties newProperties) {
    _currentProperties = VisualEffectSubviewProperties(
      frameWidth: newProperties.frameWidth ?? _currentProperties.frameWidth,
      frameHeight: newProperties.frameHeight ?? _currentProperties.frameHeight,
      frameX: newProperties.frameX ?? _currentProperties.frameX,
      frameY: newProperties.frameY ?? _currentProperties.frameY,
      alphaValue: newProperties.alphaValue ?? _currentProperties.alphaValue,
      cornerRadius:
          newProperties.cornerRadius ?? _currentProperties.cornerRadius,
      cornerMask: newProperties.cornerMask ?? _currentProperties.cornerMask,
      material: newProperties.material ?? _currentProperties.material,
      state: newProperties.state ?? _currentProperties.state,
    );
  }
}

/// A change in a [VisualEffectSubviewContainer]'s
/// [VisualEffectSubviewProperties].
///
/// Each field corresponds to a property whose value may have changed.
class _VisualEffectSubviewContainerPropertyChange {
  final bool hasFrameSizeChanged;
  final bool hasFramePositionChanged;
  final bool hasAlphaValueChanged;
  final bool hasCornerRadiusChanged;
  final bool hasCornerMaskChanged;
  final bool hasEffectChanged;
  final bool hasStateChanged;

  _VisualEffectSubviewContainerPropertyChange(
      {required this.hasFrameSizeChanged,
      required this.hasFramePositionChanged,
      required this.hasAlphaValueChanged,
      required this.hasCornerRadiusChanged,
      required this.hasCornerMaskChanged,
      required this.hasEffectChanged,
      required this.hasStateChanged});
}
