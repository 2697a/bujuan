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
                          if (!controller.search.value) controller.textEditingController.text = '';
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
                                child: SongItem(
                                  index: index,
                                  mediaItem: controller.isSearch.value ? controller.searchItems[index] : controller.mediaItems[index],
                                  queueTitle: 'queueTitle',
                                  voidCallback: () {
                                    if (controller.isSearch.value) {
                                      index = controller.mediaItems.indexOf(controller.searchItems[index]);
                                    }
                                    Home.to.playByIndex(index, 'queueTitle', mediaItem: controller.mediaItems);
                                  },
                                ),
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
                IconButton(onPressed: () => controller.subscribePlayList(), icon: Obx(() => Icon(controller.sub.value ? TablerIcons.hearts : TablerIcons.heart))),
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
}

class SongItem extends StatelessWidget {
  final int index;
  final MediaItem mediaItem;
  final String queueTitle;
  final VoidCallback? voidCallback;

  const SongItem({Key? key, required this.index, required this.mediaItem, required this.queueTitle, this.voidCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.compact,
      leading: Text('${index + 1}'),
      horizontalTitleGap: 0.w,
      title: RichText(
          text: TextSpan(text: mediaItem.title, style: TextStyle(fontSize: 30.sp, color: Theme.of(context).iconTheme.color), children: [
        TextSpan(text: mediaItem.extras?['fee'] == 1 ? '   vip' : '', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9), fontSize: 26.sp)),
      ])),
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
      onTap: () => voidCallback?.call(),
    );
  }
}

enum ActionType { next, edit, talk }
