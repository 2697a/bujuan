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
      backgroundColor: Colors.white,
      body: RequestBox<PlaylistEntity>(
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
              itemBuilder: (context, index) => _buildItem(data.songs![index],index),
              itemCount: data.songs?.length ?? 0,
            ),
          );
        },
      ),
    );
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
