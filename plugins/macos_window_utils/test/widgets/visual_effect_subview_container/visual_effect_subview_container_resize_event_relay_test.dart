import 'package:macos_window_utils/widgets/visual_effect_subview_container/visual_effect_subview_container_resize_event_relay.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
      'visual effect subview container resize event relay no resize event triggered',
      (tester) async {
    final relay = VisualEffectSubviewContainerResizeEventRelay(
        disableUpdateOnBuild: false);
    relay.registerForceUpdateFunction(expectAsync0(() {}, count: 0));
  });

  testWidgets(
      'visual effect subview container resize event relay resize event triggered once',
      (tester) async {
    final relay = VisualEffectSubviewContainerResizeEventRelay(
        disableUpdateOnBuild: false);
    relay.registerForceUpdateFunction(expectAsync0(() {}, count: 1));
    relay.onResize();
  });

  testWidgets(
      'visual effect subview container resize event relay resize event triggered twice',
      (tester) async {
    final relay = VisualEffectSubviewContainerResizeEventRelay(
        disableUpdateOnBuild: false);
    relay.registerForceUpdateFunction(expectAsync0(() {}, count: 2));
    relay.onResize();
    relay.onResize();
  });
}
