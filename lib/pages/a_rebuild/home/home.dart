import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/adapters.dart';

import '../../../common/constants/enmu.dart';
import '../../../common/netease_api/src/api/login/bean.dart';
import '../../../common/netease_api/src/api/play/bean.dart';
import '../../../common/netease_api/src/netease_api.dart';

final newSongList = FutureProvider.autoDispose((ref) async {
  String loginDataStr = GetIt.instance<Box>().get(loginData);
  List<Play> playlist = [];
  print('object=============$loginDataStr');
  if (loginDataStr.isNotEmpty) {
    var userData = NeteaseAccountInfoWrap.fromJson(jsonDecode(loginDataStr));
    MultiPlayListWrap2 multiPlayListWrap2 = await NeteaseMusicApi().userPlayList(userData.profile?.userId ?? '-1');
    List<Play> list = (multiPlayListWrap2.playlist ?? []);
    if (list.isNotEmpty) {
      playlist..clear()..addAll(list);
    }
  }
  return playlist;
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
          IconButton(onPressed: (){}, icon: const Icon(Icons.settings))
        ],
      ),
      body: newSong.when(data: (data){
        return ListView.builder(
          padding: EdgeInsets.only(left: 30.w,right: 30.w,bottom: 100.w),
          itemBuilder: (context, index) => GestureDetector(
            child: Padding(padding: EdgeInsets.symmetric(vertical: 20.w),child: Row(
              children: [
                SimpleExtendedImage('${data[index].coverImgUrl}?param=200y200',cacheWidth: 200,width: 90.w,height: 90.w,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
                Expanded(child: Text(data[index].name??''),)
              ],
            ),),
            onTap: (){
              context.go('/playlist',extra: data[index]);
            },
          ),
          itemCount: data.length,
        );
      }, loading: () => const Center(child: CircularProgressIndicator(),), error: (error, stack) => Center(child: Text('Error: $error'),),),
    );
  }


  // audioServeHandler.changeQueueLists(mediaItem ?? [], index: index);
}