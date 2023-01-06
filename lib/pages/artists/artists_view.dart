import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/src/api/play/bean.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({Key? key}) : super(key: key);

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  Artists? artists;

  DioMetaData artistDetailDioMetaData(String artistId) {
    var params = {'id': artistId};
    return DioMetaData(joinUri('/api/artist/head/info/get'), data: params, options: joinOptions());
  }

  @override
  void initState() {
    super.initState();
    artists = (context.routeData.args as Artists);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(artists?.name ?? ''),
        ),
        body: RequestWidget<ArtistDetailWrap>(
            dioMetaData: artistDetailDioMetaData(artists?.id ?? '-1'),
            childBuilder: (artistDetails) => SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SimpleExtendedImage(
                            '${artistDetails.data?.artist?.cover ?? ''}?param=500y500',
                            borderRadius: BorderRadius.circular(110.w),
                            width: 220.w,
                            height: 220.w,
                          ),
                          Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
                          Expanded(
                              child: Container(
                                height: 220.w,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.7),
                                  borderRadius: BorderRadius.circular(15.w)
                                ),
                                child: Text(
                                  (artistDetails.data?.artist?.briefDesc ?? '').replaceAll('\n', ''),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 26.sp,height: 1.6),
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                )),
      ),
      onHorizontalDragDown: (e) {},
    );
  }
}
