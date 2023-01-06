import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';

import '../../../common/netease_api/src/api/play/bean.dart';
import '../../../routes/router.gr.dart';

class RecommendView extends GetView<HomeController> {
  const RecommendView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
            child: Obx(() => Text(
                  '歌手',
                  style: TextStyle(fontSize: 36.sp, color: controller.rx.value.main?.bodyTextColor, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
          ),
          _buildAirList(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
            child: Obx(() => Text(
                  '专辑',
                  style: TextStyle(fontSize: 36.sp, color: controller.rx.value.main?.bodyTextColor, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
          ),
          _buildAlbum(),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(top: 10.w, bottom: 20.w),
            child: Obx(() => Text(
                  '相似歌单',
                  style: TextStyle(fontSize: 36.sp, color: controller.rx.value.main?.bodyTextColor, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                )),
          ),
          _buildSimSongListView(),
        ],
      ),
    );
  }

  Widget _buildAirList() {
    return Obx(() {
      var artists = controller.mediaItem.value.extras!['artist']?.split(' / ').map((e) => Artists.fromJson(jsonDecode(e))).toList() ?? [];
      return ListView.builder(
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.symmetric(vertical: 20.w),
          child: Obx(() => Row(
                children: [
                  Expanded(
                      child: Text(
                    artists[index].name ?? '',
                    maxLines: 1,
                    style: TextStyle(fontSize: 30.sp, color: controller.rx.value.main?.bodyTextColor),
                  )),
                  Icon(
                    TablerIcons.chevron_right,
                    color: controller.rx.value.main?.bodyTextColor.withOpacity(.4),
                    size: 38.sp,
                  ),
                ],
              )),
        ),
        itemCount: artists.length,
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
        physics: const NeverScrollableScrollPhysics(),
      );
    });
  }

  Widget _buildAlbum() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.w),
      child: Obx(() => Row(
            children: [
              SimpleExtendedImage.avatar(
                '${Album.fromJson(jsonDecode(controller.mediaItem.value.album ?? '')).picUrl ?? ''}?param=200y200',
                width: 60.w,
                height: 60.w,
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 8.w)),
              Expanded(
                  child: Text(
                Album.fromJson(jsonDecode(controller.mediaItem.value.album ?? '')).name ?? '',
                maxLines: 1,
                style: TextStyle(fontSize: 30.sp, color: controller.rx.value.main?.bodyTextColor),
              )),
              Icon(
                TablerIcons.chevron_right,
                color: controller.rx.value.main?.bodyTextColor.withOpacity(.4),
                size: 38.sp,
              ),
            ],
          )),
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
                  '${play.coverImgUrl ?? ''}?param=200y200',
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
                      style: TextStyle(fontSize: 30.sp, color: controller.rx.value.main?.bodyTextColor),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 4.w)),
                    Text(
                      '${play.trackCount ?? 0}',
                      maxLines: 1,
                      style: TextStyle(fontSize: 24.sp, color: controller.rx.value.main?.bodyTextColor.withOpacity(.4)),
                    )
                  ],
                )),
              ],
            ),
          )),
      onTap: () {
        controller.panelController.close();
        controller.panelControllerHome.close().then((value) {
          context.router.push(const PlayListView().copyWith(args: play));
        });
      },
    );
  }
}
