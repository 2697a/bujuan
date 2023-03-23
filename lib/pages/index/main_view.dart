import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/pages/user/user_controller.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/router.dart';
import '../../routes/router.gr.dart' as gr;
import '../../widget/app_bar.dart';
import '../../widget/simple_extended_image.dart';
import '../play_list/playlist_view.dart';

class MainView extends GetView<IndexController> {
  const MainView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        centerTitle: false,
        leading: IconButton(
            onPressed: () {
              if (Home.to.loginStatus.value == LoginStatus.login) {
                Home.to.myDrawerController.open!();
                return;
              }
              AutoRouter.of(context).pushNamed(Routes.login);
            },
            icon: Obx(() => SimpleExtendedImage.avatar(
                  Home.to.userData.value.profile?.avatarUrl ?? '',
                  width: 80.w,
                ))),
        title: RichText(
            text: TextSpan(style: TextStyle(fontSize: 36.sp, color: Colors.grey, fontWeight: FontWeight.bold), text: 'Here  ', children: [
          TextSpan(text: '每日发现～', style: TextStyle(color: Theme.of(context).primaryColor.withOpacity(.9))),
        ])),
      ),
      body: Obx(() => Visibility(
            visible: !controller.loading.value,
            replacement: const LoadingView(),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildHeader('歌单推荐', context),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverGrid.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, childAspectRatio: .75, mainAxisSpacing: 10.0, crossAxisSpacing: 10.0),
                      itemBuilder: (context, index) => _buildItem(controller.playlist[index], context),
                      itemCount: controller.playlist.length,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false),
                ),
                SliverToBoxAdapter(
                  child: _buildHeader('新歌推荐', context),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(
                          (context, index) => SongItemShowImage(
                                index: index,
                                mediaItem: controller.newSong[index],
                                onTap: () {
                                  Home.to.playByIndex(index, 'queueTitle', mediaItem: controller.newSong);
                                },
                              ),
                          childCount: controller.newSong.length,
                          addAutomaticKeepAlives: false,
                          addRepaintBoundaries: false),
                      itemExtent: 140.w),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buildHeader(String title, BuildContext context, {VoidCallback? onTap}) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.w),
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(6.w)),
              width: 10.w,
              height: 10.w,
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: 15.w)),
            Text(
              title,
              style: TextStyle(fontSize: 34.sp, color: Theme.of(context).iconTheme.color),
            ),
          ],
        ),
      ),
      onTap: () => onTap?.call(),
    );
  }

  Widget _buildItem(Play albumModel, BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: InkWell(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SimpleExtendedImage(
              '${albumModel.picUrl ?? ''}?param=230y230',
              borderRadius: BorderRadius.all(Radius.circular(25.w)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 2.w),
                  child: Text(
                    albumModel.name ?? '',
                    style: TextStyle(fontSize: 28.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => context.router.push(const gr.PlayListView().copyWith(args: albumModel)),
      ),
    );
  }

// Widget _buildTopCard() {
//   return ListView.builder(
//     padding: EdgeInsets.symmetric(horizontal: 15.w),
//     shrinkWrap: true,
//     physics: const NeverScrollableScrollPhysics(),
//     itemBuilder: (context, index) => _buildSongItem(controller.songs[index], index),
//     itemCount: controller.songs.length > 10 ? 10 : controller.songs.length,
//   );
// }

// Widget _buildSongItem(SongModel data, int index) {
//   return InkWell(
//     child: Container(
//       margin: EdgeInsets.symmetric(vertical: 10.w),
//       padding: EdgeInsets.symmetric(vertical: 5.w),
//       child: Row(
//         children: [
//           SimpleExtendedImage(
//             '${HomeController.to.directoryPath}${data.albumId}',
//             cacheWidth: 200,
//             width: 90.w,
//             height: 90.w,
//             borderRadius: BorderRadius.circular(10.w),
//           ),
//           Expanded(
//               child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   data.title,
//                   style: TextStyle(fontSize: 28.sp),
//                 ),
//                 Text(
//                   '${data.artist ?? 'No Artist'} - ${ImageUtils.getTimeStamp(data.duration ?? 0)}',
//                   style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.normal),
//                 ),
//               ],
//             ),
//           )),
//         ],
//       ),
//     ),
//     onTap: () => controller.play(index),
//   );
// }
}
