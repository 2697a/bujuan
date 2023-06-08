import 'package:macos_window_utils/macos/ns_app_presentation_option.dart';
import 'package:macos_window_utils/window_manipulator.dart';

export 'package:macos_window_utils/macos/ns_app_presentation_option.dart';

/// Constants that control the presentation of the app, typically for fullscreen
/// apps such as games or kiosks.
///
/// Please note that `enableWindowDelegate` needs to be set to true in the
/// [WindowManipulator.initialize] call for this class to work.
///
/// Usage example:
/// ```dart
/// NSAppPresentationOptions.from({
///   NSAppPresentationOption.autoHideToolbar,
///   NSAppPresentationOption.fullScreen,
///   NSAppPresentationOption.autoHideMenuBar,
///   NSAppPresentationOption.hideDock,
/// }).applyAsFullScreenPresentationOptions();
/// ```
class NSAppPresentationOptions {
  /// The options contained within this object.
  final Set<NSAppPresentationOption> options;

  /// Creates a [NSAppPresentationOptions] instance from a set.
  const NSAppPresentationOptions._fromSet(this.options);

  /// An empty [NSAppPresentationOptions] instance.
  static NSAppPresentationOptions empty =
      NSAppPresentationOptions._fromSet(const {});

  /// Creates a [NSAppPresentationOptions] instance from any collectible.
  factory NSAppPresentationOptions.from(
      Iterable<NSAppPresentationOption> iterable) {
    return NSAppPresentationOptions._fromSet(Set.from(iterable));
  }

  /// Returns a [NSAppPresentationOptions] with [option] inserted.
  NSAppPresentationOptions insert(NSAppPresentationOption option) {
    final newSet = {...options, option};
    return NSAppPresentationOptions.from(newSet);
  }

  /// Returns a [NSAppPresentationOptions] with [option] removed.
  NSAppPresentationOptions remove(NSAppPresentationOption option) {
    final newSet = options.where((element) => element != option);
    return NSAppPresentationOptions.from(newSet);
  }

  /// Returns whether this instance contains [option].
  bool contains(NSAppPresentationOption option) {
    return options.contains(option);
  }

  /// Returns whether this instance contains all [options].
  bool containsAll(Iterable<NSAppPresentationOption> options) {
    return this.options.containsAll(options);
  }

  /// Throws an assertion error if this instance violates any of the following
  /// restrictions:
  ///
  /// + `autoHideDock` and `hideDock` are mutually exclusive: You may specify
  ///   one or the other, but not both.
  /// + `autoHideMenuBar` and `hideMenuBar` are mutually exclusive: You may
  ///   specify one or the other, but not both.
  /// + If you specify `hideMenuBar`, it must be accompanied by `hideDock`.
  /// + If you specify `autoHideMenuBar`, it must be accompanied by either
  ///   `hideDock` or `autoHideDock`.
  /// + If you specify any of `disableProcessSwitching`, `disableForceQuit`,
  ///   `disableSessionTermination`, or `disableMenuBarTransparency`, it must
  ///   be accompanied by either `hideDock` or `autoHideDock`.
  /// + `autoHideToolbar` may be used only when both `fullScreen` and
  ///   `autoHideMenuBar` are also set.
  void assertRestrictions() {
    assert(
        !options.contains(NSAppPresentationOption.autoHideDock) ||
            !options.contains(NSAppPresentationOption.hideDock),
        'autoHideDock and hideDock are mutually exclusive: You may specify one '
        'or the other, but not both.');

    assert(
        !options.contains(NSAppPresentationOption.autoHideMenuBar) ||
            !options.contains(NSAppPresentationOption.hideMenuBar),
        'autoHideMenuBar and hideMenuBar are mutually exclusive: You may '
        'specify one or the other, but not both.');

    assert(
        !options.contains(NSAppPresentationOption.hideMenuBar) ||
            options.contains(NSAppPresentationOption.hideDock),
        'If you specify hideMenuBar, it must be accompanied by hideDock.');

    assert(
        !options.contains(NSAppPresentationOption.autoHideMenuBar) ||
            (options.contains(NSAppPresentationOption.hideDock) ||
                options.contains(NSAppPresentationOption.autoHideDock)),
        'If you specify autoHideMenuBar, it must be accompanied by either '
        'hideDock or autoHideDock.');

    assert(
        (!options.contains(NSAppPresentationOption.disableProcessSwitching) &&
                !options.contains(NSAppPresentationOption.disableForceQuit) &&
                !options.contains(
                    NSAppPresentationOption.disableSessionTermination) &&
                !options.contains(
                    NSAppPresentationOption.disableMenuBarTransparency)) ||
            (options.contains(NSAppPresentationOption.hideDock) ||
                options.contains(NSAppPresentationOption.autoHideDock)),
        'If you specify any of disableProcessSwitching, disableForceQuit, '
        'disableSessionTermination, or disableMenuBarTransparency, it must be '
        'accompanied by either hideDock or autoHideDock.');

    assert(
        !options.contains(NSAppPresentationOption.autoHideToolbar) ||
            (options.contains(NSAppPresentationOption.fullScreen) &&
                options.contains(NSAppPresentationOption.autoHideMenuBar)),
        'autoHideToolbar may be used only when both fullScreen and '
        'autoHideMenuBar are also set.');
  }

  /// Applies these [NSAppPresentationOptions] to as fullscreen presentation
  /// options.
  ///
  /// These [NSAppPresentationOptions] must include
  /// [NSAppPresentationOption.fullScreen].
  ///
  /// Throws an assertion error if any of the following restrictions is
  /// violated:
  /// + `autoHideDock` and `hideDock` are mutually exclusive: You may specify
  ///   one or the other, but not both.
  /// + `autoHideMenuBar` and `hideMenuBar` are mutually exclusive: You may
  ///   specify one or the other, but not both.
  /// + If you specify `hideMenuBar`, it must be accompanied by `hideDock`.
  /// + If you specify `autoHideMenuBar`, it must be accompanied by either
  ///   `hideDock` or `autoHideDock`.
  /// + If you specify any of `disableProcessSwitching`, `disableForceQuit`,
  ///   `disableSessionTermination`, or `disableMenuBarTransparency`, it must
  ///   be accompanied by either `hideDock` or `autoHideDock`.
  /// + `autoHideToolbar` may be used only when both `fullScreen` and
  ///   `autoHideMenuBar` are also set.
  ///
  /// If the [force] flag is true, those assertions are disabled.
  void applyAsFullScreenPresentationOptions({bool force = false}) {
    if (!force) {
      assertRestrictions();

      assert(contains(NSAppPresentationOption.fullScreen),
          'fullScreen must be set.');
    }

    WindowManipulator.removeFullScreenPresentationOptions();
    for (final option in options) {
      WindowManipulator.addFullScreenPresentationOption(option);
    }
  }
}
