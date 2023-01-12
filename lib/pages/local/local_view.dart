import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

import '../../widget/app_bar.dart';

class LocalView extends StatefulWidget {
  const LocalView({Key? key}) : super(key: key);

  @override
  State<LocalView> createState() => _LocalViewState();
}

class _LocalViewState extends State<LocalView> {
  OnAudioQuery query = GetIt.instance<OnAudioQuery>();
  List<MediaItem> _items = [];
  Directory? directory;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getLocalSong());
  }

  _getLocalSong() async {
   directory =  await getApplicationSupportDirectory();
    bool permissionsRequest = await query.permissionsRequest();
    if (permissionsRequest) {
      List<SongModel> songs = await query.querySongs();
      for (var e in songs) {
        String path = '${directory?.path}/${e.id}.png';
        File file = File(path);
        if (!await file.exists()) {
          Uint8List? a = await query.queryArtwork(e.id, ArtworkType.AUDIO, size: 500,format: ArtworkFormat.PNG);
          if (a != null) {
            await file.writeAsBytes(a);
          } else {
            path = '';
          }
        }
        _items.add(MediaItem(
            id: '${e.id}',
            duration: Duration(milliseconds: e.duration ?? 0),
            artUri: Uri.file(path),
            extras: {'url': e.uri, 'image': path, 'type': 'local', 'liked': false, 'artist': '', 'mv': 0},
            title: e.displayName,
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
      backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Visibility(
        replacement: const LoadingView(),
        visible: _items.isNotEmpty,
        child: ListView.builder(
          itemBuilder: (context, index) => Container(
            padding: EdgeInsets.symmetric(vertical: 20.w),
            child: Row(
              children: [
                ExtendedImage.file(File(_items[index].extras?['image']),width: 85.w,),
                Expanded(child: Text(_items[index].title))
              ],
            ),
          ),
          itemCount: _items.length,
        ),
      ),
    );
  }
}
