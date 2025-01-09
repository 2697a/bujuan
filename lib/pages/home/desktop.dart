import 'package:bujuan/common/request_state.dart';
import 'package:bujuan/pages/home/provider.dart';
import 'package:bujuan/widgets/image.dart';
import 'package:bujuan_music_api/api/song/entity/new_song_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeDesktop extends ConsumerStatefulWidget {
  const HomeDesktop({super.key});

  @override
  ConsumerState<HomeDesktop> createState() => _HomeDesktopState();
}

class _HomeDesktopState extends ConsumerState<HomeDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: BaseRequestWidget<HomeData>(
          requestState: ref.watch(homeProvider),
          childBuilder: (HomeData data) => SingleChildScrollView(
                child: Column(
                  children: [
                    _buildTopArtist(data.newSongEntity!.data!),
                  ],
                ),
              )),
    );
  }

  Widget _buildTopArtist(List<NewSongData> songs) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1,
        crossAxisSpacing: 10.w,
      ),
      itemBuilder: (context, index) => GestureDetector(
        child: Column(
          children: [
            ImageView(url: songs[index].album?.picUrl ?? '',width: 100.w,height: 100.w,),
            Text(songs[index].name??'')
          ],
        ),
        onTap: (){
          ref.read(homeProvider.notifier).getSongUrl("${songs[index].id}");
        },
      ),
      itemCount: songs.length > 10 ? 10 : songs.length,
    );
  }
}
