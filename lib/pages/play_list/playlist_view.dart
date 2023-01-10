import 'dart:convert';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/common/netease_api/src/api/bean.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/app_bar.dart';
import '../../widget/request_widget/request_loadmore_view.dart';
import '../../widget/request_widget/request_view.dart';
import '../../widget/simple_extended_image.dart';
import '../home/home_controller.dart';

class PlayListView extends StatefulWidget {
  const PlayListView({Key? key}) : super(key: key);

  @override
  State<PlayListView> createState() => _PlayListViewState();
}

class _PlayListViewState extends State<PlayListView> {
  DioMetaData playListDetailDioMetaData(String categoryId, {int subCount = 5}) {
    var params = {'id': categoryId, 'n': 1000, 's': '$subCount', 'shareUserId': '0'};
    return DioMetaData(Uri.parse('https://music.163.com/api/v6/playlist/detail'), data: params, options: joinOptions());
  }

  DioMetaData songDetailDioMetaData(List<String> songIds) {
    var params = {
      'ids': songIds,
      'c': songIds.map((e) => jsonEncode({'id': e})).toList()
    };
    return DioMetaData(joinUri('/api/v3/song/detail'), data: params, options: joinOptions());
  }

  final List<MediaItem> _mediaItem = [];
  SinglePlayListWrap? singlePlayListWrap;

  _subscribePlayList() async {
    ServerStatusBean serverStatusBean =
        await NeteaseMusicApi().subscribePlayList((context.routeData.args as Play).id, subscribe: !(singlePlayListWrap?.playlist?.subscribed ?? false));
    if (serverStatusBean.code == 200) {
      setState(() {
        singlePlayListWrap?.playlist?.subscribed = !(singlePlayListWrap?.playlist?.subscribed ?? false);
      });
      if (HomeController.to.currPathUrl.value == '/home/user') {
        UserController.to.refreshController.callRefresh();
      }
    }
  }

  @override
  void dispose() {
    _mediaItem.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: RequestWidget<SinglePlayListWrap>(
            dioMetaData: playListDetailDioMetaData((context.routeData.args as Play).id),
            onData: (SinglePlayListWrap s) => setState(() => singlePlayListWrap = s),
            childBuilder: (SinglePlayListWrap data) => RequestLoadMoreWidget<SongDetailWrap, Song2>(
                listKey: const ['songs'],
                enableLoad: false,
                dioMetaData: songDetailDioMetaData((data.playlist?.trackIds ?? []).map((e) => e.id).toList()),
                childBuilder: (List<Song2> songs) {
                  _mediaItem
                    ..clear()
                    ..addAll(HomeController.to.song2ToMedia(songs));
                  return SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildTopItem(),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                        ListView.builder(
                          shrinkWrap: true,
                          itemExtent: 120.w,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => _buildItem(_mediaItem[index], index),
                          itemCount: _mediaItem.length,
                        ),
                      ],
                    ),
                  );
                })),
      ),
      onHorizontalDragDown: (e) {
        return;
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return MyAppBar(
      leading: IconButton(
          padding: EdgeInsets.only(left: 20.w),
          onPressed: () => AutoRouter.of(context).pop(),
          icon: SimpleExtendedImage.avatar(
            '${(context.routeData.args as Play).picUrl ?? (context.routeData.args as Play).coverImgUrl}?param=100y100',
            width: 75.w,
            height: 75.w,
          )),
      title: AutoSizeText(
        (context.routeData.args as Play).name ?? '',
        maxLines: 1,
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _buildTopItem() {
    return Container(
      padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w, bottom: 25.w),
      alignment: Alignment.center,
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary.withOpacity(.8), borderRadius: BorderRadius.circular(15.w)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => _subscribePlayList(),
                  icon: SimpleExtendedImage.avatar(
                    '${singlePlayListWrap?.playlist?.creator?.avatarUrl ?? ''}?param=80y80',
                    width: 80.w,
                  )),
              Expanded(
                child: Text(
                  singlePlayListWrap?.playlist?.creator?.nickname ?? '',
                  style: TextStyle(fontSize: 28.sp),
                ),
              ),
              IconButton(onPressed: () => _subscribePlayList(), icon: Icon((singlePlayListWrap?.playlist?.subscribed ?? false) ? TablerIcons.hearts : TablerIcons.heart)),
              IconButton(onPressed: () {}, icon: const Icon(TablerIcons.message_2)),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              (singlePlayListWrap?.playlist?.description ?? '暂无描述').replaceAll('\n', ''),
              maxLines: 5,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 24.sp, height: 1.6, color: Theme.of(context).cardColor.withOpacity(.6)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(MediaItem data, int index) {
    return InkWell(
      child: SizedBox(
        height: 120.w,
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  maxLines: 1,
                  style: TextStyle(fontSize: 30.sp),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                Text(
                  data.artist??'',
                  maxLines: 1,
                  style: TextStyle(fontSize: 24.sp, color: Colors.grey),
                )
              ],
            )),
            Visibility(
              visible: (data.extras!['mv'] ?? 0) != 0,
              child: IconButton(
                  onPressed: () {
                    context.router.push(const MvView().copyWith(args: '${data.extras?['mv'] ?? 0}'));
                  },
                  icon: const Icon(
                    TablerIcons.brand_youtube,
                    color: Colors.grey,
                  )),
            ),
            IconButton(
                onPressed: () {
                  showModalActionSheet(
                    context: context,
                    title: data.title,
                    message: data.artist,
                    actions: [const SheetAction<String>(label: '下一首播放', icon: TablerIcons.player_play, key: 'next')],
                  ).then((value) {
                    if(value!=null){
                      if(HomeController.to.audioServeHandler.playbackState.value.queueIndex!=0){
                        HomeController.to.audioServeHandler.insertQueueItem(HomeController.to.audioServeHandler.playbackState.value.queueIndex!+1, data);
                        WidgetUtil.showToast('已添加到下一曲');
                      }else{
                        WidgetUtil.showToast('未知错误');
                      }
                    }
                  });
                },
                icon: const Icon(
                  TablerIcons.dots_vertical,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
      onTap: () => HomeController.to.playByIndex(index, (context.routeData.args as Play).id, mediaItem: _mediaItem),
    );
  }
}

// class SheetData{
//   String title;
//   String value;
// }
