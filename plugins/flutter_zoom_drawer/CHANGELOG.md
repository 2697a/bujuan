# [3.0.3]
- Fix [#107](https://github.com/medyas/flutter_zoom_drawer/issues/107) [#99](https://github.com/medyas/flutter_zoom_drawer/issues/99)

# [3.0.2]
-
- Fix [#96](https://github.com/medyas/flutter_zoom_drawer/issues/96)

# [3.0.1]

- Fix issues: [#88](https://github.com/medyas/flutter_zoom_drawer/issues/88), [#91](https://github.com/medyas/flutter_zoom_drawer/issues/91)

# [3.0.0]

**Thanks to [@YDA93](https://github.com/YDA93) for his contribution**

Breaking changes

- Due to new futures added some styles were removed in favor of `moveMenuScreen` feature, please refer to README
- Replaced `backgroundColor` with `drawerShadowsBackgroundColor`
- Replaced `swipeOffset` with `dragOffset`

What's new?

- ZoomDrawer is now responsive to dragging
- Added `moveMenuScreen` to slide `menuScreen` along with `mainScreen`
- Added `menuScreenWidth`
- Added `menuBackgroundColor`
- Added `reverseDuration`
- Added `mainScreenOverlayColor` and `menuScreenOverlayColor` to control overlay color while closing and opening
- Added `mainScreenAbsorbPointer` to prevent mainScreen tap events while drawer is open
- Added `menuScreenTapClose` to close drawer from menuScreen tap
- Added `openDragSensitivity` and `closeDragSensitivity` to control drawer sensitivity in response to dragging
- Added `androidCloseOnBackTap` to close drawer on android back tap
- Added extensions to access drawer, drawerState, and drawerState notifier

Fixes:

- Fix `mainScreen` bug resulted in opening drawer instead of closing
- Fix `mainScreenTapClose` is being ignored on app start or Hot restarts
- Fix discrepancy between RTL and LTR styles
- Fix drawerState notifier wasn't disposed
- Code improvements and followed lint package rules

# [2.3.1+1]

- Fix `mainScreen` state rebuild

# [2.3.1]

- Fix `mainScreen` state destruction

# [2.3.0]

- Added `overlayBlur`, `shrinkMainScreen` and `drawerStyleBuilder`
- Fixed `angle` to rotate all styles, not just Style1

# [2.2.2+1]

- Fixed `Style1` state

# [2.2.2]

- Fixed `Style1` border radius

# [2.2.1]

- Added `shadowLayer1Color` & `shadowLayer2Color`
- Fixed `Style8` RTL support

# [2.2.0]

**Thanks to [@Skquark](https://github.com/Skquark) for his contribution**

- Added `overlayColor`, `overlayBlend`, `mainScreenTapClose` and `boxShadow`
- Restructured mainScreen effects stack, cleaned up bugs, added Style8 from a fork

# [2.1.2]

- fixed swipe to close issue
- add `swipeOffset` to customize swipe length for triggering drawer close

# [2.1.1]

- fixed `Style6` & `Style7` issues

# [2.1.0]

- Removed `isRtl` method to fixed Locale warning

# [2.0.2+4]

- Fixed Locale warning

# [2.0.2+3]

- added possibility to disable main screen clipping

# [2.0.2+2]

- Fixed Locale warning

# [2.0.2+1]

- Updated null assertion

# [2.0.2]

- Add Persian to RTL support list
- Fixed `window.locale` null safety bug

# [2.0.1]

- Fixed RTL support in styles

# [2.0.0]

- Migrated to Null Safety
- Added a parameter to disable the swipe gesture (`disableGesture`)

# [1.0.5]

- Added multiple drawer styles thanks to @dangtienngoc

# [1.0.4+1]

- Fixed animation controller dispose issue

# [1.0.4]

- Added `ValueNotifier<DrawerState>` to get updates on the Drawer current state

# [1.0.3]

- Added the ability to customize the open and close `curve` of the drawer

# [1.0.2]

- Added `isOpen` method to determine the status of the drawer

# [1.0.1+1]

- Fixed RTL rotation bug

# [1.0.1]

- Added Sliding with shadow.
- Updated example app with RTL support
- Fixed bugs.

# [1.0.0] - Stable release.

- Stable package release.

# [0.0.1] - Initial release.

- Initial package release.
