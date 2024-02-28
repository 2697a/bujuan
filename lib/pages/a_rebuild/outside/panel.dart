import 'package:animated_background/animated_background.dart';
import 'package:audio_service/audio_service.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

final paletteGenerator = FutureProvider.family<PaletteGenerator,String>((ref,url) async {
  return OtherUtils.getImageColor(url);
});

final isOpen = StateProvider((ref) => ref.read(panelController).isPanelOpen);

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
      onHorizontalDragEnd: (e) {},
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
    bool panelOpen = ref.watch(isOpen.notifier).state;
    return ref.watch(provider).when(data: (data1) {
      final boredSuggestion = ref.watch(paletteGenerator('${data1?.extras!['image']??''}?param=200y200'));
      return  boredSuggestion.when(
          data: (data) => GestureDetector(
            child: buildContent(context, data, panelOpen,data1),
            onTap: () {
              if (!ref.read(panelController).isPanelOpen) {
                ref.read(panelController).open();
              }
            },
          ),
          error: (Object error, StackTrace stackTrace) => Container(),
          loading: () => Container());
    }, error: (Object error, StackTrace stackTrace) => Container(), loading: () => Container());
  }

  Widget buildContent(BuildContext context, PaletteGenerator p, bool panelOpen,MediaItem? mediaItem) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            gradient: LinearGradient(
              colors: [p.dominantColor?.color ?? p.darkMutedColor?.color??Colors.red,p.darkMutedColor?.color ?? p.darkVibrantColor?.color??Theme.of(context).scaffoldBackgroundColor,],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            )),
        height: 120.w + (MediaQuery.of(context).size.height - 120.w) * animationController.value,
        margin: EdgeInsets.symmetric(horizontal: 20.w * (1 - animationController.value)),
        child: child,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w),
        height: MediaQuery.of(context).size.height,
        child: AnimatedBackground(
          vsync: tickerProvider,
          behaviour: RandomParticleBehaviour(
              options: ParticleOptions(
                  baseColor: p.dominantColor?.titleTextColor ?? p.darkMutedColor?.bodyTextColor??Colors.grey, spawnMaxSpeed: 100, spawnMinSpeed: 50, particleCount: panelOpen ? 28 : 0, spawnMaxRadius: 10.w)),
          child: _buildWidget(context, p, panelOpen,mediaItem),
        ),
      ),
    );
  }

  Widget _buildWidget(BuildContext context, PaletteGenerator p, bool panelOpen,MediaItem? mediaItem) {
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
              height: MediaQuery.of(context).size.height / 2,
              child: _buildTopWidget(p,mediaItem),
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
                    left: 30.w * animationController.value,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 60),
                      width: 80.w + (300.w * animationController.value),
                      height: 80.w + (300.w * animationController.value),
                      child: child,
                    )),
                child: SimpleExtendedImage(
                  mediaItem?.extras!['image']??'http://p1.music.126.net/zfLVBIW8YNCWC1RR2IiRkg==/109951169035455026.jpg?param=580y580',
                  width: 380.w,
                  height: 380.w,
                  borderRadius: BorderRadius.circular(15.w)
                ),
              ),
              Positioned(
                height: 80.w,
                left: 30.w + 70.w * (1 - animationController.value),
                top: 400.w * animationController.value,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 120.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mediaItem?.title??'Enough is Enough',
                          style: TextStyle(color: p.darkMutedColor?.bodyTextColor, fontWeight: FontWeight.w500, fontSize: 28.sp + animationController.value * 8),
                        ),
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
                padding: EdgeInsets.only(left: 30.w),
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) => AnimatedContainer(
                    duration: const Duration(milliseconds: 60),
                    alignment: Alignment.center,
                    height: 80.w + (380.w - 80.w) * animationController.value,
                    width: 80.w + (380.w - 80.w) * animationController.value,
                    margin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width - 180.w) * (1 - animationController.value),
                    ),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(color: p.darkMutedColor?.color.withOpacity(animationController.value * .8), borderRadius: BorderRadius.circular(40.w)),
                        child: Icon(
                          Icons.play_arrow,
                          color: p.darkMutedColor?.bodyTextColor,
                          size: 48.w + animationController.value * 30.w,
                        ),
                      ),
                      onTap: (){
                        print('播放歌曲');
                      },
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) => AnimatedPositioned(
                      duration: const Duration(milliseconds: 80),
                      top: 480.w,
                      left: 30.w,
                      child: AnimatedOpacity(
                        opacity: animationController.value,
                        duration: const Duration(milliseconds: 200),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width- 120.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mediaItem?.artist??'Post malne',
                                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500, color: p.darkMutedColor?.bodyTextColor),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) => GestureDetector(
                                          child: Icon(
                                            Icons.skip_previous,
                                            color: p.darkMutedColor?.bodyTextColor,
                                            size: 66.w,
                                          ),
                                          onTap: () {
                                            ref.read(audioHandler).skipToPrevious();
                                          },
                                        ),),
                                        Padding(padding: EdgeInsets.symmetric(horizontal: 50.w)),
                                        Consumer(builder: (BuildContext context, WidgetRef ref, Widget? child) =>GestureDetector(
                                          child: Icon(
                                            Icons.skip_next,
                                            color: p.darkMutedColor?.bodyTextColor,
                                            size: 66.w,
                                          ),
                                          onTap: () {
                                            ref.read(audioHandler).skipToNext();
                                          },
                                        ),),
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
                             // Row(
                             //   children: [
                             //     SliderTheme(
                             //       data: const SliderThemeData(
                             //         trackHeight: 2,
                             //         thumbShape:
                             //         RoundSliderThumbShape(enabledThumbRadius: 7,pressedElevation: 0),
                             //       ),
                             //       child: Expanded(
                             //         child: Slider(
                             //           min: 0,
                             //           max: 100,
                             //           thumbColor: Colors.white,
                             //           activeColor: p.darkMutedColor?.bodyTextColor,
                             //           inactiveColor: p.lightMutedColor?.bodyTextColor,
                             //           value: 30,
                             //           onChanged: (onChanged) {
                             //
                             //           },
                             //         ),
                             //       ),
                             //     ),
                             //   ],
                             // )
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

  Widget _buildTopWidget(PaletteGenerator p,MediaItem? mediaItem) {
    return SafeArea(
        child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.w),
          child: Row(
            children: [
              SimpleExtendedImage(
                mediaItem?.extras!['artistAvatar'].toString().split(' / ')[0]??'http://p1.music.126.net/zfLVBIW8YNCWC1RR2IiRkg==/109951169035455026.jpg?param=580y580',
                width: 80.w,
                height: 80.w,
                borderRadius: BorderRadius.circular(50.w),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
              Expanded(
                  child: Text(
                mediaItem?.artist??'Post malne',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500, color: p.darkMutedColor?.bodyTextColor),
              )),
              GestureDetector(onTap: (){
                print('关注歌手');
              }, child: Icon(Icons.add_circle, color: p.darkMutedColor?.bodyTextColor))
            ],
          ),
        )
      ],
    ));
  }
}
