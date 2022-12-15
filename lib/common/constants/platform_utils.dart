import 'dart:io';
import 'package:flutter/foundation.dart';

class PlatformUtils {
  static bool _isWeb() {
    return kIsWeb == true;
  }

  static bool _isAndroid() {
    return _isWeb() ? false : Platform.isAndroid;
  }

  static bool _isIOS() {
    return _isWeb() ? false : Platform.isIOS;
  }

  static bool _isMacOS() {
    return _isWeb() ? false : Platform.isMacOS;
  }

  static bool _isWindows() {
    return _isWeb() ? false : Platform.isWindows;
  }

  static bool _isFuchsia() {
    return _isWeb() ? false : Platform.isFuchsia;
  }

  static bool _isLinux() {
    return _isWeb() ? false : Platform.isLinux;
  }

  static bool get isWeb => _isWeb();

  static bool get isAndroid => _isAndroid();

  static bool get isIOS => _isIOS();

  static bool get isMacOS => _isMacOS();

  static bool get isWindows => _isWindows();

  static bool get isFuchsia => _isFuchsia();

  static bool get isLinux => _isLinux();
}
