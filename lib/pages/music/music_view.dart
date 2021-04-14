import 'package:bujuan/pages/music/music_controller.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MusicView extends GetView<MusicController> {
  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: SmartRefresher(
          controller: controller.refreshController,
          header: WaterDropMaterialHeader(
            color: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          onRefresh: () => controller.getAllArtists(),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Card(
                  child: InkWell(
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(5.0),
                          height: 120.0,
                          child: Image.asset('assets/images/local.png'),
                        ),
                        Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  height: 120,
                                  alignment: Alignment.center,
                                  child: const Text(
                                    '本地歌曲',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold, fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                    onTap: () => Get.toNamed('/all_song'),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "专辑",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      InkWell(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          children: [
                            Text('更多',
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12.0)),
                            Icon(Icons.keyboard_arrow_right,
                                size: 18.0, color: Colors.grey[500])
                          ],
                        ),
                        onTap: () {
                          if (!controller.isNoAlbum.value) {
                            Get.bottomSheet(
                              _showMoreAlbum(),
                              backgroundColor:
                                  Theme.of(Get.context).primaryColor,
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8.0),
                                    topRight: Radius.circular(8.0)),
                              ),
                            );
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(() => Container(
                    height: 180.0,
                    child: controller.isNoAlbum.value
                        ? Container(
                            height: 80.0,
                            child: Center(
                              child: Wrap(
                                children: [
                                  Icon(Icons.sentiment_neutral_outlined),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 6.0)),
                                  Text('暂无本地专辑')
                                ],
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemBuilder: (context, index) {
                              return InkWell(
                                child: Container(
                                  padding: EdgeInsets.only(right: 6.0),
                                  child: Column(
                                    children: [
                                      Card(
                                        child: controller.getLocalImage(
                                            controller.albums[index], 110.0),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 3.0),
                                        child: Text(
                                            '${controller.albums[index].albumName}'),
                                      ),
                                      Text(
                                        '${controller.albums[index].artist}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () {
                                  Get.toNamed('/local_album', arguments: {
                                    'albumName':
                                        controller.albums[index].albumName,
                                    'type': AudiosArgs.ALBUM
                                  });
                                },
                              );
                            },
                            itemCount: controller.albums.length > 8
                                ? 8
                                : controller.albums.length,
                            scrollDirection: Axis.horizontal,
                          ))),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "歌手",
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      InkWell(child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Text('更多',
                              style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 12.0)),
                          Icon(Icons.keyboard_arrow_right,
                              size: 18.0, color: Colors.grey[500])
                        ],
                      ),onTap: (){
                        if (!controller.isNoArtists.value) {
                          Get.bottomSheet(
                            _showMoreArtist(),
                            backgroundColor:
                            Theme.of(Get.context).primaryColor,
                            elevation: 6.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0)),
                            ),
                          );
                        }
                      },)
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Obx(() => controller.isNoArtists.value
                    ? Container(
                        height: 80.0,
                        child: Center(
                          child: Wrap(
                            children: [
                              Icon(Icons.sentiment_neutral_outlined),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.0)),
                              Text('暂无本地歌手')
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 8.0),
                            child: InkWell(
                                child: Row(
                                  children: [
                                    Card(
                                      color: Colors.blue[300].withOpacity(.3),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  45.0)),
                                      clipBehavior: Clip.antiAlias,
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 45.0,
                                        height: 45.0,
                                        child: Text(
                                            '${controller.artists[index].artistName}'
                                                .substring(0, 1)),
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                          controller.artists[index].artistName,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14.0)),
                                    )
                                  ],
                                ),
                                onTap: () {
                                  Get.toNamed('/local_album', arguments: {
                                    'albumName':
                                        controller.artists[index].artistName,
                                    'type': AudiosArgs.ARTIST
                                  });
                                }),
                          );
                        },
                        itemCount: controller.artists.length > 6
                            ? 6
                            : controller.artists.length,
                        shrinkWrap: true)),
              ),
            ],
          ),
        ));
  }

  Widget _showMoreAlbum() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 14.0, right: 3.0),
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '全部专辑',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              IconButton(icon: Icon(Icons.keyboard_arrow_down_rounded), onPressed: ()=>Get.back())
            ],
          ),
        ),
        Expanded(
            child: Obx(() => ListView.builder(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                  itemBuilder: (context, index) => InkWell(
                    child: Container(
                      height: 60.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            child: controller.getLocalImage(
                                controller.albums[index], 45.0),
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 8.0)),
                          Expanded(
                              child: Column(
                            children: [
                              Container(
                                height: 30,
                                alignment: Alignment.centerLeft,
                                child: Text(controller.albums[index].albumName,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 16.0)),
                              ),
                              Container(
                                height: 30,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    '${controller.albums[index].albumName}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey[500])),
                              )
                            ],
                          )),
                          Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.0))
                        ],
                      ),
                    ),
                    onTap: () {
                      Get.back();
                      Get.toNamed('/local_album', arguments: {
                        'albumName':
                        controller.albums[index].albumName,
                        'type': AudiosArgs.ALBUM
                      });
                    },
                  ),
                  itemCount: controller.albums.length,
                )))
      ],
    );
  }


  Widget _showMoreArtist() {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(left: 14.0, right: 3.0),
          height: 56.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '全部歌手',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              IconButton(icon: Icon(Icons.keyboard_arrow_down_rounded), onPressed: ()=>Get.back())
            ],
          ),
        ),
        Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
              itemBuilder: (context, index) => InkWell(
                  child: Row(
                    children: [
                      Card(
                        color: Colors.blue[300].withOpacity(.3),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                            BorderRadiusDirectional.circular(
                                45.0)),
                        clipBehavior: Clip.antiAlias,
                        child: Container(
                          alignment: Alignment.center,
                          width: 45.0,
                          height: 45.0,
                          child: Text(
                              '${controller.artists[index].artistName}'
                                  .substring(0, 1)),
                        ),
                      ),
                      Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 8.0),
                        alignment: Alignment.center,
                        child: Text(
                            controller.artists[index].artistName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14.0)),
                      )
                    ],
                  ),
                  onTap: () {
                    Get.toNamed('/local_album', arguments: {
                      'albumName':
                      controller.artists[index].artistName,
                      'type': AudiosArgs.ARTIST
                    });
                  }),
              itemCount: controller.artists.length,
            )))
      ],
    );
  }
}
