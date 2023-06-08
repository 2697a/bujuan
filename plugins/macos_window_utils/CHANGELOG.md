## 1.1.3

- Fix multiple `FlutterViewController`s being created, which prevented the apps from exiting properly on Flutter 3.10.

## 1.1.2

- Make macos_window_utils work without modifications to `MainFlutterWindow.swift`.

## 1.1.1

- Hotfix: Fix accidental breaking change in directory structure in 1.1.0.

## 1.1.0 (retracted)

- Add an abstract `NSWindowDelegate` that can be used to listen to events provided by [NSWindowDelegate](https://developer.apple.com/documentation/appkit/nswindowdelegate) such as window resizing, moving, exposing, and minimizing. The following methods are currently supported:
  -  Managing Sheets
     - `windowWillBeginSheet`
     - `windowDidEndSheet`
  -  Sizing Windows
     - `windowWillResize`
     - `windowDidResize`
     - `windowWillStartLiveResize`
     - `windowDidEndLiveResize`
  -  Minimizing Windows
     - `windowWillMiniaturize`
     - `windowDidMiniaturize`
     - `windowDidDeminiaturize`
  -  Zooming Window
     - `windowWillUseStandardFrame`
     - `windowShouldZoom`
  -  Managing Full-Screen Presentation
     - `windowWillEnterFullScreen`
     - `windowDidEnterFullScreen`
     - `windowWillExitFullScreen`
     - `windowDidExitFullScreen`
  -  Moving Windows
     - `windowWillMove`
     - `windowDidMove`
     - `windowDidChangeScreen`
     - `windowDidChangeScreenProfile`
     - `windowDidChangeBackingProperties`
  -  Closing Windows
     - `windowShouldClose`
     - `windowWillClose`
  -  Managing Key Status
     - `windowDidBecomeKey`
     - `windowDidResignKey`
  -  Managing Main Status
     - `windowDidBecomeMain`
     - `windowDidResignMain`
  -  Exposing Windows
     - `windowDidExpose`
  -  Managing Occlusion State
     - `windowDidChangeOcclusionState`
  -  Managing Presentation in Version Browsers
     - `windowWillEnterVersionBrowser`
     - `windowDidEnterVersionBrowser`
     - `windowWillExitVersionBrowser`
     - `windowDidExitVersionBrowser`
- Add an `NSAppPresentationOptions` class that allows the window's fullscreen presentation options to be modified.

## 1.0.2

- Fix incompatibility with Flutter 3.7.0.

## 1.0.1

- Add `setLevel` method.
- Add the following `order*` methods:
  - `orderOut`
  - `orderBack`
  - `orderFront`
  - `orderFrontRegardless`
- Add methods to modify the window's `styleMask` property.
- Improve documentation.

## 1.0.0+1

- Improve “Getting started” section in the project's readme.
- Improve documentation formatting.

## 1.0.0

- Initial version.
