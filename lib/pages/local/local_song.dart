
import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/local/local_controller.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:bujuan/widget/my_get_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../widget/app_bar.dart';
import '../home/home_controller.dart';

class LocalSongView extends GetView<Local> {
  const LocalSongView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    controller.getLocalSong();
    return MyGetView(child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        title: const Text('本地歌曲'),
      ),
      body: Obx(() => Visibility(
          replacement: const LoadingView(),
          visible: !controller.loadingSong.value,
          child: ListView.builder(
            itemBuilder: (context, index) => _buildItem(controller.songs[index], index, context),
            itemExtent: 120.w,
            itemCount: controller.songs.length,
          ))),
    ));
  }

  Widget _buildItem(MediaItem mediaItem, int index, context) {
    return ListTile(
      title: Text(
        mediaItem.title,
        maxLines: 1,
      ),
      subtitle: Text(
        mediaItem.artist ?? '',
        maxLines: 1,
      ),
      onTap: () {
        Home.to.playByIndex(index, 'queueTitle', mediaItem: controller.songs);
      },
    );
  }
}

// class _LocalSongViewState extends State<LocalSongView> {
//   OnAudioQuery query = GetIt.instance<OnAudioQuery>();
//   final List<MediaItem> _items = [];
//   Directory? directory;
//
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getLocalSong());
//   }
//
//   _getLocalSong() async {
//     directory = await getApplicationSupportDirectory();
//     bool permissionsRequest = await query.permissionsRequest();
//     if (permissionsRequest) {
//       List<SongModel> songs = [];
//       String type = context.routeData.queryParams.getString('type');
//       if (type == 'all') {
//         songs.addAll(await query.querySongs());
//       } else {
//         songs.addAll(await query.queryAudiosFrom(type == 'album' ? AudiosFromType.ALBUM_ID : AudiosFromType.ARTIST_ID, context.routeData.queryParams.getInt('id')));
//       }
//       for (var e in songs) {
//         String path = '${directory?.path}/${e.id}.jpeg';
//         File file = File(path);
//         if (!await file.exists()) {
//           Uint8List? byteData = await query.queryArtwork(e.id, ArtworkType.AUDIO, size: 200, format: ArtworkFormat.JPEG);
//           if (byteData != null) {
//             await file.writeAsBytes(byteData);
//           } else {
//             path = '';
//           }
//         }
//         _items.add(MediaItem(
//             id: '${e.id}',
//             duration: Duration(milliseconds: e.duration ?? 0),
//             artUri: Uri.file(path),
//             extras: {
//               'url': e.data,
//               'image': path,
//               'liked': false,
//               'artist': '',
//               'mv': 0,
//               'type': MediaType.local.name,
//             },
//             title: e.title,
//             album: e.album,
//             artist: e.artist));
//       }
//       setState(() {});
//     }
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: MyAppBar(
//         centerTitle: false,
//         title: RichText(
//             text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
//           TextSpan(text: '本地歌曲～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
//         ])),
//       ),
//       body: Visibility(
//         replacement: const LoadingView(),
//         visible: _items.isNotEmpty,
//         child: ListView.builder(
//           padding: EdgeInsets.symmetric(horizontal: 10.w),
//           itemBuilder: (context, index) => SongItem(
//             index: index,
//             mediaItems: _items,
//             queueTitle: 'local${DateTime.now().millisecondsSinceEpoch}',
//             voidCallback: () {
//               setState(() {
//                 _items.clear();
//               });
//               _getLocalSong();
//             },
//           ),
//           itemCount: _items.length,
//         ),
//       ),
//     );
//   }
// }
