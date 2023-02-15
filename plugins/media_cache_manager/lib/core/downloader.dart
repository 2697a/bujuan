import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:media_cache_manager/core/download_cache_manager.dart';
import 'package:path_provider/path_provider.dart';

abstract class Downloader {
  static CancelToken? cancelToken;

  static Future<String?> downloadFile(String url, String id) async {
    try {
      if (cancelToken != null) {
        print('object====取消缓存');
        cancelToken?.cancel();
        cancelToken = null;
      }
      cancelToken = CancelToken();
      final downloadDir = await _getDownloadDirectory();
      final filePath = '${downloadDir.path}/$id';
      // String fileName = getFileNameFromURL(url, '/');
      await Dio().download(
        url,
        '${downloadDir.path}/$id',
        onReceiveProgress: (int progress, int total) {
          print('object==============$progress======$total');
          if (progress == total) {
            print('object====哈哈哈 老子缓存完了哦');
            DownloadCacheManager.cacheFilePath(url: id, path: filePath);
          }
        },
        cancelToken: cancelToken,
      );

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
