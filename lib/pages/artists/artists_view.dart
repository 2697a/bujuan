import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:audio_service/audio_service.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/src/api/play/bean.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../common/constants/other.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../routes/router.gr.dart';
import '../../widget/app_bar.dart';

class ArtistsView extends StatefulWidget {
  const ArtistsView({Key? key}) : super(key: key);

  @override
  State<ArtistsView> createState() => _ArtistsViewState();
}

class _ArtistsViewState extends State<ArtistsView> {
  Artists? artists;
  List<MediaItem> _items = [];

  DioMetaData artistDetailAndSongListDioMetaData(String artistId) {
    return DioMetaData(joinUri('/weapi/v1/artist/$artistId'), data: {}, options: joinOptions());
  }

  @override
  void initState() {
    super.initState();
    artists = (context.routeData.args as Artists);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        child: RequestWidget<ArtistDetailAndSongListWrap>(
            dioMetaData: artistDetailAndSongListDioMetaData(artists?.id ?? '-1'),
            childBuilder: (artistDetails) {
              _items
                ..clear()
                ..addAll(HomeController.to.song2ToMedia(artistDetails.hotSongs ?? []));
              return Scaffold(
                backgroundColor: Colors.transparent,
                appBar: MyAppBar(
                  backgroundColor: Colors.transparent,
                  leading: IconButton(
                      padding: EdgeInsets.only(left: 20.w),
                      onPressed: () => AutoRouter.of(context).pop(),
                      icon: SimpleExtendedImage.avatar(
                        '${artistDetails.artist.img1v1Url ?? ''}?param=100y100',
                        width: 75.w,
                        height: 75.w,
                      )),
                  title: Text(artists?.name ?? ''),
                ),
                body: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.w),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: Container(
                                height: 220.w,
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.7), borderRadius: BorderRadius.circular(15.w)),
                                child: Text(
                                  (artistDetails.artist.briefDesc ?? '').replaceAll('\n', ''),
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 26.sp, height: 1.6),
                                ),
                              ))
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(vertical: 15.w),
                        child: Text(
                          '热门单曲',
                          style: TextStyle(fontSize: 36.sp,fontWeight: FontWeight.bold),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemExtent: 120.w,
                        itemBuilder: (context, index) => _buildItem(_items[index], index),
                        itemCount: _items.length,
                      )
                    ],
                  ),
                ),
              );
            }),
        onHorizontalDragDown: (e) {},
      ),
    );
  }

  Widget _buildItem(MediaItem data, int index) {
    return InkWell(
      child: SizedBox(
        height: 120.w,
        child: Row(
          children: [
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.title,
                  maxLines: 1,
                  style: TextStyle(fontSize: 30.sp),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                Text(
                  data.artist ?? '',
                  maxLines: 1,
                  style: TextStyle(fontSize: 24.sp, color: Colors.grey),
                )
              ],
            )),
            Visibility(
              visible: (data.extras!['mv'] ?? 0) != 0,
              child: IconButton(
                  onPressed: () {
                    // context.router.push(const MvView().copyWith(queryParams: {'mvId': data.extras?['mv'] ?? 0}));
                  },
                  icon: const Icon(
                    TablerIcons.brand_youtube,
                    color: Colors.grey,
                  )),
            ),
            IconButton(
                onPressed: () {
                  showModalActionSheet(
                    context: context,
                    title: data.title,
                    message: data.artist,
                    actions: [const SheetAction<String>(label: '下一首播放', icon: TablerIcons.player_play, key: 'next')],
                  ).then((value) {
                    if (value != null) {
                      if (HomeController.to.audioServeHandler.playbackState.value.queueIndex != 0) {
                        HomeController.to.audioServeHandler.insertQueueItem(HomeController.to.audioServeHandler.playbackState.value.queueIndex! + 1, data);
                        WidgetUtil.showToast('已添加到下一曲');
                      } else {
                        WidgetUtil.showToast('未知错误');
                      }
                    }
                  });
                },
                icon: const Icon(
                  TablerIcons.dots_vertical,
                  color: Colors.grey,
                ))
          ],
        ),
      ),
      onTap: () => HomeController.to.playByIndex(index, artists?.id ?? '-1', mediaItem: _items),
    );
  }
}
