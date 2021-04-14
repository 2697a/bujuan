import 'package:bujuan/global/global_loding_view.dart';
import 'package:bujuan/pages/music/album/local_album_controller.dart';
import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocalAlbumView extends GetView<LocalAlbumController>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PlayWidgetView(
          ScrollConfiguration(behavior: OverScrollBehavior(), child: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0.0,
                floating: true,
                pinned: true,
                title: Text('${Get.arguments['albumName']}'),
              ),
              _buildTodayListView()
            ],
          ))
      ),
    );
  }

  Widget _buildTodayListView() {
    return Obx(()=>SliverFixedExtentList(
      itemExtent: 60.0,
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return controller.listSong.length>0?InkWell(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    height: 50.0,
                    alignment: Alignment.center,
                    constraints: BoxConstraints(maxWidth: 40, minHeight: 30.0),
                    child: Text(
                      '${index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16.0,color: Colors.grey[500]),
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 25,
                            alignment: Alignment.centerLeft,
                            child: Text(controller.listSong[index].title, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.centerLeft,
                            child: Text(controller.listSong[index].artist, maxLines: 1, overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 14.0,color: Colors.grey[500])),
                          )
                        ],
                      )),
                  IconButton(icon: Icon(Icons.more_vert,color: Colors.grey[500],),onPressed: (){},)
                ],
              ),
            ),
            onTap: () =>controller.playSong(index),
          ):LoadingView.buildGeneralLoadingView();
        },
        childCount: controller.listSong.length > 0
            ? controller.listSong.length
            : 20,
      ),
    ));
  }
}