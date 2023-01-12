import 'dart:convert';
import 'dart:ui';

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
import 'package:keframe/keframe.dart';

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
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        _buildTopItem(),
                        Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                        ListWidget(mediaItem: HomeController.to.song2ToMedia(songs)),
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
      margin: EdgeInsets.symmetric(horizontal: 20.w),
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
              Visibility(
                visible: singlePlayListWrap?.playlist?.creator?.userId != UserController.to.userData.value.profile?.userId,
                child: IconButton(onPressed: () => _subscribePlayList(), icon: Icon((singlePlayListWrap?.playlist?.subscribed ?? false) ? TablerIcons.hearts : TablerIcons.heart)),
              ),
              IconButton(
                  onPressed: () {
                    context.router.push(
                        const TalkView().copyWith(queryParams: {'id': (context.routeData.args as Play).id, 'type': 'playlist', 'name': (context.routeData.args as Play).name}));
                  },
                  icon: const Icon(TablerIcons.message_2)),
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
}

class ListWidget extends StatefulWidget {
  final List<MediaItem> mediaItem;

  const ListWidget({Key? key, required this.mediaItem}) : super(key: key);

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  // bool sort = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemExtent: 120.w,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => SongItem(index: index, mediaItems: widget.mediaItem,queueTitle: (context.routeData.args as Play).id,),
      itemCount: widget.mediaItem.length,
    );
    // return Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.end,
    //       children: [
    //         IconButton(
    //             onPressed: () {
    //               setState(() {
    //                 sort = !sort;
    //               });
    //             },
    //             icon: const Icon(TablerIcons.sort_ascending))
    //       ],
    //     ),
    //     Visibility(
    //       visible: !sort,
    //       replacement: SizedBox(
    //         height: MediaQuery.of(context).size.height,
    //         child: ReorderableListView(
    //           onReorder: (int oldIndex, int newIndex) {
    //             if (oldIndex < newIndex) {
    //               newIndex -= 1;
    //             }
    //             setState(() {
    //               final MediaItem item = widget.mediaItem.removeAt(oldIndex);
    //               widget.mediaItem.insert(newIndex, item);
    //             });
    //           },
    //           children: widget.mediaItem.map((e) => _buildItem(e)).toList(),
    //         ),
    //       ),
    //       child: ListView.builder(
    //         shrinkWrap: true,
    //         itemExtent: 120.w,
    //         physics: const NeverScrollableScrollPhysics(),
    //         itemBuilder: (context, index) => _buildItem(widget.mediaItem[index], index: index),
    //         itemCount: widget.mediaItem.length,
    //       ),
    //     )
    //   ],
    // );
  }

  // Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
  //   final ColorScheme colorScheme = Theme.of(context).colorScheme;
  //   final Color draggableItemColor = colorScheme.secondary;
  //   return AnimatedBuilder(
  //     animation: animation,
  //     builder: (BuildContext context, Widget? child) {
  //       final double animValue = Curves.easeInOut.transform(animation.value);
  //       final double elevation = lerpDouble(0, 6, animValue)!;
  //       return Material(
  //         elevation: elevation,
  //         color: draggableItemColor,
  //         shadowColor: draggableItemColor,
  //         child: child,
  //       );
  //     },
  //     child: child,
  //   );
  // }

  @override
  void dispose() {
    widget.mediaItem.clear();
    super.dispose();
  }

  // Widget _buildItem(MediaItem data, {int index = 0}) {
  //   return FrameSeparateWidget(
  //     index: index,
  //     child: InkWell(
  //       key: Key(data.id),
  //       child: Container(
  //         padding: EdgeInsets.symmetric(horizontal: 30.w),
  //         height: 120.w,
  //         child: Row(
  //           children: [
  //             Expanded(
  //                 child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   data.title,
  //                   maxLines: 1,
  //                   style: TextStyle(fontSize: 30.sp),
  //                 ),
  //                 Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
  //                 Text(
  //                   data.artist ?? '',
  //                   maxLines: 1,
  //                   style: TextStyle(fontSize: 24.sp, color: Colors.grey),
  //                 )
  //               ],
  //             )),
  //             Visibility(
  //               visible: (data.extras!['mv'] ?? 0) != 0,
  //               child: IconButton(
  //                   onPressed: () {
  //                     context.router.push(const MvView().copyWith(queryParams: {'mvId': data.extras?['mv'] ?? 0}));
  //                   },
  //                   icon: const Icon(
  //                     TablerIcons.brand_youtube,
  //                     color: Colors.grey,
  //                   )),
  //             ),
  //             Visibility(
  //               visible: index != null,
  //               replacement: IconButton(
  //                   onPressed: () {},
  //                   icon: const Icon(
  //                     TablerIcons.arrows_move_vertical,
  //                     color: Colors.grey,
  //                   )),
  //               child: IconButton(
  //                   onPressed: () {
  //                     showModalActionSheet(
  //                       context: context,
  //                       title: data.title,
  //                       message: data.artist,
  //                       actions: [const SheetAction<String>(label: '下一首播放', icon: TablerIcons.player_play, key: 'next')],
  //                     ).then((value) {
  //                       if (value != null) {
  //                         if (HomeController.to.audioServeHandler.playbackState.value.queueIndex != 0) {
  //                           HomeController.to.audioServeHandler.insertQueueItem(HomeController.to.audioServeHandler.playbackState.value.queueIndex! + 1, data);
  //                           WidgetUtil.showToast('已添加到下一曲');
  //                         } else {
  //                           WidgetUtil.showToast('未知错误');
  //                         }
  //                       }
  //                     });
  //                   },
  //                   icon: const Icon(
  //                     TablerIcons.dots_vertical,
  //                     color: Colors.grey,
  //                   )),
  //             ),
  //           ],
  //         ),
  //       ),
  //       onTap: () {
  //         HomeController.to.playByIndex(index, (context.routeData.args as Play).id, mediaItem: widget.mediaItem);
  //       },
  //     ),
  //   );
  // }
}

class SongItem extends StatelessWidget {
  final int index;
  final List<MediaItem> mediaItems;
  final String queueTitle;

  const SongItem({Key? key, required this.index, required this.mediaItems, required this.queueTitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FrameSeparateWidget(
      index: index,
      placeHolder: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        height: 120.w,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 36.w,width: 150.w,color: Theme.of(context).cardColor.withOpacity(.1),),
            SizedBox(height: 20.w,width: 260.w),
            Container(height: 36.w,width: 260.w,color: Theme.of(context).cardColor.withOpacity(.1),),
          ],
        ),
      ),
      child: InkWell(
        key: Key(mediaItems[index].id),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          height: 120.w,
          child: Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    mediaItems[index].title,
                    maxLines: 1,
                    style: TextStyle(fontSize: 30.sp),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                  Text(
                    mediaItems[index].artist ?? '',
                    maxLines: 1,
                    style: TextStyle(fontSize: 24.sp, color: Colors.grey),
                  )
                ],
              )),
              Visibility(
                visible: (mediaItems[index].extras!['mv'] ?? 0) != 0,
                child: IconButton(
                    onPressed: () {
                      context.router.push(const MvView().copyWith(queryParams: {'mvId': mediaItems[index].extras?['mv'] ?? 0}));
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
                      title: mediaItems[index].title,
                      message: mediaItems[index].artist,
                      actions: [const SheetAction<String>(label: '下一首播放', icon: TablerIcons.player_play, key: 'next')],
                    ).then((value) {
                      if (value != null) {
                        if (HomeController.to.audioServeHandler.playbackState.value.queueIndex != 0) {
                          HomeController.to.audioServeHandler.insertQueueItem(HomeController.to.audioServeHandler.playbackState.value.queueIndex! + 1, mediaItems[index]);
                          WidgetUtil.showToast('已添加到下一曲');
                        } else {
                          WidgetUtil.showToast('未知错误');
                        }
                      }
                    });
                  },
                  icon: const Icon(
                    TablerIcons.dots_vertical,
                    color: Colors.grey,
                  )),
            ],
          ),
        ),
        onTap: () {
          HomeController.to.playByIndex(index, queueTitle, mediaItem: mediaItems);
        },
      ),
    );
  }
}

// class SheetData{
//   String title;
//   String value;
// }
