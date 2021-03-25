import 'package:flutter/material.dart';
import 'package:flutter_placeholder_textlines/placeholder_lines.dart';
import 'package:get/get.dart';

class LoadingView {
  ///普通列表加载试图
  static Widget buildGeneralLoadingView() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 15.0),
      width: 100,
      child: PlaceholderLines(
        lineHeight: 10.0,
        count: 2,
        maxWidth: 0.9,
        minWidth: 0.6,
        align: TextAlign.left,
        color: Colors.grey[400],
      ),
    );
  }

  ///评论加载中的view
  static Widget buildLoadingTalkView() {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(right: 12.0),
                width: 30,
                height: 30,
                decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(30.0)),
                child: Center(
                  child: Icon(
                    Icons.photo_size_select_actual,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              Expanded(
                  child: PlaceholderLines(
                lineHeight: 10.0,
                maxWidth: .5,
                minWidth: .3,
                color: Colors.grey[400],
                animate: true,
                count: 1,
              )),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 40.0, bottom: 5.0, top: 5.0),
          child: PlaceholderLines(
            lineHeight: 10.0,
            color: Colors.grey[400],
            animate: true,
            count: 3,
          ),
        )
      ],
    );
  }

  ///gridView形式的歌单加载中的View
  static Widget buildGridViewSheetLoadingView() {
    return Container(
      width: (MediaQuery.of(Get.context).size.width - 10) / 3,
      alignment: Alignment.center,
      child: Card(
        child: Container(
          width: 120,
          height: 170.0,
          child: Column(
            children: [
              Container(
                color: Colors.grey[300],
                width: 120.0,
                height: 120.0,
                child: Center(
                  child: Icon(
                    Icons.photo_size_select_actual,
                    color: Colors.white,
                    size: 42,
                  ),
                ),
              ),
              Container(
                height: 45,
                alignment: Alignment.centerLeft,
                constraints: BoxConstraints(maxWidth: 110.0),
                child: PlaceholderLines(
                  lineHeight: 10.0,
                  color: Colors.grey[400],
                  animate: true,
                  count: 2,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///普通列表加载试图
  static Widget buildNewSongLoadingView() {
    return Container(
      height: 110.0,
      padding: EdgeInsets.symmetric(horizontal: 2.0, vertical: 5.0),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 6.0),
            decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(12.0)),
            height: 100.0,
            width: 110.0,
            child: Center(
              child: Icon(
                Icons.photo_size_select_actual,
                color: Colors.white,
                size: 42,
              ),
            ),
          ),
          Expanded(
              child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: PlaceholderLines(
              lineHeight: 10.0,
              color: Colors.grey[400],
              animate: true,
              count: 3,
            ),
          )),
        ],
      ),
    );
  }
}
