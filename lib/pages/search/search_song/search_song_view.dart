import 'package:bujuan/pages/search/search_song/search_song_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchSongView extends GetView<SearchSongController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
        padding: EdgeInsets.all(0),
      itemExtent: 60.0,
        itemBuilder: (context, index) {
          return InkWell(
            child: Padding(
              padding:
              EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 5.0),
                    height: 50.0,
                    alignment: Alignment.center,
                    constraints:
                    BoxConstraints(maxWidth: 40, minHeight: 30.0),
                    child: Text(
                      '${index + 1}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 16.0, color: Colors.grey[500]),
                    ),
                  ),
                  Expanded(
                      child: Column(
                        children: [
                          Container(
                            height: 25,
                            alignment: Alignment.centerLeft,
                            child: Text(
                                controller.search[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(fontSize: 16.0)),
                          ),
                          Container(
                            height: 25,
                            alignment: Alignment.centerLeft,
                            child: Text(
                                controller
                                    .search[index].ar[0].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 14.0, color: Colors.grey[500])),
                          )
                        ],
                      )),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.grey[500],
                    ),
                    onPressed: () =>controller.playSong(index),
                  )
                ],
              ),
            ),
            onTap: () => controller.playSong(index),
          );
        }, itemCount: controller.search.length));
  }
}
