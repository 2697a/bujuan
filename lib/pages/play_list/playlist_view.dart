import 'dart:convert';
import 'dart:ui';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:bujuan/common/constants/enmu.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/play_list/playlist_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/custom_filed.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:bujuan/widget/my_get_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:keframe/keframe.dart';

import '../../widget/app_bar.dart';
import '../../widget/simple_extended_image.dart';
import '../home/home_controller.dart';

class PlayListView extends GetView<PlayListController> {
  const PlayListView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.context = context;
    return Scaffold(
        backgroundColor: Colors.transparent,
        resizeToAvoidBottomInset: false,
        body: MyGetView(
            child: Obx(
          () => Visibility(
            visible: !controller.loading.value,
            replacement: const LoadingView(),
            child: CustomScrollView(
              slivers: [
                MySliverAppBar(
                  backgroundColor: Colors.transparent,
                  pinned: true,
                  leading: IconButton(
                      padding: EdgeInsets.only(left: 20.w),
                      onPressed: () => AutoRouter.of(context).pop(),
                      icon: SimpleExtendedImage.avatar(
                        '${(context.routeData.args as Play).picUrl ?? (context.routeData.args as Play).coverImgUrl}?param=100y100',
                        width: 75.w,
                        height: 75.w,
                      )),
                  title: Obx(() => Visibility(
                        visible: !controller.search.value,
                        replacement: CustomFiled(
                          textEditingController: controller.textEditingController,
                          autoFocus: true,
                          hitText: '请输入关键字',
                        ),
                        child: AutoSizeText(
                          (context.routeData.args as Play).name ?? '',
                          maxLines: 1,
                        ),
                      )),
                  actions: [
                    IconButton(
                        onPressed: () {
                          controller.search.value = !controller.search.value;
                          if(!controller.search.value) controller.textEditingController.text = '';
                        },
                        icon: Obx(() => Icon(!controller.search.value ? TablerIcons.search : TablerIcons.x)))
                  ],
                ),
                _buildTopItem(context),
                Obx(() => SizeCacheWidget(
                        child: SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => FrameSeparateWidget(
                                index: index,
                                child: _buildItem(controller.isSearch.value ? controller.searchItems[index] : controller.mediaItems[index], index,context),
                              ),
                          childCount: controller.isSearch.value ? controller.searchItems.length : controller.mediaItems.length,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false),
                      itemExtent: 120.w,
                    )))
              ],
            ),
          ),
        )));
  }

  Widget _buildTopItem(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.w),
        padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 10.w, bottom: 25.w),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {},
                    icon: SimpleExtendedImage.avatar(
                      '${(context.routeData.args as Play).creator?.avatarUrl ?? ''}?param=80y80',
                      width: 80.w,
                    )),
                Expanded(
                  child: Text(
                    (context.routeData.args as Play).creator?.nickname ?? '',
                    style: TextStyle(fontSize: 28.sp),
                  ),
                ),
                // Visibility(
                //   visible: singlePlayListWrap?.playlist?.creator?.userId != UserController.to.userData.value.profile?.userId,
                //   child: IconButton(onPressed: () => _subscribePlayList(), icon: Icon((singlePlayListWrap?.playlist?.subscribed ?? false) ? TablerIcons.hearts : TablerIcons.heart)),
                // ),
                IconButton(
                    onPressed: () {
                      // context.router.push(
                      //     const TalkView().copyWith(queryParams: {'id': (context.routeData.args as Play).id, 'type': 'playlist', 'name': (context.routeData.args as Play).name}));
                    },
                    icon: const Icon(TablerIcons.message_2)),
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                ((context.routeData.args as Play).description ?? '暂无描述').replaceAll('\n', ''),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 24.sp, height: 1.6, color: Theme.of(context).cardColor.withOpacity(.6)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(MediaItem mediaItem, int index,context) {
    return ListTile(
      title: Text(
        mediaItem.title,
        maxLines: 1,
      ),
      subtitle: Text(
        mediaItem.artist ?? '',
        maxLines: 1,
      ),
      trailing: IconButton(
          onPressed: () {
            showModalActionSheet(
              context: context,
              title: mediaItem.title,
              message: mediaItem.artist,
              actions: [const SheetAction<String>(label: '下一首播放', icon: TablerIcons.player_play, key: 'next')],
            ).then((value) {
              if (value != null) {
                if (Home.to.audioServeHandler.playbackState.value.queueIndex != 0) {
                  Home.to.audioServeHandler.insertQueueItem(Home.to.audioServeHandler.playbackState.value.queueIndex! + 1, mediaItem);
                  WidgetUtil.showToast('已添加到下一曲');
                } else {
                  WidgetUtil.showToast('未知错误');
                }
              }
            });
          },
          icon: const Icon(
            TablerIcons.dots_vertical,
          )),
      onTap: () {
        if(controller.isSearch.value){
          index = controller.mediaItems.indexOf(mediaItem);
        }
        Home.to.playByIndex(index, 'queueTitle', mediaItem: controller.mediaItems);
      },
    );
    // return InkWell(
    //   child: Container(
    //     padding: EdgeInsets.only(left: 30.w),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Text(
    //           mediaItem.title,
    //           maxLines: 1,
    //           style: TextStyle(fontSize: 30.sp),
    //         ),
    //         const Padding(padding: EdgeInsets.symmetric(vertical: 2)),
    //         Text(
    //           mediaItem.artist ?? '',
    //           maxLines: 1,
    //           style: TextStyle(fontSize: 24.sp, color: Colors.grey),
    //         )
    //       ],
    //     ),
    //   ),
    //   onTap: (){
    //     HomeController.to.playByIndex(index, 'queueTitle', mediaItem: controller.mediaItems);
    //   },
    // );
  }
}

class SongItem extends StatelessWidget {
  final int index;
  final List<MediaItem> mediaItems;
  final String queueTitle;
  final VoidCallback? voidCallback;

  const SongItem({Key? key, required this.index, required this.mediaItems, required this.queueTitle, this.voidCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.only(left: 30.w),
        height: 120.w,
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
        ),
        // child: Row(
        //   children: [
        //     Expanded(
        //         child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         Text(
        //           mediaItems[index].title,
        //           maxLines: 1,
        //           style: TextStyle(fontSize: 30.sp),
        //         ),
        //         Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
        //         Text(
        //           mediaItems[index].artist ?? '',
        //           maxLines: 1,
        //           style: TextStyle(fontSize: 24.sp, color: Colors.grey),
        //         )
        //       ],
        //     )),
        //     Visibility(
        //       visible: (mediaItems[index].extras!['mv'] ?? 0) != 0,
        //       child: IconButton(
        //           onPressed: () {
        //             context.router.push(const MvView().copyWith(queryParams: {'mvId': mediaItems[index].extras?['mv'] ?? 0}));
        //           },
        //           icon: const Icon(
        //             TablerIcons.brand_youtube,
        //             color: Colors.grey,
        //           )),
        //     ),
        //     IconButton(
        //         onPressed: () => _showSheet(context),
        //         icon: const Icon(
        //           TablerIcons.dots_vertical,
        //           color: Colors.grey,
        //         )),
        //   ],
        // ),
      ),
      onTap: () {
        // if (queueTitle.isEmpty) {
        //   WidgetUtil.showToast('id错误');
        //   return;
        // }
        Home.to.playByIndex(index, queueTitle, mediaItem: mediaItems);
      },
    );
  }

  void _showSheet(context) {
    showModalActionSheet(
      context: context,
      title: mediaItems[index].title,
      message: mediaItems[index].artist,
      actions: [
        const SheetAction<ActionType>(label: '下一首播放', icon: TablerIcons.player_play, key: ActionType.next),
        mediaItems[index].extras?['type'] == MediaType.local.name
            ? const SheetAction<ActionType>(label: '编辑歌曲信息', icon: TablerIcons.edit, key: ActionType.edit)
            : const SheetAction<ActionType>(label: '歌曲评论', icon: TablerIcons.message_2, key: ActionType.talk),
      ],
    ).then((value) {
      if (value != null) {
        switch (value) {
          case ActionType.next:
            _setNext();
            break;
          case ActionType.edit:
            GetIt.instance<RootRouter>().push(const EditSongView().copyWith(args: mediaItems[index])).then((value) {
              if (value != null) {
                if (value as bool) voidCallback?.call();
              }
            });
            break;
          case ActionType.talk:
            GetIt.instance<RootRouter>().push(const TalkView().copyWith(queryParams: {'id': mediaItems[index].id, 'type': 'song', 'name': mediaItems[index].title}));
            break;
        }
      }
    });
  }

  void _setNext() {
    if (Home.to.audioServeHandler.playbackState.value.queueIndex != 0) {
      Home.to.audioServeHandler.insertQueueItem(Home.to.audioServeHandler.playbackState.value.queueIndex! + 1, mediaItems[index]);
      WidgetUtil.showToast('已添加到下一曲');
    } else {
      WidgetUtil.showToast('未知错误');
    }
  }
}

enum ActionType { next, edit, talk }
