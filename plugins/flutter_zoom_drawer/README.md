# Flutter Zoom Drawer

[![pub package](https://img.shields.io/pub/v/flutter_zoom_drawer.svg)](https://pub.dev/packages/flutter_zoom_drawer) [![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter package with custom implementation of the Side Menu (Drawer)

## Getting Started

To start using this package, add `flutter_zoom_drawer` dependency to your `pubspec.yaml`

```yaml
dependencies:
  flutter_zoom_drawer: "<latest_release>"
```

## Version 3 Breaking changes

### Style 1 changed to defaultStyle

Before merge:
`ZoomDrawer( style: DrawerStyle.style1, )`
Now:

```
ZoomDrawer(
style: DrawerStyle.defaultStyle,
showShadow: true,
moveMenuScreen: false,
)
```

### Style 2 changed to defaultStyle

Before merge:
`ZoomDrawer( style: DrawerStyle.style2, )`
Now:
`ZoomDrawer( style: DrawerStyle.defaultStyle, )`

### Style 3 changed to defaultStyle

Before merge:
`ZoomDrawer( style: DrawerStyle.style3, )`
Now:
`ZoomDrawer( style: DrawerStyle.defaultStyle, moveMenuScreen: false, )`

### Style 4 changed to Style 1

### Style 5 changed to Style 2

### Style 6 changed to Style 3

### Style 7 changed to Style 4

### Style 8 changed to defaultStyle

Before merge:
`ZoomDrawer( style: DrawerStyle.style8, )`

Now:

```
ZoomDrawer(
style: DrawerStyle.defaultStyle,
moveMenuScreen: false,
slideWidth: MediaQuery.of(context).screenWidth * 0.5 // set slideWidth
)
```

## Features

- Simple sliding drawer
- Sliding drawer with shadows
- Sliding drawer with rotation
- Sliding drawer with rotation and shadows
- Support for both LTR & RTL

## Simple Example (Thanks to @JesusHdezWaterloo)

```dart
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

void main() {
  Get.put<MyDrawerController>(MyDrawerController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Zoom Drawer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends GetView<MyDrawerController> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyDrawerController>(
      builder: (_) => ZoomDrawer(
        controller: _.zoomDrawerController,
        menuScreen: MenuScreen(),
        mainScreen: MainScreen(),
        borderRadius: 24.0,
        showShadow: true,
        angle: -12.0,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * 0.65,
      ),
    );
  }
}

class MenuScreen extends GetView<MyDrawerController> {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.yellow,
    );
  }
}

class MainScreen extends GetView<MyDrawerController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Center(
        child: ElevatedButton(
          onPressed: controller.toggleDrawer,
          child: Text("Toggle Drawer"),
        ),
      ),
    );
  }
}

class MyDrawerController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();

  void toggleDrawer() {
    print("Toggle drawer");
    zoomDrawerController.toggle?.call();
    update();
  }
}
```

## Documentation

```dart
    ZoomDrawer(
      controller: ZoomDrawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen: MenuScreen(),
      mainScreen: MainScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width*.65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
    )
```

| Parameters                     | Value                  | Required | Docs                                                                            |
| ------------------------------ | ---------------------- | :------: | ------------------------------------------------------------------------------- | --- |
| `controller`                   | `ZoomDrawerController` |    No    | Controller to have access to the open/close/toggle function of the drawer       |
| `style`                        | `DrawerStyle`          |    No    | the drawer style to be displayed (check the `DrawerStyle` enum)                 |
| `mainScreen`                   | `Widget`               |   Yes    | Screen containing the main content to display                                   |
| `menuScreen`                   | `Widget`               |   Yes    | Screen containing the menu/bottom screen                                        |
| `slideWidth`                   | `double`               |    No    | Sliding width of the drawer - defaults to 275.0                                 |
| `mainScreenScale`              | `double`               |    No    | MainScreen scale - defaults to 0.3                                              |
| `borderRadius`                 | `double`               |    No    | Border radius of the slided content - defaults to 16.0                          |
| `angle`                        | `double`               |    No    | Rotation angle of the drawer - defaults to -12.0 - should be 0.0 to -30.0       |
| `disableGesture`               | `bool`                 |    No    | Disable the home page swipe to open drawer gesture - defaults to `false`        |
| `drawerShadowsBackgroundColor` | `Color`                |    No    | Background color of the drawer shadows - defaults to white                      |
| `showShadow`                   | `bool`                 |    No    | Boolean, whether to show the drawer shadows - defaults to false                 |     |
| `openCurve`                    | `Curve`                |    No    | open animation curve - defaults to `Curves.easeOut`                             |
| `closeCurve`                   | `Curve`                |    No    | close animation curve - defaults to `Curves.easeOut`                            |
| `mainScreenTapClose`           | `bool`                 |    No    | Close drawer when tapping mainScreen                                            |
| `mainScreenOverlayColor`       | `Color`                |    No    | Color of the main screen's cover overlay                                        |
| `overlayBlend`                 | `BlendMode`            |    No    | The BlendMode of the `mainScreenOverlayColor` filter (default BlendMode.screen) |
| `boxShadow`                    | `BoxShadow`            |    No    | The Shadow of the mainScreenContent                                             |
| `overlayBlur`                  | `double`               |    No    | The Blur amount of the mainScreen option                                        |
| `shrinkMainScreen`             | `bool`                 |    No    | Shrinks the mainScreen by [slideWidth], good on desktop with Style2             |
| `drawerStyleBuilder`           | `DrawerStyleBuilder`   |    No    | Build custom animated style to override [DrawerStyle]                           |

### Controlling the drawer

To get access to the drawer, and be able to control it, there are 2 ways:

- Using a `ZoomDrawerController` inside the main widget where ou have the `ZoomDrawer` widget and providing it to the widget, which will allow you to trigger the open/close/toggle methods.

```dart
    final _drawerController = ZoomDrawerController();

    _drawerController.open();
    _drawerController.close();
    _drawerController.toggle();
    _drawerController.isOpen();
    _drawerController.stateNotifier;
```

- Using the static method inside ancestor widgets to get access to the `ZoomDrawer`.

```dart
  ZoomDrawer.of(context).open();
  ZoomDrawer.of(context).close();
  ZoomDrawer.of(context).toggle();
  ZoomDrawer.of(context).isOpen();
  ZoomDrawer.of(context).stateNotifier;
```

## Screens

![Example app Demo](https://drive.google.com/uc?export=view&id=1xc6XwVVtpl0RK9IJEdheagM4d1ychQms)

![Example RTL Demo](https://drive.google.com/uc?export=view&id=1YLC60zJ6N637PB6IQDo4TIXY1qGSJ2ET)

- Drawer Sliding

```dart
    ZoomDrawer(
      controller: ZoomDrawerController,
      menuScreen: MenuScreen(),
      mainScreen: MainScreen(),
      borderRadius: 24.0,
      showShadow: false,
      angle: 0.0,
      drawerShadowsBackgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    )
```

![Drawer Sliding](https://drive.google.com/uc?export=view&id=1axuT4Geh08s_QjmED9VTZiwZ9dC_C17C)

- Drawer Sliding with shadow

```dart
    ZoomDrawer(
      controller: ZoomDrawerController,
      menuScreen: MenuScreen(),
      mainScreen: MainScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: 0.0,
      drawerShadowsBackgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    )
```

![Drawer Sliding](https://drive.google.com/uc?export=view&id=1VNkUgtj_bhyYgWJ_Bs3yUpVNUJ30ToPL)

- Drawer Sliding with rotation

```dart
    ZoomDrawer(
      controller: ZoomDrawerController,
      menuScreen: MenuScreen(),
      mainScreen: MainScreen(),
      borderRadius: 24.0,
      showShadow: false,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    )
```

![Drawer Sliding with rotation](https://drive.google.com/uc?export=view&id=1xVYoZHnS9BFi5KicZtP3DY1vEiwZ4FyH)

- Drawer Sliding with rotation and shadows

```dart
    ZoomDrawer(
      controller: ZoomDrawerController,
      menuScreen: MenuScreen(),
      mainScreen: MainScreen(),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      drawerShadowsBackgroundColor: Colors.grey[300],
      slideWidth: MediaQuery.of(context).size.width * 0.65,
    )
```

![Drawer Sliding with rotation and shadows](https://drive.google.com/uc?export=view&id=1b-U25tIY36ka75Ju2jQT9BIUVHv-oNe6)

## Issues

Please file any issues, bugs or feature request as an issue on our [GitHub](https://github.com/medyas/flutter_zoom_drawer/issues) page.

## Want to contribute

If you would like to contribute to the plugin (e.g. by improving the documentation, solving a bug or adding a cool new feature), please carefully review our [contribution guide](CONTRIBUTING.md) and send us your [pull request](https://github.com/medyas/flutter_zoom_drawer/pulls).

## Credits

Credits goes to [pedromassango](https://github.com/pedromassango/flutter_delivery) as most of this package comes from his implementation.
