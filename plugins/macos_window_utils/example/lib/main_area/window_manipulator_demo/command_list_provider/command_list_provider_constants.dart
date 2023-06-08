class CommandListProviderConstants {
  static const nsApplicationPresentationOptionsOverview =
      'There are restrictions on the combination of presentation options that can be set simultaneously:\n'
      '+ `autoHideDock` and `hideDock` are mutually exclusive: You may specify one or the other, but not both.\n'
      '+ `autoHideMenuBar` and `hideMenuBar` are mutually exclusive: You may specify one or the other, but not both.\n'
      '+ If you specify `hideMenuBar`, it must be accompanied by `hideDock`.\n'
      '+ If you specify `autoHideMenuBar`, it must be accompanied by either `hideDock` or `autoHideDock`.\n'
      '+ If you specify any of `disableProcessSwitching`, `disableForceQuit`, `disableSessionTermination`, or `disableMenuBarTransparency`, it must be accompanied by either `hideDock` or `autoHideDock`.\n'
      '+ `autoHideToolbar` may be used only when both `fullScreen` and `autoHideMenuBar` are also set.\n'
      '\n'
      'When `NSApplication` receives a parameter value that does not conform to these requirements, it raises an `invalidArgumentException`.\n';
}
