import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../common/constants/enmu.dart';
import '../../../common/netease_api/src/api/play/bean.dart';
import '../../../common/netease_api/src/netease_api.dart';

final newSongList = FutureProvider.autoDispose((ref) async {
  SongListWrap2 personalizedSongListWrap = await NeteaseMusicApi().newSongList();
  var data = personalizedSongListWrap.data??[];
  return data.map((e) => MediaItem(
      id: e.id,
      duration: Duration(milliseconds: e.duration ?? 0),
      artUri: Uri.parse('${e.album?.picUrl ?? ''}?param=500y500'),
      extras: {
        'type': MediaType.playlist.name,
        'image': e.album?.picUrl ?? '',
        'artistId': (e.artists ?? []).map((e) => e.id).toList().join(' / '),
        'artistAvatar':(e.artists ?? []).map((e) => e.img1v1Url).toList().join(' / '),
        'mv': e.mvid,
        'fee': e.fee
      },
      title: e.name ?? "",
      album: e.album?.name,
      artist: (e.artists ?? []).map((e) => e.name).toList().join(' / '))).toList();
});

class HomePage extends ConsumerWidget{
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newSong = ref.watch(newSongList);
    return  Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: IconButton(onPressed: (){}, icon: SimpleExtendedImage('http://p1.music.126.net/bfipOCObq0KmuW4m0o31mQ==/109951168928616871.jpg?param=180y180',borderRadius: BorderRadius.circular(90.w),width: 75.w,height: 75.w,)),
        title: const Text('晚上好',style: TextStyle(fontWeight: FontWeight.w600),),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.settings))
        ],
      ),
      body: newSong.when(data: (data){
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
      }, loading: () => const Center(child: CircularProgressIndicator(),), error: (error, stack) => Center(child: Text('Error: $error'),),),
    );
  }


  // audioServeHandler.changeQueueLists(mediaItem ?? [], index: index);
}