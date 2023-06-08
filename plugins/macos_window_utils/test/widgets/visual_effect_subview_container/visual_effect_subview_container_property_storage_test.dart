import 'package:macos_window_utils/macos_window_utils.dart';
import 'package:macos_window_utils/widgets/visual_effect_subview_container/visual_effect_subview_container_property_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'visual effect subview container property storage frame size change test',
      (tester) async {
    final storage = VisualEffectSubviewContainerPropertyStorage();
    storage.updateProperties(VisualEffectSubviewProperties(
      frameWidth: 1.0,
      frameHeight: 1.0,
      frameX: 0.0,
      frameY: 0.0,
    ));

    final delta0 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      frameWidth: 2.0,
      frameHeight: 1.0,
      frameX: 0.0,
      frameY: 0.0,
    ));

    // On the Swift side, the frame size is represented by an `NSSize` object.
    // For this reason, even if only one metric changes, both metrics will need
    // to be transmitted, so that an `NSSize` object can be created.
    expect(
        delta0,
        VisualEffectSubviewProperties(
          frameWidth: 2.0,
          frameHeight: 1.0,
        ));

    final delta1 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      frameWidth: 1.0,
      frameHeight: 2.0,
      frameX: 0.0,
      frameY: 0.0,
    ));

    expect(
        delta1,
        VisualEffectSubviewProperties(
          frameWidth: 1.0,
          frameHeight: 2.0,
        ));

    final delta2 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      frameWidth: 2.0,
      frameHeight: 2.0,
      frameX: 0.0,
      frameY: 0.0,
    ));

    expect(
        delta2,
        VisualEffectSubviewProperties(
          frameWidth: 2.0,
          frameHeight: 2.0,
        ));
  });

  testWidgets(
      'visual effect subview container property storage frame position change test',
      (tester) async {
    final storage = VisualEffectSubviewContainerPropertyStorage();
    storage.updateProperties(VisualEffectSubviewProperties(
      frameWidth: 1.0,
      frameHeight: 1.0,
      frameX: 0.0,
      frameY: 0.0,
    ));

    final delta0 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      frameWidth: 1.0,
      frameHeight: 1.0,
      frameX: 1.0,
      frameY: 0.0,
    ));

    // On the Swift side, the frame position is represented by an `NSPoint`
    // object. For this reason, even if only one value changes, both values will
    // need to be transmitted, so that an `NSPoint` object can be created.
    expect(
        delta0,
        VisualEffectSubviewProperties(
          frameX: 1.0,
          frameY: 0.0,
        ));

    final delta1 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      frameWidth: 1.0,
      frameHeight: 1.0,
      frameX: 0.0,
      frameY: 1.0,
    ));

    expect(
        delta1,
        VisualEffectSubviewProperties(
          frameX: 0.0,
          frameY: 1.0,
        ));

    final delta2 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      frameWidth: 1.0,
      frameHeight: 1.0,
      frameX: 1.0,
      frameY: 1.0,
    ));

    expect(
        delta2,
        VisualEffectSubviewProperties(
          frameX: 1.0,
          frameY: 1.0,
        ));
  });

  testWidgets(
      'visual effect subview container property storage alpha value change test',
      (tester) async {
    final storage = VisualEffectSubviewContainerPropertyStorage();
    storage.updateProperties(VisualEffectSubviewProperties(
      alphaValue: 1.0,
    ));

    final delta = storage.getDeltaProperties(VisualEffectSubviewProperties(
      alphaValue: 0.0,
    ));

    expect(delta, VisualEffectSubviewProperties(alphaValue: 0.0));
  });

  testWidgets(
      'visual effect subview container property storage corner change test',
      (tester) async {
    final storage = VisualEffectSubviewContainerPropertyStorage();
    storage.updateProperties(VisualEffectSubviewProperties(
      cornerRadius: 0.0,
    ));

    final delta0 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      cornerRadius: 1.0,
    ));

    expect(
        delta0,
        VisualEffectSubviewProperties(
          cornerRadius: 1.0,
        ));

    final delta1 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      cornerRadius: 1.0,
      cornerMask: 0xa,
    ));

    expect(
        delta1,
        VisualEffectSubviewProperties(
          cornerRadius: 1.0,
          cornerMask: 0xa,
        ));

    final delta2 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      cornerRadius: 0.0,
      cornerMask: 0xa,
    ));

    expect(
        delta2,
        VisualEffectSubviewProperties(
          cornerMask: 0xa,
        ));
  });

  testWidgets(
      'visual effect subview container property storage effect change test',
      (tester) async {
    final storage = VisualEffectSubviewContainerPropertyStorage();
    storage.updateProperties(VisualEffectSubviewProperties(
      material: NSVisualEffectViewMaterial.windowBackground,
    ));

    final delta0 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      material: NSVisualEffectViewMaterial.windowBackground,
    ));

    expect(delta0, VisualEffectSubviewProperties());

    final delta1 = storage.getDeltaProperties(VisualEffectSubviewProperties(
      material: NSVisualEffectViewMaterial.sidebar,
    ));

    expect(
        delta1,
        VisualEffectSubviewProperties(
          material: NSVisualEffectViewMaterial.sidebar,
        ));
  });
}
