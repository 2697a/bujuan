// import 'package:flutter/material.dart';
// import '../media_cache_manager.dart';
//
// /// Using this widget it will download the file if not downloaded yet,
// /// if downloaded it will get it back in snapshot.
// class DownloadMediaBuilder extends StatefulWidget {
//   const DownloadMediaBuilder({
//     Key? key,
//     required this.url,
//     required this.builder,
//   }) : super(key: key);
//
//   /// URL of any type of media (Audio, Video, Image, etc...)
//   final String url;
//
//   /// Snapshot Will provide you the status of process
//   /// (Success, Error, Loading)
//   /// and file if downloaded and download progress
//   final Widget? Function(BuildContext context, DownloadMediaSnapshot snapshot) builder;
//
//   @override
//   State<DownloadMediaBuilder> createState() => _DownloadMediaBuilderState();
// }
//
// class _DownloadMediaBuilderState extends State<DownloadMediaBuilder> {
//
//   late _DownloadMediaBuilderController __downloadMediaBuilderController;
//   late DownloadMediaSnapshot snapshot;
//
//   @override
//   void initState() {
//     snapshot = DownloadMediaSnapshot(
//       status: DownloadMediaStatus.loading,
//       filePath: null,
//       progress: null,
//     );
//
//     /// Initializing Widget Logic Controller
//     __downloadMediaBuilderController = _DownloadMediaBuilderController(
//       snapshot: snapshot,
//       onSnapshotChanged: (snapshot) => setState(() => this.snapshot = snapshot),
//     );
//
//     /// Initializing Caching Database
//     DownloadCacheManager.init().then((value) {
//       /// Starting Caching Database
//       __downloadMediaBuilderController.getFile(widget.url);
//     });
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(
//       context,
//       snapshot,
//     ) ?? const SizedBox();
//   }
// }
//
// class _DownloadMediaBuilderController {
//
//   _DownloadMediaBuilderController({required DownloadMediaSnapshot snapshot, required Function(DownloadMediaSnapshot) onSnapshotChanged}) {
//     _onSnapshotChanged = onSnapshotChanged;
//     _snapshot = snapshot;
//   }
//
//   /// When snapshot changes this function will called and give you the new snapshot
//   late final Function(DownloadMediaSnapshot) _onSnapshotChanged;
//
//   /// Provide us a 3 Variable
//   /// 1 - Status : It's the status of the process (Success, Loading, Error).
//   /// 2 - Progress : The progress if the file is downloading.
//   /// 3 - FilePath : When Status is Success the FilePath won't be null;
//   late final DownloadMediaSnapshot _snapshot;
//
//   /// Try to get file path from cache,
//   /// If it's not exists it will download the file and cache it.
//   Future<void> getFile(String url) async {
//     String? filePath = DownloadCacheManager.getCachedFilePath(url);
//     if (filePath != null) {
//       _snapshot.filePath = filePath;
//       _snapshot.status = DownloadMediaStatus.success;
//       _onSnapshotChanged(_snapshot);
//       return;
//     }
//     filePath = await Downloader.downloadFile(
//       url,
//       onProgress: (progress, total) {
//         _onSnapshotChanged(_snapshot..progress = (progress / total));
//       },
//     );
//     if (filePath != null) {
//       _snapshot.filePath = filePath;
//       _snapshot.status = DownloadMediaStatus.success;
//       _onSnapshotChanged(_snapshot);
//
//       /// Caching FilePath
//       await DownloadCacheManager.cacheFilePath(url: url, path: filePath);
//     } else {
//       _onSnapshotChanged(_snapshot..status = DownloadMediaStatus.error);
//     }
//   }
// }