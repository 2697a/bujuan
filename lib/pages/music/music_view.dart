import 'dart:io';
import 'dart:typed_data';

import 'package:bujuan/pages/music/music_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_music_query/flutter_music_query.dart';
import 'package:get/get.dart';

import '../../main.dart';

class MusicView extends GetView<MusicController> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Card(
            child: InkWell(
              child: Container(
                alignment: Alignment.center,
                height: 120.0,
                child: Text('所有歌曲'),
              ),
              onTap: () => Get.toNamed('/all_song'),
            ),
          ),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Text(
              "歌手",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() => SizedBox(
                height: 160.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: (MediaQuery.of(Get.context).size.width - 10) / 3,
                        alignment: Alignment.center,
                        child: Card(
                          child: InkWell(
                              child: Container(
                                width: 120,
                                child: Column(
                                  children: [
                                    Hero(
                                      tag: 'ads',
                                      child: Container(
                                          height: 110.0,
                                          child: (controller.artists[index]
                                                      .artistArtPath ==
                                                  null)
                                              ? FutureBuilder<Uint8List>(
                                                  future: Get.find<
                                                          FileService>()
                                                      .audioQuery
                                                      .getArtwork(
                                                          type: ResourceType
                                                              .ARTIST,
                                                          id: controller
                                                              .artists[index]
                                                              .id),
                                                  builder: (_, snapshot) {
                                                    if (snapshot.data == null)
                                                      return Container(
                                                        height: 120.0,
                                                        child: Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        ),
                                                      );
                                                    return Image.memory(
                                                      snapshot.data,
                                                      fit: BoxFit.cover,
                                                      width: 120,
                                                    );
                                                  })
                                              :
                                              // or you can load image from File path if available.
                                              Image.file(
                                                  File(controller.artists[index]
                                                      .artistArtPath),
                                                  fit: BoxFit.cover,
                                                )),
                                    ),
                                    Container(
                                      height: 35.0,
                                      alignment: Alignment.center,
                                      constraints:
                                          BoxConstraints(maxWidth: 110.0),
                                      child: Text(
                                          controller.artists[index].name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 14.0)),
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {}),
                        ),
                      );
                    },
                    itemCount: controller.artists.length,
                    shrinkWrap: true),
              )),
        ),
        const SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Text(
              "专辑",
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Obx(() => ListView.builder(
              padding: EdgeInsets.all(0.0),
              itemBuilder: (context, index) {
                return Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(vertical: 15.0,horizontal: 8.0),
                  child: Text('${index+1}. ${controller.albums[index].title} - ${controller.albums[index].artist}'),
                );
              },
              itemCount: controller.albums.length,
              shrinkWrap: true)),
        )
      ],
    );
  }
}
