import 'dart:async';

import 'package:example/main_area/window_manipulator_demo/command_list_provider/command_list_provider_constants.dart';
import 'package:macos_window_utils/macos/ns_window_level.dart';
import 'package:macos_window_utils/macos/ns_window_style_mask.dart';
import 'package:macos_window_utils/macos_window_utils.dart';

import '../command_list/command.dart';

class CommandListProvider {
  static List<Command> getCommands() {
    return [
      ...List.generate(NSVisualEffectViewMaterial.values.length, (int index) {
        final currentMaterial = NSVisualEffectViewMaterial.values[index];
        return Command(
          name: 'setMaterial(${currentMaterial.toString()})',
          description: 'Changes the window\'s subview\'s material property to '
              '`${currentMaterial.name}`.',
          function: () => WindowManipulator.setMaterial(currentMaterial),
        );
      }),
      Command(
        name: 'enterFullscreen()',
        function: () => WindowManipulator.enterFullscreen(),
      ),
      Command(
        name: 'exitFullscreen()',
        function: () => WindowManipulator.exitFullscreen(),
      ),
      Command(
        name: 'setDocumentEdited()',
        description: 'Sets the document to be edited.\n\n'
            'This changes the appearance of the close button on the '
            'titlebar:\n\n'
            '![image](https://user-images.githubusercontent.com/86920182/209436903-0a6c1f5a-4ab6-454f-a37d-78a5d699f3df.png)',
        function: () => WindowManipulator.setDocumentEdited(),
      ),
      Command(
        name: 'setDocumentUnedited()',
        function: () => WindowManipulator.setDocumentUnedited(),
      ),
      Command(
        name: 'setRepresentedFilename(\'some file.txt\')',
        function: () =>
            WindowManipulator.setRepresentedFilename('some file.txt'),
      ),
      Command(
        name: 'setRepresentedFilename(\'\')',
        function: () => WindowManipulator.setRepresentedFilename(''),
      ),
      Command(
        name: 'setRepresentedUrl(\'http://some_url.com/\')',
        function: () =>
            WindowManipulator.setRepresentedUrl('http://some_url.com/'),
      ),
      Command(
        name: 'setRepresentedUrl(\'\')',
        function: () => WindowManipulator.setRepresentedUrl(''),
      ),
      Command(
        name: 'hideTitle()',
        function: () => WindowManipulator.hideTitle(),
      ),
      Command(
        name: 'showTitle()',
        function: () => WindowManipulator.showTitle(),
      ),
      Command(
        name: 'makeTitlebarTransparent()',
        function: () => WindowManipulator.makeTitlebarTransparent(),
      ),
      Command(
        name: 'makeTitlebarOpaque()',
        function: () => WindowManipulator.makeTitlebarOpaque(),
      ),
      Command(
        name: 'enableFullSizeContentView()',
        description: 'Enables the window\'s full-size content view.\n\n'
            'This expands the area that Flutter can draw to to fill the entire'
            ' window. It is recommended to enable the full-size content view '
            'when making the titlebar transparent.',
        function: () => WindowManipulator.enableFullSizeContentView(),
      ),
      Command(
        name: 'disableFullSizeContentView()',
        function: () => WindowManipulator.disableFullSizeContentView(),
      ),
      Command(
        name: 'zoomWindow()',
        function: () => WindowManipulator.zoomWindow(),
      ),
      Command(
        name: 'unzoomWindow()',
        function: () => WindowManipulator.unzoomWindow(),
      ),
      Command(
        name: 'hideZoomButton()',
        function: () => WindowManipulator.hideZoomButton(),
      ),
      Command(
        name: 'showZoomButton()',
        function: () => WindowManipulator.showZoomButton(),
      ),
      Command(
        name: 'hideMiniaturizeButton()',
        function: () => WindowManipulator.hideMiniaturizeButton(),
      ),
      Command(
        name: 'showMiniaturizeButton()',
        function: () => WindowManipulator.showMiniaturizeButton(),
      ),
      Command(
        name: 'hideCloseButton()',
        function: () => WindowManipulator.hideCloseButton(),
      ),
      Command(
        name: 'showCloseButton()',
        function: () => WindowManipulator.showCloseButton(),
      ),
      Command(
        name: 'enableZoomButton()',
        function: () => WindowManipulator.enableZoomButton(),
      ),
      Command(
        name: 'disableZoomButton()',
        function: () => WindowManipulator.disableZoomButton(),
      ),
      Command(
        name: 'enableMiniaturizeButton()',
        function: () => WindowManipulator.enableMiniaturizeButton(),
      ),
      Command(
        name: 'disableMiniaturizeButton()',
        function: () => WindowManipulator.disableMiniaturizeButton(),
      ),
      Command(
        name: 'enableCloseButton()',
        function: () => WindowManipulator.enableCloseButton(),
      ),
      Command(
        name: 'disableCloseButton()',
        function: () => WindowManipulator.disableCloseButton(),
      ),
      ...List.generate(4, (int index) {
        final alphaValue = 0.25 + (index * 0.25);
        return Command(
          name: 'setWindowAlphaValue($alphaValue)',
          function: () => WindowManipulator.setWindowAlphaValue(alphaValue),
        );
      }),
      Command(
        name: 'setWindowBackgroundColorToDefaultColor()',
        function: () =>
            WindowManipulator.setWindowBackgroundColorToDefaultColor(),
      ),
      Command(
        name: 'setWindowBackgroundColorToClear()',
        function: () => WindowManipulator.setWindowBackgroundColorToClear(),
      ),
      Command(
        name: 'setNSVisualEffectViewState(NSVisualEffectViewState.active)',
        description: 'Sets the NSVisualEffectView\'s state to `active`.\n\n'
            '**Description:** The backdrop should always appear active.',
        function: () => WindowManipulator.setNSVisualEffectViewState(
            NSVisualEffectViewState.active),
      ),
      Command(
        name: 'setNSVisualEffectViewState(NSVisualEffectViewState.inactive)',
        description: 'Sets the NSVisualEffectView\'s state to `inactive`.\n\n'
            '**Description:** The backdrop should always appear inactive.',
        function: () => WindowManipulator.setNSVisualEffectViewState(
            NSVisualEffectViewState.inactive),
      ),
      Command(
        name: 'setNSVisualEffectViewState('
            'NSVisualEffectViewState.followsWindowActiveState)',
        description: 'Sets the NSVisualEffectView\'s state to '
            '`followsWindowActiveState`.\n\n'
            '**Description:** The backdrop should automatically appear active '
            'when the window is active, and inactive when it is not.',
        function: () => WindowManipulator.setNSVisualEffectViewState(
            NSVisualEffectViewState.followsWindowActiveState),
      ),
      Command(
        name: 'overrideMacOSBrightness(dark: false)',
        description: '**Warning:** Calling this method does not inform the '
            'Flutter framework of the theme changes. The app will continue '
            'using its default theme settings.',
        function: () => WindowManipulator.overrideMacOSBrightness(dark: false),
      ),
      Command(
        name: 'overrideMacOSBrightness(dark: true)',
        description: '**Warning:** Calling this method does not inform the '
            'Flutter framework of the theme changes. The app will continue '
            'using its default theme settings.',
        function: () => WindowManipulator.overrideMacOSBrightness(dark: true),
      ),
      Command(
        name: 'addToolbar()',
        function: () => WindowManipulator.addToolbar(),
      ),
      Command(
        name: 'removeToolbar()',
        function: () => WindowManipulator.removeToolbar(),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: NSWindowToolbarStyle.automatic)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the system determines '
            'the toolbar’s appearance and location.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: NSWindowToolbarStyle.automatic),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: NSWindowToolbarStyle.expanded)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the toolbar appears '
            'below the window title.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: NSWindowToolbarStyle.expanded),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: NSWindowToolbarStyle.preference)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the toolbar appears '
            'below the window title with toolbar items centered in the toolbar.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: NSWindowToolbarStyle.preference),
      ),
      Command(
        name: 'setToolbarStyle(toolbarStyle: NSWindowToolbarStyle.unified)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the toolbar appears '
            'next to the window title.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: NSWindowToolbarStyle.unified),
      ),
      Command(
        name:
            'setToolbarStyle(toolbarStyle: NSWindowToolbarStyle.unifiedCompact)',
        description: 'Sets the window\'s toolbar style.\n\n'
            'For this method to have an effect, the window needs to have had a '
            'toolbar added with the `addToolbar` method beforehand.\n\n'
            '**Description:** A style indicating that the toolbar appears '
            'next to the window title and with reduced margins to allow more '
            'focus on the window’s contents.',
        function: () => WindowManipulator.setToolbarStyle(
            toolbarStyle: NSWindowToolbarStyle.unifiedCompact),
      ),
      Command(
        name: 'enableShadow()',
        function: () => WindowManipulator.enableShadow(),
      ),
      Command(
        name: 'disableShadow()',
        function: () => WindowManipulator.disableShadow(),
      ),
      Command(
        name: 'invalidateShadows()',
        description: 'Invalidates the window\'s shadow.\n\n'
            'This is a fairly technical method and is included here for '
            'completeness\' sake. Normally, it should not be necessary to use '
            'it.',
        function: () => WindowManipulator.invalidateShadows(),
      ),
      Command(
        name: 'addEmptyMaskImage()',
        description: 'Adds an empty mask image to the window\'s view.\n\n'
            'This will effectively disable the `NSVisualEffectView`\'s effect.'
            '\n\n'
            '**Warning:** It is recommended to disable the window\'s shadow '
            'using `WindowManipulator.disableShadow()` when using this method. '
            'Keeping the shadow enabled when using an empty mask image can '
            'cause visual artifacts and performance issues.',
        function: () => WindowManipulator.addEmptyMaskImage(),
      ),
      Command(
        name: 'removeMaskImage()',
        function: () => WindowManipulator.removeMaskImage(),
      ),
      Command(
        name: 'makeWindowFullyTransparent()',
        description: 'Makes a window fully transparent (with no blur effect).'
            '\n\n'
            'This is a convenience method which executes:\n\n'
            '`\nsetWindowBackgroundColorToClear();\n'
            'makeTitlebarTransparent();\naddEmptyMaskImage();\n'
            'disableShadow();\n`'
            // Using fenced code blocks causes an exception to be thrown whose
            // message reads “The Scrollbar's ScrollController has no
            // ScrollPosition attached. [...]”. For this reason, normal codes
            // are using here.
            '\n\n**Warning:** When the window is fully transparent, its '
            'highlight effect (the thin white line at the top of the window) '
            'is still visible. This is considered a bug and may change in a '
            'future version.',
        function: () => WindowManipulator.makeWindowFullyTransparent(),
      ),
      Command(
        name: 'ignoreMouseEvents()',
        description: 'Makes the window ignore mouse events.\n\n'
            'This method can be used to make parts of the window '
            'click-through, which may be desirable when used in conjunction '
            'with `makeWindowFullyTransparent()`.\n\n'
            '**Note:** This example project will automatically re-acknowledge '
            'mouse events five seconds after this method has been called.',
        function: () {
          WindowManipulator.ignoreMouseEvents();
          Timer(const Duration(seconds: 5),
              () => WindowManipulator.acknowledgeMouseEvents());
        },
      ),
      Command(
        name: 'acknowledgeMouseEvents()',
        function: () => WindowManipulator.acknowledgeMouseEvents(),
      ),
      Command(
        name: 'setSubtitle(\'foobar\')',
        function: () => WindowManipulator.setSubtitle('foobar'),
      ),
      Command(
        name: 'setSubtitle(\'\')',
        description: 'Passing an empty string to `setSubtitle` removes the '
            'subtitle.',
        function: () => WindowManipulator.setSubtitle(''),
      ),
      Command(
        name: 'setLevel(NSWindowLevel.floating)',
        description: 'Sets the window to appear in front of all normal-level '
            'windows.',
        function: () => WindowManipulator.setLevel(NSWindowLevel.floating),
      ),
      Command(
        name: 'setLevel(NSWindowLevel.normal.withOffset(-1))',
        description: 'Sets the window to appear in behind all normal-level '
            'windows.',
        function: () =>
            WindowManipulator.setLevel(NSWindowLevel.normal.withOffset(-1)),
      ),
      Command(
        name: 'setLevel(NSWindowLevel.normal)',
        description: 'Resets the window\'s level to the default value.',
        function: () => WindowManipulator.setLevel(NSWindowLevel.normal),
      ),
      Command(
        name: 'orderOut()',
        description: 'Removes the window from the screen list, which hides the '
            'window.',
        function: () => WindowManipulator.orderOut(),
      ),
      Command(
        name: 'orderBack()',
        description: 'Moves the window to the back of its level in the screen '
            'list, without changing either the key window or the rust window.',
        function: () => WindowManipulator.orderBack(),
      ),
      Command(
        name: 'orderFront()',
        description: 'Moves the window to the front of its level in the screen '
            'list, without changing either the key window or the rust window.',
        function: () => WindowManipulator.orderFront(),
      ),
      Command(
        name: 'orderFrontRegardless()',
        description: 'Moves the window to the front of its level, even if its '
            'application isn\'t active, without changing either the key window '
            'or the rust window.',
        function: () => WindowManipulator.orderFrontRegardless(),
      ),
      Command(
        name: 'removeFromStyleMask(NSWindowStyleMask.titled); '
            'insertIntoStyleMask(NSWindowStyleMask.borderless)',
        description: 'Makes the window non-titled and borderless.',
        function: () {
          WindowManipulator.removeFromStyleMask(NSWindowStyleMask.titled);
          WindowManipulator.insertIntoStyleMask(NSWindowStyleMask.borderless);
        },
      ),
      Command(
        name: 'insertIntoStyleMask(NSWindowStyleMask.titled); '
            'removeFromStyleMask(NSWindowStyleMask.borderless)',
        description: 'Makes the window titled and non-borderless.',
        function: () {
          WindowManipulator.insertIntoStyleMask(NSWindowStyleMask.titled);
          WindowManipulator.removeFromStyleMask(NSWindowStyleMask.borderless);
        },
      ),
      Command(
        name: 'removeFullScreenPresentationOptions()',
        description: 'Removes the window\'s full-screen presentation options. '
            'Removing the window\'s full-screen presentation options returns '
            'the window\'s presentation to its default state.',
        function: () => WindowManipulator.removeFullScreenPresentationOptions(),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'autoHideDock)',
        description:
            'The dock is normally hidden, but automatically appears when '
            'moused near.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.autoHideDock),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'hideDock)',
        description: 'The dock is entirely hidden and disabled.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.hideDock),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'autoHideMenuBar)',
        description:
            'The menu bar is normally hidden, but automatically appears when '
            'moused near.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.autoHideMenuBar),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'hideMenuBar)',
        description: 'The menu bar is entirely hidden and disabled.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.hideMenuBar),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'disableAppleMenu)',
        description: 'All Apple Menu items are disabled.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.disableAppleMenu),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'disableProcessSwitching)',
        description:
            'The process switching user interface (Command + Tab to cycle '
            'through apps) is disabled.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.disableProcessSwitching),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'disableForceQuit)',
        description:
            'The force quit panel (displayed by pressing Command + Option + '
            'Esc) is disabled\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.disableForceQuit),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'disableSessionTermination)',
        description: 'The panel that shows the Restart, Shut Down, and Log Out '
            'options that are displayed as a result of pushing the power key '
            'is disabled.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.disableSessionTermination),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'disableHideApplication)',
        description: 'The app’s “Hide” menu item is disabled.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.disableHideApplication),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'disableMenuBarTransparency)',
        description: 'The menu bar transparency appearance is disabled.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.disableMenuBarTransparency),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'fullScreen)',
        description: 'The app is in fullscreen mode.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.fullScreen),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'autoHideToolbar)',
        description:
            'When in fullscreen mode the window toolbar is detached from '
            'window and hides and shows with autoHidden menuBar.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.autoHideToolbar),
      ),
      Command(
        name: 'addFullScreenPresentationOption(NSAppPresentationOptions.'
            'disableCursorLocationAssistance)',
        description:
            'The behavior that allows the user to shake the mouse to locate '
            'the cursor is disabled.\n\n'
            '**Warning:** '
            '${CommandListProviderConstants.nsApplicationPresentationOptionsOverview}'
            '\nAdditionally, please note that '
            '`NSAppPresentationOption.fullScreen` needs to be present as a '
            'full-screen presentation option.',
        function: () => WindowManipulator.addFullScreenPresentationOption(
            NSAppPresentationOption.disableCursorLocationAssistance),
      ),
    ];
  }
}
