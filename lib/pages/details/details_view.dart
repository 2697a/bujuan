import 'package:bujuan/common/bean/playlist_entity.dart';
import 'package:bujuan/common/bean/song_details_entity.dart';
import 'package:bujuan/pages/details/details_controller.dart';
import 'package:bujuan/widget/request_widget.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
          headerSliverBuilder:(BuildContext context, bool innerBoxIsScrolled)=> [
        SliverAppBar(
          pinned: true,
          //滚动是是否拉伸图片
          stretch: true,
          expandedHeight: 500.w,
          snap: false,
          elevation: 0,
          title: innerBoxIsScrolled?Text(controller.detailsArguments?.personalizedResult.name??''):const SizedBox.shrink(),
          flexibleSpace:  FlexibleSpaceBar(
            background: Hero(tag: controller.detailsArguments?.personalizedResult.id??'', child: SimpleExtendedImage(
              controller.detailsArguments?.personalizedResult.picUrl??'',
              height: 450.w,
              width: Get.width,
              borderRadius: BorderRadius.circular(30.w),
            )),
          ),
        )
      ], body: RequestBox<PlaylistEntity>(
        url: '/playlist/detail',
        data: {'id': controller.detailsArguments?.personalizedResult.id},
        childBuilder: (playListDetails) {
          return RequestBox<SongDetailsEntity>(
            url: '/song/detail',
            data: {'ids': playListDetails.playlist?.trackIds?.map((e) => e.id).toList()},
            onSuccess: (data) {
              print('object========sd==sa=d=');
              controller.initSong(data.songs!);
            },
            childBuilder: (data) => ListView.builder(
              padding: const EdgeInsets.all(0),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => _buildItem(data.songs![index],index),
              itemCount: data.songs?.length ?? 0,
            ),
          );
        },
      )),
    );
    // return Scaffold(
    //   body: CustomScrollView(
    //     slivers: [
    //       SliverToBoxAdapter(child: Hero(tag: controller.detailsArguments?.personalizedResult.id??'', child: SimpleExtendedImage(
    //         controller.detailsArguments?.personalizedResult.picUrl??'',
    //         height: 450.w,
    //         width: Get.width,
    //         borderRadius: BorderRadius.circular(30.w),
    //       )),),
    //       SliverToBoxAdapter(
    //         child: RequestBox<PlaylistEntity>(
    //           url: '/playlist/detail',
    //           data: {'id': controller.detailsArguments?.personalizedResult.id},
    //           childBuilder: (playListDetails) {
    //             return RequestBox<SongDetailsEntity>(
    //               url: '/song/detail',
    //               data: {'ids': playListDetails.playlist?.trackIds?.map((e) => e.id).toList()},
    //               onSuccess: (data) {
    //                 print('object========sd==sa=d=');
    //                 controller.initSong(data.songs!);
    //               },
    //               childBuilder: (data) => ListView.builder(
    //                 shrinkWrap: true,
    //                 physics: const NeverScrollableScrollPhysics(),
    //                 itemBuilder: (context, index) => _buildItem(data.songs![index],index),
    //                 itemCount: data.songs?.length ?? 0,
    //               ),
    //             );
    //           },
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget _buildItem(SongDetailsSongs data,int index) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
        child: Row(
          children: [
            SimpleExtendedImage.avatar(
              data.al?.picUrl ?? '',
              width: 80.w,
              height: 80.w,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
            Expanded(child: Text(data.name ?? ''))
          ],
        ),
      ),
      onTap: () => controller.playByIndex(index),
    );
  }
}
