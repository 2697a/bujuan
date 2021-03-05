import 'package:bujuan/bottom_bar/bottom_bar_controller.dart';
import 'package:bujuan/bottom_bar/bottom_bar_view.dart';
import 'package:bujuan/sheet_info/sheet_info_controller.dart';
import 'package:bujuan/sheet_info/sheet_loading_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:starry/starry.dart';
import 'package:starry/song_info.dart';

class SheetInfoView extends GetView<SheetInfoController> {
  final id;
  final imageUrl;

  SheetInfoView(this.id, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    controller.getSheetInfo(id);
    return Scaffold(
      body: BottomBarView(
        isShowBottom: false,
        panelController: controller.panelController,
        body: Obx(() => CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: Text("data"),
                  expandedHeight: 220.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                        tag: "$id",
                        child: CachedNetworkImage(
                          fit: BoxFit.fitWidth,
                          imageUrl: "$imageUrl?param=500y500",
                        )),
                  ),
                ),
                SheetLoadingView(
                  state: controller.loadState.value,
                  widget: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          leading: Text("${index + 1}"),
                          subtitle: Text(controller.result.value.tracks[index].ar[0].name),
                          title: Text(controller.result.value.tracks[index].name),
                          onTap: () {
                            var songs = List<SongInfo>();
                            controller.result.value.tracks.forEach((element) {
                              SongInfo songInfo = SongInfo(
                                songId: "${element.id}",
                                duration: element.dt,
                                songCover: element.al.picUrl,
                                songName: element.name,
                                artist: element.ar[0].name,
                              );
                              songs.add(songInfo);
                            });
                            Starry.playMusic(songs, index);
                            Get.find<BottomBarController>().changeSong(controller.result.value.tracks[index]);
                          },
                        );
                      },
                      childCount: controller.result.value.tracks == null ? 0 : controller.result.value.tracks.length,
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   controller.getSheetInfo(id);
//   return Scaffold(
//     body: BottomBarView(
//       panelController: controller.panelController,
//       body: Obx(() => StateView(
//             controller.loadState.value,
//             widget: Scaffold(
//               appBar: AppBar(
//                 title: Text("${controller.result.value.name}"),
//               ),
//               body: ListView.builder(
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     subtitle: Text(controller.result.value.tracks[index].ar[0].name),
//                     title: Text(controller.result.value.tracks[index].name),
//                     onTap: () {
//                       Get.find<BottomBarController>().changeSong(controller.result.value.tracks[index]);
//                     },
//                   );
//                 },
//                 itemCount: controller.result.value.tracks == null ? 0 : controller.result.value.tracks.length,
//               ),
//             ),
//           )),
//     ),
//   );
// }
}
