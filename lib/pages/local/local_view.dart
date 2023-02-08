import 'dart:io';
import 'dart:typed_data';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get_it/get_it.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:path_provider/path_provider.dart';

import '../../widget/app_bar.dart';
import '../../widget/simple_extended_image.dart';
import '../home/home_controller.dart';
import '../user/user_controller.dart';

class LocalView extends StatefulWidget {
  const LocalView({Key? key}) : super(key: key);

  @override
  State<LocalView> createState() => _LocalViewState();
}

class _LocalViewState extends State<LocalView> {
  OnAudioQuery query = GetIt.instance<OnAudioQuery>();
  final List<MediaItem> _items = [];
  Directory? directory;
  bool loading = true;
  List<ArtistModel> artistList = [];
  List<AlbumModel> albumList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      directory = await getApplicationSupportDirectory();
      bool permissionsRequest = await query.permissionsRequest();
      if (permissionsRequest) {
        _getAlbum();
        _getLocalSong();
      }
    });
  }

  _getLocalSong() async {
    directory = await getApplicationSupportDirectory();
    List<SongModel> songs = await query.querySongs();
    for (var e in songs) {
      String path = '${directory?.path}/${e.id}.jpeg';
      File file = File(path);
      if (!await file.exists()) {
        Uint8List? byteData = await query.queryArtwork(e.id, ArtworkType.AUDIO, size: 300, format: ArtworkFormat.JPEG);
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
          displayDescription: 'local',
          extras: {'url': e.data, 'image': path, 'liked': false, 'artist': '', 'mv': 0},
          title: e.title,
          album: e.album,
          artist: e.artist));
    }
  }

  _getAlbum() async {
    List<ArtistModel> artists = await query.queryArtists();
    for (var e in artists) {
      String path = '${directory?.path}/${e.id}.jpeg';
      File file = File(path);
      if (!await file.exists()) {
        Uint8List? byteData = await query.queryArtwork(e.id, ArtworkType.ARTIST, size: 200, format: ArtworkFormat.JPEG);
        if (byteData != null) {
          await file.writeAsBytes(byteData);
        } else {
          path = '';
        }
      }
    }
    if (artists.length > 3) artists = artists.sublist(0, 3);
    artistList
      ..clear()
      ..addAll(artists);
    List<AlbumModel> albums = await query.queryAlbums();
    for (var e in albums) {
      String path = '${directory?.path}/${e.id}.jpeg';
      File file = File(path);
      if (!await file.exists()) {
        Uint8List? byteData = await query.queryArtwork(e.id, ArtworkType.ALBUM, size: 100, format: ArtworkFormat.JPEG);
        if (byteData != null) {
          await file.writeAsBytes(byteData);
        } else {
          path = '';
        }
      }
    }
    if (albums.length > 8) albums = albums.sublist(0, 8);
    albumList
      ..clear()
      ..addAll(albums);
    loading = false;
    setState(() {});
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
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              HomeController.to.myDrawerController.open!();
            },
            icon: Obx(() => SimpleExtendedImage.avatar(
                  HomeController.to.userData.value.profile?.avatarUrl ?? '',
                  width: 80.w,
                ))),
        title: RichText(
            text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
          TextSpan(text: '本地歌曲～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
        ])),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Visibility(
          visible: !loading,
          replacement: Visibility(
            visible: artistList.isEmpty && !loading,
            replacement: const LoadingView(),
            child: const EmptyView(),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 18.w),
                  leading:  Icon(TablerIcons.list_details,color: Theme.of(context).cardColor,),
                  trailing: const Icon(TablerIcons.chevron_right),
                  title: const Text('全部单曲',style: TextStyle(fontWeight: FontWeight.bold),),
                  onTap: () {
                    context.router.push(const LocalSongView().copyWith(queryParams: {'id': 0, 'type': 'all'}));
                  }),
              _buildHeader('艺术家', context),
              _buildArtists(),
              _buildHeader('专辑', context),
              _buildAlbum(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArtists() {
    return SizedBox(
      height: (750.w - 120.w) / 3,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (c, i) => _buildItem(artistList[i], c, i),
        itemCount: artistList.length,
      ),
    );
  }

  Widget _buildItem(ArtistModel play, BuildContext context, index) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        height: (750.w - 120.w) / 3,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SimpleExtendedImage(
              '${directory?.path}/${play.id}.jpeg',
              width: (750.w - 120.w) / 3,
              borderRadius: BorderRadius.circular(25.w),
            ),
            Container(
              height: 60.w,
              width: (750.w - 120.w) / 3,
              color: Theme.of(context).bottomAppBarColor.withOpacity(.8),
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    play.artist ?? '',
                    maxLines: 1,
                    style: TextStyle(fontSize: 26.sp),
                  ),
                  // Padding(padding: EdgeInsets.symmetric(vertical: 2.w)),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        context.router.push(const LocalSongView().copyWith(queryParams: {'id': play.id, 'type': 'artist'}));
      },
    );
  }

  Widget _buildAlbum() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 20.w,
      ),
      itemBuilder: (context, index) => _buildItem1(albumList[index], context, index),
      itemCount: albumList.length,
    );
  }

  Widget _buildItem1(AlbumModel play, BuildContext context, int index) {
    return InkWell(
      child: SizedBox(
        height: 120.w,
        child: Row(
          children: [
            SimpleExtendedImage(
              '${directory?.path}/${play.id}.jpeg',
              width: 85.w,
              borderRadius: BorderRadius.circular(10.w),
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        play.album ?? '',
                        maxLines: 1,
                        style: TextStyle(fontSize: 28.sp),
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                      Text(
                        '${play.artist}',
                        maxLines: 1,
                        style: TextStyle(fontSize: 26.sp, color: Colors.grey),
                      )
                    ],
                  ),
                )),
            Text(
              '${play.numOfSongs}首',
              style: TextStyle(fontSize: 22.sp, color: Colors.grey),
            )
          ],
        ),
      ),
      onTap: () {
        context.router.push(const LocalSongView().copyWith(queryParams: {'id': play.id, 'type': 'album'}));
      },
    );
  }

  Widget _buildHeader(String title, context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.w),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6.w)),
            width: 10.w,
            height: 10.w,
          ),
          Padding(padding: EdgeInsets.symmetric(horizontal: 6.w)),
          Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Theme.of(context).textTheme.bodyText1?.color?.withOpacity(.8)),
              )),
          const Icon(TablerIcons.chevron_right)
        ],
      ),
    );
  }
}
