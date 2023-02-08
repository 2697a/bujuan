// import 'dart:io';
// import 'package:better_player/better_player.dart';
// import 'package:flutter/material.dart';
// import 'package:media_cache_manager/media_cache_manager.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await DownloadCacheManager.setExpireDate(daysToExpire: 1);
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             DownloadMediaBuilder(
//               url: 'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4',
//               builder: (context, snapshot) {
//                 if (snapshot.status == DownloadMediaStatus.loading) {
//                   return LinearProgressIndicator(
//                     value: snapshot.progress,
//                   );
//                 }
//                 if (snapshot.status == DownloadMediaStatus.success) {
//                   return BetterPlayer.file(snapshot.filePath!);
//                 }
//                 return const Text('Error!');
//               },
//             ),
//             DownloadMediaBuilder(
//               url: 'https://static.remove.bg/remove-bg-web/5c20d2ecc9ddb1b6c85540a333ec65e2c616dbbd/assets/start-1abfb4fe2980eabfbbaaa4365a0692539f7cd2725f324f904565a9a744f8e214.jpg',
//               builder: (context, snapshot) {
//                 if (snapshot.status == DownloadMediaStatus.success) {
//                   return Image.file(File(snapshot.filePath!));
//                 }
//                 return null;
//               },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
