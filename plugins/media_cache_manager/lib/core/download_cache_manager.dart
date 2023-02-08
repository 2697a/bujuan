import 'package:get_storage/get_storage.dart';

import '../media_cache_manager.dart';

abstract class DownloadCacheManager {

  /// Cache box name
  static const String _boxName = 'MediaCacheManager';

  /// Check Variable if Cache initialized
  static bool _isInitialized = false;

  /// Cache Instance
  static final GetStorage _getStorage = GetStorage(_boxName);

  /// Initializing Cache
  static Future<void> init() async {
    if (_isInitialized) {
      return;
    }
    await GetStorage.init(_boxName);
    _isInitialized = true;
  }

  /// Caching File Path
  /// [Caching in HashMap Key is : URL, Value is : Path]
  static Future<void> cacheFilePath({
    required String url,
    required String path,
  }) async {
     await _getStorage.write(url, path);
  }

  /// Getting File path based on given url
  /// [It's Big O is a Constant Time]
  static String? getCachedFilePath(String url) {
    return _getStorage.read(url);
  }

  /// Setting ExpireDate if expire date came
  /// the downloaded files will be deleted to reduce storage usage.
  static Future<void> setExpireDate({required int daysToExpire}) async {
    const expiryDateKey = 'expiryDate';
    final expireDuration = Duration(days: daysToExpire);
    final dateTimeNow = DateTime.now();
    await init();
    if (!_getStorage.hasData(expiryDateKey)) {
      _getStorage.write(expiryDateKey, dateTimeNow.add(expireDuration).toString());
      return;
    }
    bool expired = DateTime.parse(_getStorage.read(expiryDateKey)).isBefore(dateTimeNow);
    if (expired) {
      await _getStorage.erase();
      await Downloader.clearCachedFiles();
      _getStorage.write(expiryDateKey, dateTimeNow.add(expireDuration).toString());
    }
  }

}