import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/enmu.dart';
import 'package:bujuan/pages/play_list/playlist_view.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

import '../../widget/app_bar.dart';

class LocalSongView extends StatefulWidget {
  const LocalSongView({Key? key}) : super(key: key);

  @override
  State<LocalSongView> createState() => _LocalSongViewState();
}

class _LocalSongViewState extends State<LocalSongView> {
  OnAudioQuery query = GetIt.instance<OnAudioQuery>();
  final List<MediaItem> _items = [];
  Directory? directory;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getLocalSong());
  }

  _getLocalSong() async {
    directory = await getApplicationSupportDirectory();
    bool permissionsRequest = await query.permissionsRequest();
    if (permissionsRequest) {
      List<SongModel> songs = [];
      String type = context.routeData.queryParams.getString('type');
      if (type == 'all') {
        songs.addAll(await query.querySongs());
      } else {
        songs.addAll(await query.queryAudiosFrom(type == 'album' ? AudiosFromType.ALBUM_ID : AudiosFromType.ARTIST_ID, context.routeData.queryParams.getInt('id')));
      }
      for (var e in songs) {
        String path = '${directory?.path}/${e.id}.jpeg';
        File file = File(path);
        if (!await file.exists()) {
          Uint8List? byteData = await query.queryArtwork(e.id, ArtworkType.AUDIO, size: 200, format: ArtworkFormat.JPEG);
          if (byteData != null) {
            await file.writeAsBytes(byteData);
          } else {
            path = '';
          }
        }
        _items.add(MediaItem(
            id: '${e.id}',
            duration: Duration(milliseconds: e.duration ?? 0),
            artUri: Uri.file(path),
            extras: {
              'url': e.data,
              'image': path,
              'liked': false,
              'artist': '',
              'mv': 0,
              'type': MediaType.local.name,
            },
            title: e.title,
            album: e.album,
            artist: e.artist));
      }
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: false,
        title: RichText(
            text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
          TextSpan(text: '本地歌曲～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
        ])),
      ),
      body: Visibility(
        replacement: const LoadingView(),
        visible: _items.isNotEmpty,
        child: ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          itemBuilder: (context, index) => SongItem(
            index: index,
            mediaItems: _items,
            queueTitle: 'local${DateTime.now().millisecondsSinceEpoch}',
            voidCallback: () {
              setState(() {
                _items.clear();
              });
              _getLocalSong();
            },
          ),
          itemCount: _items.length,
        ),
      ),
    );
  }
}
