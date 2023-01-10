import 'dart:convert';

import 'package:bujuan/widget/request_widget/request_loadmore_view.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/netease_api/src/api/dj/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/app_bar.dart';
import '../../widget/simple_extended_image.dart';

class MyRadioView extends StatefulWidget {
  const MyRadioView({Key? key}) : super(key: key);

  @override
  State<MyRadioView> createState() => _MyRadioViewState();
}

class _MyRadioViewState extends State<MyRadioView> {
  DioMetaData djRadioSubListDioMetaData({bool total = true, int offset = 0, int limit = 30}) {
    var params = {'total': total, 'limit': limit, 'offset': offset};
    return DioMetaData(joinUri('/weapi/djradio/get/subed'), data: params, options: joinOptions());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: MyAppBar(
          backgroundColor: Colors.transparent,
        ),
        body: RequestLoadMoreWidget<DjRadioListWrap, DjRadio>(
            listKey: const ['djRadios'],
            dioMetaData: djRadioSubListDioMetaData(),
            childBuilder: (List<DjRadio> list) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                itemBuilder: (context, index) => _buildItem(list[index]),
                itemCount: list.length,
              );
            }),
      ),
      onHorizontalDragDown: (e) {},
    );
  }

  Widget _buildItem(DjRadio data) {
    return InkWell(
        child: SizedBox(
          height: 120.w,
          child: Row(
            children: [
              SimpleExtendedImage(
                '${data.picUrl ?? ''}?param=200y200',
                width: 85.w,
                height: 85.w,
                borderRadius: BorderRadius.circular(10.w),
              ),
              Expanded(
                  child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data.name,
                      maxLines: 1,
                      style: TextStyle(fontSize: 28.sp),
                    ),
                    Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                    Text(
                      data.lastProgramName ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 26.sp, color: Colors.grey),
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
        onTap: () {});
    // return ListTile(
    //   dense: true,
    //   contentPadding: EdgeInsets.symmetric(horizontal: 10.w),
    //   leading: SimpleExtendedImage(
    //     '${data.extras?['image'] ?? ''}?param=200y200',
    //     width: 80.w,
    //     height: 80.w,
    //   ),
    //   title: Text(data.title),
    //   subtitle: Text(data.artist??''),
    //   onTap: () {
    //     controller.playIndex(index);
    //   },
    // );
  }
}
