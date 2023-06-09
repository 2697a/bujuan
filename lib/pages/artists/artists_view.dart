import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/src/api/play/bean.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/play_list/playlist_view.dart';
import 'package:bujuan/widget/my_get_view.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/app_bar.dart';
import '../../widget/request_widget/request_loadmore_view.dart';
import '../../widget/simple_extended_image.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({Key? key}) : super(key: key);

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> with SingleTickerProviderStateMixin {
  Artists? artists;
  final List<MediaItem> _items = [];
  final List<Tab> _tabs = [
    const Tab(text: '详情'),
    const Tab(text: '单曲'),
    const Tab(text: '专辑'),
  ];
  TabController? _tabController;

  DioMetaData artistDetailDioMetaData(String artistId) {
    var params = {'id': artistId};
    return DioMetaData(joinUri('/api/artist/head/info/get'), data: params, options: joinOptions());
  }

  DioMetaData artistTopSongListDioMetaData(String artistId) {
    var params = {'id': artistId};
    return DioMetaData(joinUri('/api/artist/top/song'), data: params, options: joinOptions());
  }

  DioMetaData artistAlbumListDioMetaData(String artistId, {int offset = 0, int limit = 30, bool total = true}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/artist/albums/$artistId'), data: params, options: joinOptions());
  }

  @override
  void initState() {
    super.initState();
    artists = (context.routeData.args as Artists);
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MyGetView(child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        title: Text(artists?.name ?? ''),
        bottom: TabBar(
          tabs: _tabs,
          controller: _tabController,
          labelColor: Theme.of(context).primaryColor,
          unselectedLabelColor: Theme.of(context).iconTheme.color,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorColor: Theme.of(context).primaryColor,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 0),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildDetails(), _buildSongList(), _buildAlbumView()],
      ),
    ));
  }

  Widget _buildDetails(){
    return RequestWidget<ArtistDetailWrap>(
        dioMetaData: artistDetailDioMetaData(artists?.id ?? '-1'),
        childBuilder: (artistDetails) {
          print('======${jsonEncode(artistDetails.toJson())}');
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      width: Get.width,
                      margin: EdgeInsets.only(top: 150.w),
                      padding: EdgeInsets.only(left: 15.w, right: 15.w, bottom: 25.w, top: 80.w),
                      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(25.w)),
                      child: Column(
                        children: [
                          Padding(padding: EdgeInsets.symmetric(vertical: 15.w),child: Text(
                            artistDetails.data?.artist?.name??"",
                            style: TextStyle(fontSize: 56.sp),
                          ),),
                          Padding(padding: EdgeInsets.symmetric(vertical: 20.w,horizontal: 20.w),child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('${artistDetails.data?.artist?.albumSize??''} 专辑'),
                              Text('${artistDetails.data?.artist?.musicSize??''} 单曲'),
                              Text('${artistDetails.data?.artist?.mvSize??''} MV'),
                            ],
                          ),)
                        ],
                      ),
                    ),
                    SimpleExtendedImage.avatar(
                      '${artistDetails.data?.artist?.cover??''}?param=300y300',
                      width: 220.w,
                    ),
                  ],
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 30.w),child: Text(artistDetails.data?.artist?.briefDesc??"",style: TextStyle(color: Theme.of(context).iconTheme.color),),),
              ],
            ),
          );
        });
  }

  Widget _buildSongList() {
    return RequestWidget<ArtistSongListWrap>(
        dioMetaData: artistTopSongListDioMetaData(artists?.id ?? '-1'),
        childBuilder: (artistDetails) {
          _items
            ..clear()
            ..addAll(Home.to.song2ToMedia(artistDetails.songs ?? []));
          return ListView.builder(
            itemExtent: 130.w,
            itemBuilder: (context, index) => SongItem(
              index: index,
              mediaItem: _items[index],
              onTap: () {
                Home.to.playByIndex(index, 'queueTitle', mediaItem: _items);
              },
            ),
            itemCount: _items.length,
          );
        });
  }

  Widget _buildAlbumView() {
    return RequestLoadMoreWidget<ArtistAlbumListWrap, Album>(
      dioMetaData: artistAlbumListDioMetaData(artists?.id ?? '-1'),
      pageSize: 30,
      childBuilder: (List<Album> playlist) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          itemExtent: 130.w,
          itemBuilder: (context, index) => AlbumItem(index: index, album: playlist[index]),
          itemCount: playlist.length,
        );
      },
      listKey: const ['hotAlbums'],
    );
  }
}
