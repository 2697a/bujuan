import 'dart:convert';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/enmu.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/home/view/panel_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:get/get.dart';

import '../../../common/netease_api/src/api/play/bean.dart';

class RecommendView extends GetView<Home> {
  const RecommendView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    return controller.landscape
        ? Column(
      children: [
        Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
        ClipRRect(
          borderRadius: BorderRadius.circular(controller.panelMobileMinSize / 2),
          child: Obx(() => SimpleExtendedImage(
            '${Home.to.mediaItem.value.extras?['image'] ?? ''}?param=500y500',
            width: 630.w,
            height: 630.w,
          )),
        ),
        Container(
          padding: EdgeInsets.only(left: 45.w, top: 30.w, right: 45.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(
                controller.mediaItem.value.title.fixAutoLines(),
                style: TextStyle(fontSize: 38.sp, fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.w)),
              Obx(() => Text(
                (controller.mediaItem.value.artist ?? '').fixAutoLines(),
                style: TextStyle(fontSize: 28.sp),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ))
            ],
          ),
        ),
        // //操控区域
        _buildPlayController(context),
        //进度条
        _buildSlide(context),
        // 功能按钮
        SizedBox(
          height: controller.panelMobileMinSize + MediaQuery.of(context).padding.bottom,
        ),
      ],
    )
        : Obx(() {
            return Visibility(
              visible: controller.mediaItem.value.extras?['type'] != MediaType.local.name,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 20.w),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                      child: Obx(() => Text(
                            '歌手',
                            style: TextStyle(fontSize: 36.sp, color: controller.bodyColor.value, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          )),
                    ),
                    _buildArtistsList(),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                    //   child: Obx(() => Text(
                    //     '专辑',
                    //     style: TextStyle(fontSize: 36.sp, color: controller.bodyColor.value, fontWeight: FontWeight.bold),
                    //     textAlign: TextAlign.left,
                    //   )),
                    // ),
                    // ClassWidget(child: _buildAlbum(context)),
                    // Container(
                    //   alignment: Alignment.centerLeft,
                    //   padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
                    //   child: Obx(() => Text(
                    //         '相似歌单',
                    //         style: TextStyle(fontSize: 36.sp, color: controller.bodyColor.value, fontWeight: FontWeight.bold),
                    //         textAlign: TextAlign.left,
                    //       )),
                    // ),
                    // _buildSimSongListView(),
                  ],
                ),
              ),
            );
          });
  }

  Widget _buildSlide(BuildContext context) {
    return Container(
      width: 750.w,
      padding: EdgeInsets.only(left: 60.w, right: 60.w, bottom: 50.w),
      height: 100.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            addAutomaticKeepAlives: false,
            cacheExtent: 1.3,
            addRepaintBoundaries: false,
            addSemanticIndexes: false,
            itemBuilder: (context, index) => Container(
              margin: EdgeInsets.symmetric(vertical: controller.mEffects[index]['size'] / 2, horizontal: 5.w),
              decoration: BoxDecoration(color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(4)),
              width: 1.8,
            ),
            itemCount: controller.mEffects.length,
          ),
          Obx(() => ProgressBar(
                progress: controller.duration.value,
                buffered: controller.duration.value,
                total: controller.mediaItem.value.duration ?? const Duration(seconds: 10),
                progressBarColor: Colors.transparent,
                baseBarColor: Colors.transparent,
                bufferedBarColor: Colors.transparent,
                thumbColor: (Theme.of(context).iconTheme.color ?? Colors.black),
                barHeight: 0.w,
                thumbRadius: 20.w,
                barCapShape: BarCapShape.square,
                timeLabelType: TimeLabelType.remainingTime,
                timeLabelLocation: TimeLabelLocation.none,
                timeLabelTextStyle: TextStyle(color: (Theme.of(context).iconTheme.color ?? Colors.black), fontSize: 28.sp),
                onSeek: (duration) => controller.audioServeHandler.seek(duration),
              ))
        ],
      ),
    );
  }

  // height:329.h-MediaQuery.of(context).padding.top,
  Widget _buildPlayController(BuildContext context) {
    return Expanded(
        child: Container(
      width: 750.w,
      padding: EdgeInsets.symmetric(horizontal: 35.w, vertical: 30.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () => controller.likeSong(),
              icon: Obx(() => Icon(controller.likeIds.contains(int.tryParse(controller.mediaItem.value.id)) ? TablerIcons.heartbeat : TablerIcons.heart, size: 46.w))),
          IconButton(
              onPressed: () {
                if (controller.fm.value) {
                  return;
                }
                if (controller.intervalClick(1)) {
                  controller.audioServeHandler.skipToPrevious();
                }
              },
              icon: Icon(
                TablerIcons.player_skip_back,
                size: 46.w,
              )),
          InkWell(
            child: Obx(() => Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 5.h),
              height: 105.w,
              width: 105.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(80.w),
                border: Border.all(color: (Theme.of(context).iconTheme.color ?? Colors.black).withOpacity(.04), width: 5.w),
                color: (Theme.of(context).iconTheme.color ?? Colors.black).withOpacity(0.06),
              ),
              child: Icon(
                controller.playing.value ? TablerIcons.player_pause : TablerIcons.player_play,
                size: 54.w,
              ),
            )),
            onTap: () => controller.playOrPause(),
          ),
          IconButton(
              onPressed: () {
                if (controller.intervalClick(1)) {
                  controller.audioServeHandler.skipToNext();
                }
              },
              icon: Icon(
                TablerIcons.player_skip_forward,
                size: 46.w,
              )),
          IconButton(
              onPressed: () {
                if (controller.fm.value) {
                  return;
                }
                controller.changeRepeatMode();
              },
              icon: Obx(() => Icon(
                    controller.getRepeatIcon(),
                    size: 43.w,
                  ))),
        ],
      ),
    ));
  }

  Widget _buildArtistsList() {
    return Obx(() {
      return Visibility(
        visible: controller.mediaItem.value.extras!['artist'] != null,
        child: ListView.builder(
          itemBuilder: (context, index) => InkWell(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 20.w),
              child: Obx(() => Row(
                    children: [
                      Expanded(
                          child: Text(
                        (controller.mediaItem.value.extras!['artist']?.split(' / ').map((e) => Artists.fromJson(jsonDecode(e))).toList() ?? [])[index].name ?? '',
                        maxLines: 1,
                        style: TextStyle(fontSize: 30.sp, color: controller.bodyColor.value),
                      )),
                      Icon(
                        TablerIcons.chevron_right,
                        color: controller.bodyColor.value,
                        size: 38.sp,
                      ),
                    ],
                  )),
            ),
            onTap: () {
              controller.panelController.close().then((value) {
                controller.panelControllerHome.close();
                context.router.push(const ArtistsView()
                    .copyWith(args: (controller.mediaItem.value.extras!['artist']?.split(' / ').map((e) => Artists.fromJson(jsonDecode(e))).toList() ?? [])[index]));
              });
            },
          ),
          itemCount: (controller.mediaItem.value.extras!['artist']?.split(' / ').map((e) => Artists.fromJson(jsonDecode(e))).toList() ?? []).length,
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
        ),
      );
    });
  }

  Widget _buildAlbum(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Obx(() {
        if ((controller.mediaItem.value.extras?['album'] ?? '').isEmpty) return const SizedBox.shrink();
        return Row(
          children: [
            SimpleExtendedImage.avatar(
              '${Album.fromJson(jsonDecode(controller.mediaItem.value.album ?? '')).picUrl ?? ''}?param=100y100',
              width: 60.w,
              height: 60.w,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 8.w)),
            Expanded(
                child: Text(
              Album.fromJson(jsonDecode(controller.mediaItem.value.album ?? '')).name ?? '',
              maxLines: 1,
              style: TextStyle(fontSize: 30.sp, color: controller.bodyColor.value),
            )),
            Icon(
              TablerIcons.chevron_right,
              color: controller.bodyColor.value,
              size: 38.sp,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildSimSongListView() {
    return Obx(() => ListView.builder(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemExtent: 110.w,
          itemBuilder: (context, index) => _buildPlayListItem(controller.simiSongs[index], index, context),
          itemCount: controller.simiSongs.length,
        ));
  }

  Widget _buildPlayListItem(Play play, int index, BuildContext context) {
    return InkWell(
      child: Obx(() => SizedBox(
            width: Get.width,
            height: 110.w,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SimpleExtendedImage.avatar(
                  '${play.coverImgUrl ?? ''}?param=150y150',
                  width: 80.w,
                  height: 80.w,
                ),
                Padding(padding: EdgeInsets.only(left: 16.w)),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      play.name ?? '',
                      maxLines: 1,
                      style: TextStyle(fontSize: 30.sp, color: controller.bodyColor.value),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4.w)),
                    Text(
                      '${play.trackCount ?? 0}',
                      maxLines: 1,
                      style: TextStyle(fontSize: 24.sp, color: controller.bodyColor.value),
                    )
                  ],
                )),
              ],
            ),
          )),
      onTap: () {
        controller.panelController.close();
        controller.panelControllerHome.close();
        // context.router.push(const PlayListView().copyWith(args: play));
      },
    );
  }
}
