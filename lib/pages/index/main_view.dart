import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/home/first/first_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../../common/constants/other.dart';
import '../../routes/router.gr.dart';
import '../../widget/simple_extended_image.dart';
import '../home/home_controller.dart';

class MainView extends GetView<IndexController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.buildContext = context;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              if (controller.login.value) {
                controller.myDrawerController.open!();
                return;
              }
            },
            icon: Obx(() => SimpleExtendedImage.avatar('${HomeController.to.login.value ? UserController.to.userData.value.profile?.avatarUrl : ''}'))),
        title: RichText(
            text: TextSpan(style: TextStyle(fontSize: 42.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
              TextSpan(
                  text: '推荐歌单～',
                  style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
            ])),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: FirstController.to.getHomeBottomPadding(), top: 20.w),
        child: Column(
          children: [
            FutureBuilder<List<Play>>(
              future: controller.getSheetData(),
                builder: (c, s) => DataView<List<Play>>(
                      childBuilder: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: FirstController.to.getHomeBottomPadding()),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: .73,
                          crossAxisSpacing: 20.w,
                        ),
                        itemBuilder: (context, index) => _buildItem((s.data??[])[index], c),
                        itemCount: (s.data??[]).length,
                      ),
                      snapshot: s,
                    ))
          ],
        ),
      ),
    );
  }


  Widget _buildItem(Play albumModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.w),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleExtendedImage(
              '${albumModel.picUrl??''}?param=400y400',
              cacheWidth: 400,
              width: (Get.width-90.w) / 3,
              height: (Get.width-90.w) / 3,
              borderRadius: BorderRadius.all(Radius.circular(20.w)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                  child: Text(
                    albumModel.name??'',
                    style: TextStyle(fontSize: 28.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => context.router.push(const PlayList().copyWith(args: albumModel)),
      ),
    );
  }

  Widget _buildTopCard() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => _buildSongItem(controller.songs[index], index),
      itemCount: controller.songs.length > 10 ? 10 : controller.songs.length,
    );
  }

  Widget _buildSongItem(SongModel data, int index) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.w),
        padding: EdgeInsets.symmetric(vertical: 5.w),
        child: Row(
          children: [
            SimpleExtendedImage(
              '${HomeController.to.directoryPath}${data.albumId}',
              cacheWidth: 200,
              width: 90.w,
              height: 90.w,
              borderRadius: BorderRadius.circular(10.w),
            ),
            Expanded(
                child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.title,
                    style: TextStyle(fontSize: 28.sp),
                  ),
                  Text(
                    '${data.artist ?? 'No Artist'} - ${ImageUtils.getTimeStamp(data.duration ?? 0)}',
                    style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
      onTap: () => controller.play(index),
    );
  }


}
