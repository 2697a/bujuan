# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2023-01-13

### Removed

- **BREAKING** [#49 Add button with hotspot attributes to allowed elements](https://github.com/omchiii/model_viewer_plus.dart/pull/49), because you can customize them now.

### Added

- Allowing customize NodeValidator on Web platform by using `overwriteNodeValidatorBuilder`.
- New example, `example\lib\materials_and_scene\change_color.dart`

### Fixed

- lints
- Upgrade Dart SDK in the example folder to 2.12.0 to "Running with sound null safety"

## [1.4.0] - 2022-12-06

### Changed

- Upgrade `assets/model-viewer.min.js` to v2.1.1 and implements all attributes
- Examples support Android API 33
- Dependencies upgrade

## [] - 2022-10-08

### Changed

- [#49 Add button with hotspot attributes to allowed elements](https://github.com/omchiii/model_viewer_plus.dart/pull/49)

## [1.3.3] - 2022-09-18

### Changed

- Fix: `Removing disallowed element <SCRIPT> from [object DocumentFragment]`, in `lib\src\model_viewer_plus_web.dart`
- Update `example\lib\loading\display_poster.dart`
- Update `README.md`, due to `<model-viewer>` upgrades to 2.0.0 and we have not keep up with it's latest version. So, Flutter Web users should replace `src="https://unpkg.com/@google/model-viewer/dist/model-viewer.min.js"` with `src="./assets/packages/model_viewer_plus/assets/model-viewer.min.js"` to use the js file in our package.

### Added

- Add a new example: `example\lib\loading\render_scale.dart`

## [1.3.2] - 2022-09-14

### Changed

- Update `html_builder.dart`:
  - Fix `min-camera-orbit`, `max-field-of-view`, `min-field-of-view`

## [1.3.1] - 2022-08-04

### Changed

- Upgrade `pubspec.yaml`:
  - `webview_flutter: ^3.0.1` -> `webview_flutter: ^3.0.4`
  - `url_launcher: ^6.1.0` -> `url_launcher: ^6.1.5`

## [1.3.0]~~[1.2.1]~~ - 2022-06-22

### Changed

- `README.md`: `import 'package:model_viewer_plus/model_viewer.dart';` -> `import 'package:model_viewer_plus/model_viewer_plus.dart';`
- `lib\html_builder.dart`: fix typos and uncomment `debugPrint` for more debug info
- `lib\model_viewer_plus_mobile.dart`: uncomment `debugPrint` for more debug info
- `lib\model_viewer_plus_web.dart`: unique viewType to fix [#29](https://github.com/omchiii/model_viewer_plus.dart/issues/29)
- Update `assets/model-viewer.min.js` to v1.20.0

## [1.2.0] - 2022-04-26

### Added

- More examples in `example/lib`

### Changed

- `lib\html_builder.dart`, `lib\model_viewer_plus_mobile.dart`, `lib\model_viewer_plus_web.dart`, `lib\model_viewer_plus.dart`: implement all the attributes of `<model-viewer>` v1.11.1.
- ModelViewer.arSacle from `final String? arScale` to `final ArScale? arScale`, which may be a breaking change.
- Update `assets/model-viewer.min.js` to v1.11.1
- Update example dir's gradle version to 7.0.2

## [1.1.5] - 2022-03-15

### Changed

- `lib/src/model_viewer_plus_mobile.dart`
  - Fix [#11](https://github.com/omchiii/model_viewer_plus.dart/issues/11), add `gestureRecognizers`
  - A less elegant solution of [#8](https://github.com/omchiii/model_viewer_plus.dart/issues/8), open usdz file by [url_launcher](https://pub.dev/packages/url_launcher) in SFSafariViewController.

## [1.1.4] - 2022-03-14

### Changed

- `/lib/src/model_viewer_plus_mobile.dart`, update according to the [newest document](https://developers.google.com/ar/develop/scene-viewer#3d-or-ar). Fix [#9](https://github.com/omchiii/model_viewer_plus.dart/issues/9).
  - Insted of `com.google.ar.core`, now we use `com.google.android.googlequicksearchbox`. This should support the widest possible range of devices.
  - Mode defaults to `ar_preferred`. Scene Viewer launches in AR native mode as the entry mode. If Google Play Services for AR isn't present, Scene Viewer gracefully falls back to 3D mode as the entry mode.
- Add `arModes` to example, closer to [modelviewer.dev](https://modelviewer.dev)'s offical example.
- Update `example\android\app\build.gradle` `compileSdkVersion` to 31
- Update `android_intent_plus` to `3.1.1`
- Update `webview_flutter` to `3.0.1`

### Removed

- `/lib/src/http_proxy.dart`: empty file

## [1.1.3] - 2022-03-14

### Changed

- `ModelViewer`'s default `backgroundColor` from `Colors.white` to `Colors.transparent`, due to [#12](https://github.com/omchiii/model_viewer_plus.dart/issues/12)
- `proxy`'s null check fix and `setState() {}` for it, due to [#10](https://github.com/omchiii/model_viewer_plus.dart/issues/10)

## [1.1.2] - 2022-02-17

### Added

- `/lib/src/shim/` with `dart_html_fake.dart` and `dart_ui_fake.dart`. Fixing `ERROR: The name platformViewRegistry' is being referenced through the prefix 'ui', but it isn't defined in any of the libraries imported using that prefix.` and `INFO: Avoid using web-only libraries outside Flutter web plugin` to improve the [score on pub.dev](https://pub.dev/packages/model_viewer_plus/score).

### Changed

- example's `/etc/assets` -> `/assets`

## [1.1.1] - 2022-02-17

### Added

- `/assets/model-viewer.min.js` (v1.10.1, which is actually identical to v1.10.0)

### Changed

- `/etc/assets` -> `/assets`
- `example/flutter_02.png`: Updated the Screenshot.
- `README.md`: README Update.
- `lib/src/model_viewer_plus_web.dart`: Due to the change of `model-viewer.js` -> `model-viewer.min.js`
- `lib/src/model_viewer_plus_mobile.dart`: Due to the change of `model-viewer.js` -> `model-viewer.min.js`, added CircularProgressIndicator while mobile platform loading

### Removed

- `/etc/assets/model-viewer.js`: To slim the package size.

## [1.1.0] - 2022-02-15

### Added

- Web Support
  - `lib/src/model_viewer_plus_stub.dart`
  - `lib/src/model_viewer_plus_mobile.dart`
  - `lib/src/model_viewer_plus_web.dart`

### Changed

- `lib/model_viewer_plus.dart`
- `lib/src/model_viewer_plus.dart`
