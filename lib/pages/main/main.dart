import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/player/bujuan_player.dart';
import 'package:bujuan/common/request_state.dart';
import 'package:bujuan/pages/main/provider.dart';
import 'package:bujuan/widgets/album.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class MainPage extends StatefulWidget {
  final Widget body;

  const MainPage({super.key, required this.body});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      borderRadius: 24.0,
      showShadow: true,
      angle: 0,
      mainScreenScale: .01,
      drawerShadowsBackgroundColor: Colors.grey.withOpacity(.3),
      isRtl: true,
      slideWidth: MediaQuery.of(context).size.width - 380.w,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      menuScreen: Container(),
      mainScreen: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [const Color(0xFF6C63FF).withOpacity(.3), Colors.white.withOpacity(.4)])),
          child: Row(
            children: [
              Expanded(child: widget.body),
              PlayView(),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayView extends StatefulWidget {
  const PlayView({super.key});

  @override
  State<PlayView> createState() => _PlayViewState();
}

class _PlayViewState extends State<PlayView> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.w),
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.r)),
      child: SizedBox(
        width: 380.w,
        height: MediaQuery.of(context).size.height,
        child: Consumer(builder: (_, __, ___) {
          return BaseRequestWidget(
              requestState: __.watch(mainProvider),
              childBuilder: (data) => Column(
                    children: [
                      Expanded(child: Consumer(builder: (context, ref, child) {
                        var mainState = ref.watch(playlistProvider.notifier).state;
                        print('歌曲列表发生变化======================${ref.watch(playlistProvider)}');
                        return ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            title: Text((mainState)[index].title),
                            onTap: () {
                              BujuanPlayer().playIndex(index);
                            },
                          ),
                          itemCount: (mainState).length,
                        );
                      })),
                      // Consumer(builder: (context, ref, child) {
                      //   print('播放歌曲发生变化======================');
                      //   var mainState = ref.watch(mainProvider);
                      //   return ListTile(
                      //     title: Text(mainState.data?.mediaItem?.title ?? ''),
                      //     subtitle: Text('${mainState.data?.mediaItem?.duration}'),
                      //   );
                      // }),
                      Consumer(builder: (context, ref, child) {
                        print('播放进度发生变化======================');
                        var mainState = ref.watch(positionProvider.notifier).state;
                        return ListTile(
                          title: Text('进度:$mainState'),
                        );
                      }),
                    ],
                  ));
        }),
      ),
    );
  }
}
