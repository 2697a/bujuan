import 'package:flutter_test/flutter_test.dart';
import 'package:macos_window_utils/macos/ns_app_presentation_options.dart';

void main() {
  testWidgets('ns app presentation options from set', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.fullScreen,
      NSAppPresentationOption.hideMenuBar,
      NSAppPresentationOption.hideDock,
    });

    expect(
        options.containsAll({
          NSAppPresentationOption.fullScreen,
          NSAppPresentationOption.hideMenuBar,
          NSAppPresentationOption.hideDock,
        }),
        true);

    expect(options.contains(NSAppPresentationOption.disableForceQuit), false);
  });

  testWidgets('ns app presentation options insert/remove', (tester) async {
    var options = NSAppPresentationOptions.from({
      NSAppPresentationOption.fullScreen,
      NSAppPresentationOption.hideMenuBar,
      NSAppPresentationOption.hideDock,
    });

    options = options.remove(NSAppPresentationOption.hideDock);
    options = options.insert(NSAppPresentationOption.autoHideDock);

    expect(
        options.containsAll({
          NSAppPresentationOption.fullScreen,
          NSAppPresentationOption.hideMenuBar,
          NSAppPresentationOption.autoHideDock,
        }),
        true);

    expect(options.contains(NSAppPresentationOption.hideDock), false);
  });

  testWidgets('ns app presentation options assertion 1', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.autoHideDock,
      NSAppPresentationOption.hideDock
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 2', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.autoHideMenuBar,
      NSAppPresentationOption.hideMenuBar,
      NSAppPresentationOption.hideDock,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 3', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.hideMenuBar,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 4', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.disableProcessSwitching,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 5', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.disableProcessSwitching,
      NSAppPresentationOption.hideDock,
    });

    expect(options.assertRestrictions, returnsNormally);
  });

  testWidgets('ns app presentation options assertion 6', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.disableProcessSwitching,
      NSAppPresentationOption.autoHideDock,
    });

    expect(options.assertRestrictions, returnsNormally);
  });

  testWidgets('ns app presentation options assertion 7', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.disableForceQuit,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 8', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.disableSessionTermination,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 9', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.disableMenuBarTransparency,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 10', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.autoHideToolbar,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 11', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.autoHideToolbar,
      NSAppPresentationOption.fullScreen,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 12', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.autoHideToolbar,
      NSAppPresentationOption.autoHideMenuBar,
    });

    expect(options.assertRestrictions, throwsAssertionError);
  });

  testWidgets('ns app presentation options assertion 13', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.autoHideToolbar,
      NSAppPresentationOption.fullScreen,
      NSAppPresentationOption.autoHideMenuBar,
      NSAppPresentationOption.hideDock,
    });

    expect(options.assertRestrictions, returnsNormally);
  });

  testWidgets('ns app presentation options assertion 14', (tester) async {
    final options = NSAppPresentationOptions.from({
      NSAppPresentationOption.autoHideToolbar,
      NSAppPresentationOption.autoHideMenuBar,
      NSAppPresentationOption.fullScreen,
      NSAppPresentationOption.autoHideDock,
      NSAppPresentationOption.disableAppleMenu,
    });

    expect(options.assertRestrictions, returnsNormally);
  });
}
