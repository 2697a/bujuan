# Welcome to the **macos_window_utils** contributing guide

Thanks for investing your time in contributing to this project! This document is meant to serve as a guide for new contributors. It assumes that you are familiar with Git and the process of forking a repository to propose changes. If you are unfamiliar with the contribution process on GitHub, feel free to consult the [GitHub Docs](https://docs.github.com/en/get-started/quickstart/contributing-to-projects) for more information.

## How to improve the project's documentation
If you spot an issue with a class' or method's documentation or find an undocumented one, feel free to provide it with a documentation. See [Effective Dart: Documentation](https://dart.dev/guides/language/effective-dart/documentation) for information on how to write good documentations in Dart.

**Please note:** The Swift code is currently very sparsely documented. Any help in that regard is greatly appreciated. :)

## How to add a new method to **macos_window_utils**
Let's assume we would like to implement the [`toggleFullScreen`](https://developer.apple.com/documentation/appkit/nswindow/1419527-togglefullscreen) method from [NSWindow](https://developer.apple.com/documentation/appkit/nswindow) into **macos_window_utils**.

### Add the method to the window manipulator
If you are familiar with **macos_window_utils**, you may know that the package provides a [`WindowManipulator`](https://pub.dev/documentation/macos_window_utils/latest/window_manipulator/WindowManipulator-class.html) class that provides methods to manipulate the application's window. Internally, this class uses a platform channel to communicate with the Swift backend. You can find more information about platform channels [here](https://docs.flutter.dev/development/platform-integration/platform-channels?tab=type-mappings-swift-tab). Let's add a new method that looks like this:

```dart
/// Takes the window into or out of fullscreen mode.
///
/// Usage example:
/// ```dart
/// WindowManipulator.toggleFullScreen();
/// ```
static Future<void> toggleFullScreen() async {
  await _completer.future;
  await _methodChannel.invokeMethod('toggleFullScreen');
}
```

For demonstration purposes, the method's documentation includes a usage example. Normally, you would only include such an example if the method's usage wasn't obvious.

### Add the method to the Swift plugin
If we were to call our new method now, the code would throw a [`MissingPluginException`](https://api.flutter.dev/flutter/services/MissingPluginException-class.html). This is because there is no implementation for our method present on the platform channel. So let's implement the method in Swift, then.

Start by opening the `example/macos/Runner.xcworkspace` file in Xcode and navigate to **Pods › Development Pods › macos_window_utils › .. › .. › example › macos › Flutter › ephemeral › .symlinks › plugins › macos_window_utils › macos › Classes › MacOSWindowUtilsPlugin.swift** (You can also search for the file by pressing ⇧ + ⌘ + O). This class' `handle` method features a large switch statement that resolves method calls coming from the Dart side. Let's add a new case:

```swift
case "toggleFullScreen":
    MainFlutterWindowManipulator.toggleFullScreen()
    result(true)
```

Of course, the `toggleFullScreen` method of the `MainFlutterWindowManipulator` class needs to be implemented as well. To do so, open the `MainFlutterWindowManipulator.swift` file (you can right-click on `MainFlutterWindowManipulator` and choose “Jump to Definition” to do so quickly) and define a new method for that class:

```swift
public static func toggleFullScreen() {
    if (self.mainFlutterWindow == nil) {
        start(mainFlutterWindow: nil)
    }

    self.mainFlutterWindow!.toggleFullScreen(nil)
}
```

The [`toggleFullScreen`](https://developer.apple.com/documentation/appkit/nswindow/1419527-togglefullscreen) method takes a `sender` parameter, which in our case can be `nil`.

### Add a `toggleFullScreen()` command to the example project
When adding new methods to the plugin, you should also add respective commands to the example project, so that users of the package can see the methods in action. Commands are stored in the `CommandListProvider` class which is housed in the `example/lib/main_area/command_list_provider.dart` file. Let's add a new command to the list:

```dart
Command(
  name: 'toggleFullScreen()',
  description: 'Takes the window into or out of fullscreen mode.',
  function: () => WindowManipulator.toggleFullScreen(),
),
```

When you now run the example project, you should see the `toggleFullScreen()` command present in the command list and, if all went well, running the command should toggle the window's fullscreen mode:

<img width="670" alt="image" src="https://user-images.githubusercontent.com/86920182/212060633-d1603d35-15c1-4008-ac09-9ae6994d378a.png">
