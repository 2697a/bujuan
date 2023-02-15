import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/local/local_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../routes/router.gr.dart';
import '../../widget/app_bar.dart';
import '../../widget/my_get_view.dart';
import '../../widget/simple_extended_image.dart';

class LocalAlbum extends StatelessWidget {
  final List<AlbumModel> albums;

  const LocalAlbum({Key? key, required this.albums}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyGetView(child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar(
        backgroundColor: Colors.transparent,
        title: const Text('专辑'),
      ),
      body: _buildAlbum(),
    ),);
  }

  Widget _buildAlbum() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        crossAxisSpacing: 20.w,
      ),
      itemBuilder: (context, index) => _buildItem1(albums[index], context, index),
      itemCount: albums.length,
    );
  }

  Widget _buildItem1(AlbumModel play, BuildContext context, int index) {
    return InkWell(
      child: SizedBox(
        height: 120.w,
        child: Row(
          children: [
            SimpleExtendedImage(
              '${Local.to.directory?.path}/albums/${play.id}.jpeg',
              width: 85.w,
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
                    play.album,
                    maxLines: 1,
                    style: TextStyle(fontSize: 28.sp),
                  ),
                  Padding(padding: EdgeInsets.symmetric(vertical: 3.w)),
                  Text(
                    '${play.artist}',
                    maxLines: 1,
                    style: TextStyle(fontSize: 26.sp, color: Colors.grey),
                  )
                ],
              ),
            )),
            Text(
              '${play.numOfSongs}首',
              style: TextStyle(fontSize: 22.sp, color: Colors.grey),
            )
          ],
        ),
      ),
      onTap: () {
        context.router.push(const LocalSongView().copyWith(queryParams: {'id': play.id, 'type': 'album'}));
      },
    );
  }
}
