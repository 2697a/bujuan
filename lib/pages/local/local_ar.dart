import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/local/local_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../routes/router.gr.dart';
import '../../widget/app_bar.dart';
import '../../widget/my_get_view.dart';
import '../../widget/simple_extended_image.dart';

class LocalAr extends StatelessWidget {
  final List<ArtistModel> artists;

  const LocalAr({Key? key, required this.artists}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyGetView(child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: MyAppBar(backgroundColor: Colors.transparent, title: const Text('歌手'),),
      body: _buildArtists(),
    ),);
  }


  Widget _buildArtists() {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 10.w,
      ),
      itemBuilder: (context, index) => _buildItem(artists[index], context, index),
      itemCount: artists.length,
    );
  }

  Widget _buildItem(ArtistModel play, BuildContext context, index) {
    return InkWell(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 14.w),
        height: (750.w - 120.w) / 3,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            SimpleExtendedImage(
              '${Local.to.directory?.path}/artists/${play.id}.jpeg',
              width: (750.w - 120.w) / 3,
              borderRadius: BorderRadius.circular(25.w),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.8),
                  borderRadius: BorderRadius.circular(25.w)
              ),
              height: 60.w,
              width: (750.w - 120.w) / 3,
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    play.artist ?? '',
                    maxLines: 1,
                    style: TextStyle(fontSize: 26.sp),
                  ),
                  // Padding(padding: EdgeInsets.symmetric(vertical: 2.w)),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        context.router.push(const LocalSongView().copyWith(queryParams: {'id': play.id, 'type': 'artist'}));
      },
    );
  }
}
