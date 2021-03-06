## [1.0.2] - [April 13, 2020]
### Features
- Addressed issue #71, #103 - Added an optional `header` widget that floats above the `panel` and attaches to the top
- Added an optional `footer` widget that floats above the `panel` and attaches to the bottom

### Documentation
- Updated documentation to reflect new features and fixes

## [1.0.1] - [April 2, 2020]
### Fixes
- Addressed issue #94: Too much widget rebuild occurring when the user slides the panel. This fix results in huge performance benefits when using the `panelChild` and `panelBuilder` properties
- Addressed issues #102, #111: Fixed issue where tapping on the panel closes it (when using the `panelBuilder`)
- Addressed issues #24, #70, #108, #121: Changed `backdropTapClosesPanel` to use `onTap` and `onVerticalDragEnd` so swipes on the backdrop cause the panel to close

### Features
- Addressed issue #107: Added duration and curve properties to the `PanelController`'s `animatePanelToPosition` method
- Addressed issues #12,#77,#86,#100: Added a `snapPoint` property to allow the panel to snap to a position midway during its slide

### Documentation
- Updated documentation to reflect new features and fixes
- Updated copyright year in the LICENSE

## [1.0.0] - [January 25, 2020]

#### Fixes
- Addressed issue #69: Used a FadeTransition to handle opacity changes (as per Flutter documentation)
- Cleaned up `PanelController` code to make maintenance easier
- Added clearer assert statements and messages to indicate why calling `PanelController` methods would fail before attaching the `PanelController`.

#### Features
- Addressed issues #17, #55, #60: Added the ability to link / nested the scroll position of the panel content with the position of the panel (i.e. infinite scrolling).
- Added the `panelBuilder` property that's required to implement the nested scrolling as described above.
- Added an `isAttached` property to the `PanelController` to indicate whether or not the `PanelController` is attached to an instance of the `SlidingUpPanel`

#### Breaking Changes
The following `PanelController` methods now return `Future<void>` instead of `void`:
- `close()`
- `open()`
- `hide()`
- `show()`
- `animatePanelToPosition(double value)`

The following `PanelController` methods have changed to Dart properties to better reflect Dart language conventions:
- `setPanelPosition()` -> `panelPosition` [as a setter]
- `getPanelPosition()` -> `panelPosition` [as a getter]
- `isPanelAnimating()` -> `isPanelAnimating`
- `isPanelOpen()` -> `isPanelOpen`
- `isPanelClosed()` -> `isPanelClosed`
- `isPanelShown()` -> `isPanelShown`


For example, here's how you would have previously used `setPanelPosition()` and `getPanelPosition()` vs. how you would now use the `panelPosition` property:
```dart
// OLD, no longer supported
print(pc.getPanelPosition()); // print a value between 0.0 and 1.0
pc.setPanelPosition(0.5);     // sets the panelPosition to 0.5
```

```dart
// NEW
print(pc.panelPosition); // print a value between 0.0 and 1.0
pc.panelPosition = 0.5;  // sets the panelPosition to 0.5
```

And here's how you would have previously called `isPanelAnimating()` vs. how you would now call `isPanelAnimating`.
```dart
panelController.isPanelAnimating(); // OLD, no longer supported
```
```dart
panelController.isPanelAnimating; // NEW
```


#### Documentation
- Updated the documentation to reflect changes
- Updated example to use nested scrolling



<br><br>
## [0.3.6] - [September 25, 2019]

#### Fixes
- Fixed issues #54, #59 where panel listeners would be called before UI was rendered (related to `defaultPanelState`)

#### Documentation
- Updated the documentation to reflect fixes


<br><br>
## [0.3.5] - [August 31, 2019]

#### Features
- Added the `defaultPanelState` property that changes whether the panel is either open or closed by default (`PanelState.OPEN` or `PanelState.CLOSED`)

#### Documentation
- Updated the documentation to reflect new features


<br><br>
## [0.3.4] - [April 16, 2019]

#### Features
- Added the `slideDirection` property that changes how the panel slides open (either up or down)

#### Documentation
- Updated the documentation to reflect new features


<br><br>
## [0.3.3] - [April 6, 2019]

#### Features
- Added the `isDraggable` property that allows/prevents dragging of the panel

#### Documentation
- Updated the documentation to reflect new features


<br><br>
## [0.3.2] - [April 5, 2019]

#### Documentation
- Fixed problem where images would wrap on pub (instead of displaying on one line)



<br><br>
## [0.3.1] - [April 5, 2019]

#### Features
- Configuration options to `SlidingUpPanel`
    - `parallaxEnabled`
    - `parallaxOffset`

#### Documentation
- Created a new example app (Maps)
- Updated documentation to reflect new features



<br><br>
## [0.3.0] - April 2, 2019

#### Features
- Added ability to close the `panel` when the backdrop is tapped

- Added callbacks to the `SlidingUpPanel`
    - `onPanelSlide`
    - `onPanelOpened`
    - `onPanelClosed`

- Added methods to the `PanelController`
    - `setPanelPosition`
    - `animatePanelToPosition`
    - `getPanelPosition`
    - `isPanelAnimating`
    - `isPanelOpen`
    - `isPanelClosed`
    - `isPanelShown`

#### Bug Fixes
- Fixed issue where the `collapsed` widget would accept touch events even when invisible (i.e. even when the panel was fully open)

#### Documentation
- Updated documentation to reflect new features
- Added clarification on `PanelController` lifecycle
- Added an explanation about nesting the `Scaffold` when displaying a backdrop


<br><br>
## [0.2.0] - April 1, 2019

Added the backdrop feature:
- Body darkens as the panel opens
- The backdrop color is customizable
- The backdrop opacity is also customizable
- Off by default

Other changes:
- Removed the README from the example app (pub will display the code on the website now)
- Specified Dart as the language in the README code snippets



<br><br>
## [0.1.2] - March 31, 2019

- Updated documentation to be more comprehensive



<br><br>
## [0.1.1] - March 31, 2019

- Added a CHANGELOG file



<br><br>
## [0.1.0] - March 31, 2019

This is the initial release of the sliding_up_panel package. This includes features such as
- A sliding up panel that responds to user gestures
- Customizing the look and feel of the sliding panel
- Manually controlling the sliding panel via the PanelController