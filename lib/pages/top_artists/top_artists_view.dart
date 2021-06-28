import 'package:bujuan/entity/top_artists_entity.dart';
import 'package:bujuan/pages/play_widget/play_widget_view.dart';
import 'package:bujuan/pages/top_artists/top_artists_controller.dart';
import 'package:bujuan/widget/over_scroll.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopArtists extends GetView<TopArtistsController> {
  @override
  Widget build(BuildContext context) {
    return PlayWidgetView(
      ScrollConfiguration(
        behavior: OverScrollBehavior(),
        child: Obx(() => SmartRefresher(
            controller: controller.refreshController,
            header: WaterDropMaterialHeader(
              color: Theme.of(context).accentColor,
              backgroundColor: Theme.of(context).primaryColor,
            ),
            onRefresh: () => controller.getData(true),
            onLoading: () => controller.getData(false),
            child: ListView.builder(
              itemBuilder: (_, index) =>
                  _buildItem(controller.artists[index]),
              itemCount: controller.artists.length,
            ))),
      ),
      appBar: AppBar(
        title: Text(''),
      ),
    );
  }

  Widget _buildItem(TopArtistsArtists topArtistsArtists) {
    return InkWell(
      child: Card(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10.0),
                    child: Card(
                      child: CachedNetworkImage(
                        height: 100.0,
                        width: 100.0,
                        fit: BoxFit.cover,
                        imageUrl: '${topArtistsArtists.picUrl}?param=300y300',
                      ),
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text('${topArtistsArtists.name}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                          Container(
                            height: 30,
                            alignment: Alignment.centerLeft,
                            child: Text('${topArtistsArtists.briefDesc}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[500])),
                          ),
                        ],
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
      onTap: () {

      },
    );
  }
}
