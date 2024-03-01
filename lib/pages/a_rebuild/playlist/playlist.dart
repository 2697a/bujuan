import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/netease_api/src/api/play/bean.dart';
import '../../../common/netease_api/src/netease_api.dart';
import '../../../widget/simple_extended_image.dart';

final playList = FutureProvider.family.autoDispose<List<MediaItem>, String>((ref, id) async {
  SinglePlayListWrap? details = await NeteaseMusicApi().playListDetail(id);
  List<String> ids = details.playlist?.trackIds?.map((e) => e.id).toList() ?? [];
  SongDetailWrap songDetailWrap = await NeteaseMusicApi().songDetail(ids);
  return OtherUtils.song2ToMedia(songDetailWrap.songs ?? []);
});

class PlayList extends ConsumerWidget {
  final Play play;
  const PlayList(this.play, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: ref.watch(playList(play.id)).when(
        data: (data) {
          return ListView.builder(
            padding: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 100.w),
            itemBuilder: (context, index) => GestureDetector(
              child: Padding(padding: EdgeInsets.symmetric(vertical: 20.w),child: Row(
                children: [
                  SimpleExtendedImage('${data[index].extras!['image']??''}?param=200y200',cacheWidth: 200,width: 90.w,height: 90.w,),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
                  Expanded(child: Text(data[index].title??''),)
                ],
              ),),
              onTap: (){
                ref.read(audioHandler).changeQueueLists(data,index: index);
              },
            ),
            itemCount: data.length,
          );
        },
        error: (Object error, StackTrace stackTrace) {},
        loading: () => Container(),
      ),
    );
  }
}
