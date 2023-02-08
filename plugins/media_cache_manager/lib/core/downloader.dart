import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:media_cache_manager/core/download_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

abstract class Downloader {
  static CancelToken? cancelToken;

  static Future<String?> downloadFile(String url, String id, {required Function(int progress, int total) onProgress}) async {
    try {
      if (cancelToken != null) {
        cancelToken?.cancel();
        cancelToken = null;
      }
      cancelToken = CancelToken();
      final downloadDir = await _getDownloadDirectory();
      // String fileName = getFileNameFromURL(url, '/');
      await Dio().download(
        url,
        '${downloadDir.path}/$id',
        onReceiveProgress: onProgress,
        cancelToken: cancelToken,
      );
      final filePath = '${downloadDir.path}/$id';
      DownloadCacheManager.cacheFilePath(url: id, path: filePath);
      return filePath;
    } catch (e, s) {
      if (kDebugMode) {
        print(e);
        print(s);
      }
      return null;
    }
  }

  static Future<Directory> _getDownloadDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    final downloadDir = Directory('${appDir.path}/files');
    final isDirExist = await downloadDir.exists();
    if (!isDirExist) {
      await downloadDir.create(recursive: true);
    }
    return downloadDir;
  }

  static Future<void> clearCachedFiles() async {
    final dir = await _getDownloadDirectory();
    await dir.delete(recursive: true);
  }
}
