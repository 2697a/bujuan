import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/music_bottom_bar/music_bottom_bar_view.dart';
import 'package:bujuan/play_view/default_view.dart';
import 'package:bujuan/sheet_info/sheet_info_controller.dart';
import 'package:bujuan/sheet_info/sheet_loading_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';
import 'package:we_slide/we_slide.dart';

class SheetInfoView extends GetView<SheetInfoController> {
  @override
  Widget build(BuildContext context) {
    return _buildSheetView();
  }

  Widget _buildSheetView() {
    return Scaffold(
      body: AnnotatedRegion(
        child: WeSlide(
          controller: controller.weSlideController,
          panelMaxSize: MediaQuery.of(Get.context).size.height,
          panelMinSize: 65.0,
          body: _buildContent(),
          parallax: true,
          panel: DefaultView(weSlideController: controller.weSlideController),
          panelHeader: MusicBottomBarView(weSlideController: controller.weSlideController),
        ),
        value: !Get.isDarkMode
            ? SystemUiOverlayStyle.light.copyWith(
                systemNavigationBarColor: lightTheme.primaryColor,
              )
            : SystemUiOverlayStyle.dark.copyWith(
                systemNavigationBarColor: darkTheme.primaryColor,
              ),
      ),
    );
  }

  Widget _buildContent() {
    return OrientationBuilder(
      builder: (context, orientation) {
        return orientation == Orientation.portrait
            ? Obx(() => CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      elevation: 0.0,
                      floating: true,
                      pinned: true,
                      title: Text("${Get.arguments["name"]}"),
                      expandedHeight: 220.0,
                      flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
                        background: Padding(
                          padding: EdgeInsets.only(
                              left: 8.0, right: 8.0, bottom: 6.0),
                          child: Column(
                            children: [
                              Expanded(child: Container()),
                              Row(
                                children: [
                                  Hero(
                                      tag: "${Get.arguments["id"]}",
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(8.0)),
                                        clipBehavior: Clip.antiAlias,
                                        child: CachedNetworkImage(
                                          width: 150.0,
                                          height: 150.0,
                                          fit: BoxFit.fitWidth,
                                          imageUrl:
                                              "${Get.arguments["imageUrl"]}",
                                        ),
                                      )),
                                  Expanded(
                                      child: controller.loadState.value == 2
                                          ? Container(
                                              child: ListTile(
                                                title: Text(
                                                  "${controller.result.value.creator.nickname}",
                                                  style: TextStyle(
                                                      color:
                                                          Theme.of(Get.context)
                                                              .accentColor),
                                                ),
                                                subtitle: Text(
                                                  "${controller.result.value.creator.signature}",
                                                  maxLines: 4,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 4.0),
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
                    _buildSheetListView()
                  ],
                ))
            : Obx(() => Scaffold(
                  appBar: AppBar(
                    elevation: 0.0,
                    title: Text("${Get.arguments["name"]}"),
                  ),
                  body: Row(
                    children: [
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Row(
                          children: [
                            Hero(
                                tag: "${Get.arguments["id"]}",
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              8.0)),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    width: 150.0,
                                    height: 150.0,
                                    fit: BoxFit.fitWidth,
                                    imageUrl: "${Get.arguments["imageUrl"]}",
                                  ),
                                )),
                            Expanded(
                                child: controller.loadState.value == 2
                                    ? Container(
                                        child: ListTile(
                                          title: Text(
                                            "${controller.result.value.creator.nickname}",
                                            style: TextStyle(
                                                color: Theme.of(Get.context)
                                                    .accentColor),
                                          ),
                                          subtitle: Text(
                                            "${controller.result.value.creator.signature}",
                                            maxLines: 3,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    : Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
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
                        ),
                      )),
                      Expanded(
                          child: CustomScrollView(
                        slivers: [_buildSheetListView()],
                      ))
                    ],
                  ),
                ));
      },
    );
  }

  Widget _buildSheetListView() {
    return SheetLoadingView(
      state: controller.loadState.value,
      widget: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
              leading: Container(
                alignment: Alignment.center,
                constraints: BoxConstraints(maxWidth: 35.0),
                child: Text(
                  "${index + 1}",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
              subtitle: Text(controller.result.value.tracks[index].ar[0].name),
              title: Text(controller.result.value.tracks[index].name),
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
    );
  }
}
