import 'package:bujuan/bottom_bar/bottom_bar_view.dart';
import 'package:bujuan/sheet_info/head.dart';
import 'package:bujuan/sheet_info/sheet_info_controller.dart';
import 'package:bujuan/sheet_info/sheet_loading_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';

class SheetInfoView extends GetView<SheetInfoController> {
  final id;
  final imageUrl;
  final name;

  SheetInfoView(this.id, this.imageUrl, this.name);

  @override
  Widget build(BuildContext context) {
    controller.getSheetInfo(id);
    return BottomBarView(
      isShowBottom: false,
      panelController: controller.panelController,
      body: Obx(() => CustomScrollView(
            slivers: [
              // SliverPersistentHeader(
              //   pinned: true,
              //     floating: true,
              //     delegate: SliverAppBarDelegate(
              //         minHeight: 80,
              //         maxHeight: 250,
              //         child:  Hero(
              //             tag: "$id",
              //             child: Card(
              //               shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(8.0)),
              //               clipBehavior: Clip.antiAlias,
              //               child: CachedNetworkImage(
              //                 width: 150.0,
              //                 height: 150.0,
              //                 fit: BoxFit.fitWidth,
              //                 imageUrl: "$imageUrl?param=300y300",
              //               ),
              //             )))),
              SliverAppBar(
                elevation: 0.0,
                floating: true,
                pinned: true,
                title: Text("$name"),
                expandedHeight: 220.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8.0, bottom: 6.0),
                    child: Column(
                      children: [
                        Expanded(child: Container()),
                        Row(
                          children: [
                            Hero(
                                tag: "$id",
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(8.0)),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.fitWidth,
                                    imageUrl: "$imageUrl?param=300y300",
                                  ),
                                )),
                            Expanded(child: controller.loadState.value == 2 ? Container(
                              child: ListTile(
                                title: Text("${controller.result.value.creator.nickname}",style: TextStyle(color: Theme.of(Get.context).accentColor),),
                                subtitle: Text("${controller.result.value.creator.signature}"),
                              ),
                            ) : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0),
                              child: PlaceholderLines(
                                count: 4,
                                maxWidth: 0.9,
                                minWidth: 0.6,
                                align: TextAlign.left,
                                animate: true,
                                color: Colors.grey[400],
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: EdgeInsets.symmetric(horizontal: 5.0),
              //     child: Row(
              //       children: [
              //         Hero(
              //             tag: "$id",
              //             child: Card(
              //               shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(8.0)),
              //               clipBehavior: Clip.antiAlias,
              //               child: CachedNetworkImage(
              //                 width: 150.0,
              //                 height: 150.0,
              //                 fit: BoxFit.fitWidth,
              //                 imageUrl: "$imageUrl?param=300y300",
              //               ),
              //             )),
              //         Expanded(child: Container())
              //       ],
              //     ),
              //   ),
              // ),
              SheetLoadingView(
                state: controller.loadState.value,
                widget: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return ListTile(
                        subtitle: Text(controller.result.value.tracks[index].ar[0].name),
                        title: Text(controller.result.value.tracks[index].name),
                        onTap: () {
                          controller.playSong(index);
                        },
                      );
                    },
                    childCount: controller.result.value.tracks == null ? 0 : controller.result.value.tracks.length,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
