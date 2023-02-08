import '../media_cache_manager.dart';

/// DTO Class make it easy to fetch process snapshot ASAP.
class DownloadMediaSnapshot {

  /// Status of download process (Success, Error, Loading)
  late DownloadMediaStatus status;
  /// File that you have downloaded.
  late String? filePath;
  /// Progress of download process.
  late double? progress;

  DownloadMediaSnapshot({
    required this.filePath,
    required this.progress,
    required this.status,
  });

}