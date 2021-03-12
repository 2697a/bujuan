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
  final name;

  SheetInfoView(this.id, this.imageUrl, this.name);

  @override
  Widget build(BuildContext context) {
    controller.getSheetInfo(id);
    return Scaffold(
      body: BottomBarView(
        isShowBottom: false,
        lyricController: controller.lyricController,
        panelController: controller.panelController,
        body: Obx(() => CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                    child: AppBar(
                  title: Text("$name"),
                )),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.0),
                    child: Row(
                      children: [
                        Hero(
                            tag: "$id",
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(8.0)),
                              clipBehavior: Clip.antiAlias,
                              child: CachedNetworkImage(
                                width: 150.0,
                                height: 150.0,
                                fit: BoxFit.fitWidth,
                                imageUrl: "$imageUrl?param=300y300",
                              ),
                            )),
                        Expanded(child: Container())
                      ],
                    ),
                  ),
                ),
                SheetLoadingView(
                  state: controller.loadState.value,
                  widget: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return ListTile(
                          subtitle: Text(
                              controller.result.value.tracks[index].ar[0].name),
                          title:
                              Text(controller.result.value.tracks[index].name),
                          onTap: () {
                            controller.playSong(index);
                          },
                        );
                      },
                      childCount: controller.result.value.tracks == null
                          ? 0
                          : controller.result.value.tracks.length,
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
