import 'package:animated_background/animated_background.dart';
import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../../common/lyric_parser/parser_lrc.dart';
import '../../../common/netease_api/src/api/event/bean.dart';
import '../../../common/netease_api/src/api/play/bean.dart';
import '../../../common/netease_api/src/netease_api.dart';

class SongData {
  MediaItem mediaItem;
  PlaybackState? playState;
  bool panelOpen;

  SongData(this.mediaItem, this.playState, this.panelOpen);
}

class PanelWidgetSize {
  static double playBarHeight = 120.w;
  static double imageMinSize = 80.w;
  static double imageMaxSize = 380.w;
}

final mediaItemProvider = StreamProvider((ref) => ref.watch(audioHandler).mediaItem.stream);

final playStateProvider = StreamProvider((ref) => ref.watch(audioHandler).playbackState.stream);

final songDataProvider = StateProvider<SongData>((ref) {
  MediaItem? mediaItem = ref.watch(mediaItemProvider).value;
  PlaybackState? playState = ref.watch(playStateProvider).value;
  return SongData(mediaItem ?? const MediaItem(id: '-1', title: '', extras: {'image': ''}), playState, ref.watch(isOpen.notifier).state);
});

final paletteGenerator = FutureProvider.family<PaletteGenerator, String>((ref, url) => OtherUtils.getImageColor(url));

final paletteProvider = StateProvider<PaletteGenerator?>((ref) {
  MediaItem? mediaItem = ref.watch(mediaItemProvider).value;
  return ref.watch(paletteGenerator('${mediaItem?.extras!['image']}?param=120y120')).value;
});

final lyricProvider = FutureProvider((ref) async {
  MediaItem? mediaItem = ref.watch(mediaItemProvider).value;
  SongLyricWrap songLyricWrap = await NeteaseMusicApi().songLyric(mediaItem?.id ?? '');
  String lyric = songLyricWrap.lrc.lyric ?? '';
  return ParserLrc(lyric).parseLines();
});

final isOpen = StateProvider((ref) => ref.read(panelController).isPanelOpen);

final hotTalkProvider = FutureProvider((ref) async {
  CommentItem commentItem = CommentItem();
  MediaItem? mediaItem = ref.watch(mediaItemProvider).value;
  CommentList2Wrap commentListWrap = await NeteaseMusicApi().commentList2(mediaItem?.id ?? '', 'song', pageSize: 1, sortType: 2);
  if (commentListWrap.code == 200) {
    var list = commentListWrap.data.comments ?? [];
    if (list.isNotEmpty) {
      commentItem = list[0];
    }
  }
  return commentItem;
});

final talk = StateProvider((ref) => ref.watch(hotTalkProvider).value);

class Panel extends StatefulWidget {
  const Panel({super.key});

  @override
  State<Panel> createState() => _PanelState();
}

class _PanelState extends State<Panel> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    animationController = AnimationController(vsync: this, value: 0);
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [PlayBar(this, animationController: animationController)],
      ),
    );
  }
}

class PlayBar extends ConsumerWidget {
  final AnimationController animationController;
  final TickerProvider tickerProvider;

  const PlayBar(this.tickerProvider, {super.key, required this.animationController});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    animationController.value = ref.watch(slideProvider.notifier).state;
    PaletteGenerator paletteGenerator = ref.watch(paletteProvider.notifier).state ?? PaletteGenerator.fromColors([]);
    SongData songData = ref.watch(songDataProvider.notifier).state;
    return GestureDetector(
      child: buildContent(context, paletteGenerator, songData),
      onHorizontalDragEnd: (e) {},
      onTap: () {
        if (!ref.read(panelController).isPanelOpen) {
          ref.read(panelController).open();
        }
      },
    );
  }

  Widget buildContent(BuildContext context, PaletteGenerator p, SongData songData) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            gradient: LinearGradient(colors: [
              p.darkMutedColor?.color ?? p.darkVibrantColor?.color ?? Theme.of(context).scaffoldBackgroundColor,
              p.dominantColor?.color ?? p.darkMutedColor?.color ?? Theme.of(context).scaffoldBackgroundColor,
            ], begin: Alignment.topRight, end: Alignment.bottomLeft)),
        height: PanelWidgetSize.playBarHeight + (MediaQuery.of(context).size.height - PanelWidgetSize.playBarHeight) * animationController.value,
        margin: EdgeInsets.symmetric(horizontal: 15.w * (1 - animationController.value)),
        child: child,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        height: MediaQuery.of(context).size.height,
        child: AnimatedBackground(
          vsync: tickerProvider,
          behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                  baseColor: p.lightMutedColor?.color ?? p.darkMutedColor?.color ?? Colors.grey,
                  spawnMaxSpeed: 100,
                  spawnMinSpeed: 50,
                  spawnOpacity: .2,
                  particleCount: songData.panelOpen ? 16 : 0,
                  spawnMaxRadius: 10.w)),
          child: _buildWidget(context, p, songData),
        ),
      ),
    );
  }

  Widget _buildWidget(BuildContext context, PaletteGenerator p, SongData songData) {
    return Column(
      children: [
        AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget? child) => AnimatedOpacity(
                  opacity: animationController.value,
                  duration: Duration.zero,
                  child: SizedBox(
                    height: 20.w + (MediaQuery.of(context).size.height * .45 - 20.w) * animationController.value,
                    child: child,
                  ),
                ),
            child: Container(
              alignment: Alignment.topCenter,
              height: MediaQuery.of(context).size.height * .45,
              child: _buildTopWidget(p, songData),
            )),
        AnimatedBuilder(
          animation: animationController,
          builder: (BuildContext context, Widget? child) => SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 100.w + (MediaQuery.of(context).size.height * .55 - 100.w) * animationController.value,
            child: child,
          ),
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              AnimatedBuilder(
                animation: animationController,
                builder: (BuildContext context, Widget? child) => AnimatedPositioned(
                    duration: const Duration(milliseconds: 0),
                    left: 10.w * animationController.value,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 40),
                      width: PanelWidgetSize.imageMinSize + ((PanelWidgetSize.imageMaxSize - PanelWidgetSize.imageMinSize) * animationController.value),
                      height: PanelWidgetSize.imageMinSize + ((PanelWidgetSize.imageMaxSize - PanelWidgetSize.imageMinSize) * animationController.value),
                      child: child,
                    )),
                child: SimpleExtendedImage(
                  '${songData.mediaItem.extras!['image'] ?? ''}?param=480y480',
                  width: PanelWidgetSize.imageMaxSize,
                  height: PanelWidgetSize.imageMaxSize,
                  borderRadius: BorderRadius.circular(8.w),
                ),
              ),
              Positioned(
                height: 80.w,
                left: 10.w + 90.w * (1 - animationController.value),
                top: 400.w * animationController.value,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 80.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: Text(
                          songData.mediaItem.title,
                          style: TextStyle(
                            color: p.darkMutedColor?.bodyTextColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 28.sp + animationController.value * 8,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )),
                        AnimatedOpacity(
                          opacity: animationController.value,
                          duration: Duration.zero,
                          child: Row(
                            children: [
                              Icon(
                                Icons.more_vert,
                                size: 42.w,
                                color: p.darkMutedColor?.bodyTextColor,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) => AnimatedContainer(
                    duration: const Duration(milliseconds: 30),
                    alignment: Alignment.center,
                    height: 80.w + (380.w - 80.w) * animationController.value,
                    width: 80.w + (380.w - 80.w) * animationController.value,
                    margin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width - 180.w) * (1 - animationController.value),
                    ),
                    child: Consumer(
                      builder: (BuildContext context, WidgetRef ref, Widget? child) => GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(color: p.dominantColor?.color.withOpacity(animationController.value * .8), borderRadius: BorderRadius.circular(40.w)),
                          child: Icon(
                            songData.playState?.playing ?? false ? Icons.pause : Icons.play_arrow,
                            color: p.darkMutedColor?.bodyTextColor,
                            size: 48.w + animationController.value * 30.w,
                          ),
                        ),
                        onTap: () {
                          if (songData.playState?.playing ?? false) {
                            ref.read(audioHandler).pause();
                          } else {
                            ref.read(audioHandler).play();
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) => AnimatedPositioned(
                      duration: const Duration(milliseconds: 80),
                      top: 480.w,
                      left: 10.w,
                      child: AnimatedOpacity(
                        opacity: animationController.value,
                        duration: const Duration(milliseconds: 200),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 80.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                songData.mediaItem.artist ?? 'Post malne',
                                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500, color: p.darkMutedColor?.bodyTextColor),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Consumer(
                                          builder: (BuildContext context, WidgetRef ref, Widget? child) => GestureDetector(
                                            child: Icon(
                                              Icons.skip_previous,
                                              color: p.darkMutedColor?.bodyTextColor,
                                              size: 66.w,
                                            ),
                                            onTap: () {
                                              ref.read(audioHandler).skipToPrevious();
                                              // ref.read(panelController).close();
                                            },
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.symmetric(horizontal: 50.w)),
                                        Consumer(
                                          builder: (BuildContext context, WidgetRef ref, Widget? child) => GestureDetector(
                                            child: Icon(
                                              Icons.skip_next,
                                              color: p.darkMutedColor?.bodyTextColor,
                                              size: 66.w,
                                            ),
                                            onTap: () {
                                              ref.read(audioHandler).skipToNext();
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      child: Icon(
                                        Icons.favorite,
                                        size: 42.w,
                                        color: p.darkMutedColor?.bodyTextColor,
                                      ),
                                      onTap: () {
                                        print('喜欢歌曲');
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopWidget(PaletteGenerator p, SongData songData) {
    return const SafeArea(
        bottom: false,
        child: Stack(
          children: [
            // Padding(
            //   padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.w),
            //   child: Row(
            //     children: [
            //       SimpleExtendedImage(
            //         '',
            //         width: 80.w,
            //         height: 80.w,
            //         borderRadius: BorderRadius.circular(50.w),
            //       ),
            //       Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
            //       Expanded(
            //           child: Text(
            //         songData.mediaItem.artist ?? '',
            //         style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500, color: p.darkMutedColor?.bodyTextColor),
            //       )),
            //       Consumer(
            //         builder: (BuildContext context, WidgetRef ref, Widget? child) {
            //           return GestureDetector(
            //               onTap: () {
            //                 print('关注歌手');
            //               },
            //               child: Icon(Icons.add_circle, color: p.darkMutedColor?.bodyTextColor));
            //         },
            //       )
            //     ],
            //   ),
            // ),

            // Padding(padding: EdgeInsets.only(top: 120.w,bottom: 30.w),child: Consumer(
            //   builder: (BuildContext context, WidgetRef ref, Widget? child) => ref.watch(lyricProvider).when(
            //       data: (List<LyricsLineModel> data) => Container(
            //         width: MediaQuery.of(context).size.width,
            //         decoration: BoxDecoration(
            //           color: p.dominantColor?.color.withOpacity(.6),
            //           borderRadius: BorderRadius.circular(20.w)
            //         ),
            //         padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.w),
            //         child: ClickableListWheelScrollView(
            //           itemHeight:120.w,
            //           itemCount: data.length,
            //           onItemTapCallback: (index) {
            //             //点击歌词
            //           },
            //           scrollController: ScrollController(),
            //           child: ListWheelScrollView.useDelegate(
            //             itemExtent:  120.w,
            //             perspective: 0.0006,
            //             onSelectedItemChanged: (index) {
            //               //TODO 此处可以获取实时歌词
            //             },
            //             childDelegate: ListWheelChildBuilderDelegate(
            //               builder: (context, index) => Container(
            //                 width: MediaQuery.of(context).size.width,
            //                 height:  120.w,
            //                 alignment: Alignment.center,
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.center,
            //                   children: [
            //                     Text(
            //                       data[index].mainText ?? '',
            //                       style: TextStyle(fontSize: 36.sp, color: p.dominantColor?.bodyTextColor),
            //                       textAlign: TextAlign.center,
            //                       maxLines: 2,
            //                       overflow: TextOverflow.ellipsis,
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //               childCount: data.length,
            //             ),
            //           ),
            //         ),
            //       ),
            //       error: (Object error, StackTrace stackTrace) => Container(),
            //       loading: () => Container()),
            // ),)
          ],
        ));
  }
}
