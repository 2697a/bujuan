import 'package:animated_background/animated_background.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/a_rebuild/outside/outside.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:palette_generator/palette_generator.dart';

final paletteGenerator = FutureProvider<PaletteGenerator>((ref) async {
  return OtherUtils.getImageColor('http://p1.music.126.net/zfLVBIW8YNCWC1RR2IiRkg==/109951169035455026.jpg?param=580y580');
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
    final boredSuggestion = ref.watch(paletteGenerator);
    bool panelOpen = ref.watch(isOpen.notifier).state;
    return boredSuggestion.when(
        data: (data) => GestureDetector(
              child: buildContent(context, data, panelOpen),
              onTap: () {
                if (!ref.read(panelController).isPanelOpen) {
                  ref.read(panelController).open();
                }
              },
            ),
        error: (Object error, StackTrace stackTrace) => Container(),
        loading: () => Container());
  }

  Widget buildContent(BuildContext context, PaletteGenerator p, bool panelOpen) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget? child) => Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.w),
            gradient: LinearGradient(
              colors: [p.lightMutedColor?.color ?? Colors.transparent, p.darkMutedColor?.color ?? Colors.transparent],
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
                  baseColor: p.darkMutedColor?.color ?? Colors.black, spawnMaxSpeed: 100, spawnMinSpeed: 50, particleCount: panelOpen ? 20 : 0, spawnMaxRadius: 10.w)),
          child: _buildWidget(context, p, panelOpen),
        ),
      ),
    );
  }

  Widget _buildWidget(BuildContext context, PaletteGenerator p, bool panelOpen) {
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
              child: _buildTopWidget(p),
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
                    duration: const Duration(milliseconds: 80),
                    left: 30.w * animationController.value,
                    child: SizedBox(
                      width: 80.w + (300.w * animationController.value),
                      height: 80.w + (300.w * animationController.value),
                      child: child,
                    )),
                child: SimpleExtendedImage(
                  'http://p1.music.126.net/zfLVBIW8YNCWC1RR2IiRkg==/109951169035455026.jpg?param=580y580',
                  width: 380.w,
                  height: 380.w,
                ),
              ),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 60),
                height: 80.w,
                left: 30.w + 70.w * (1 - animationController.value),
                top: 400.w * animationController.value,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width - 90.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Enough is Enough',
                          style: TextStyle(color: p.darkMutedColor?.titleTextColor, fontWeight: FontWeight.w500, fontSize: 28.sp + animationController.value * 8),
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
                    child: Container(
                      decoration: BoxDecoration(color: p.darkMutedColor?.color.withOpacity(animationController.value * .8), borderRadius: BorderRadius.circular(40.w)),
                      child: Icon(
                        Icons.play_arrow,
                        color: p.darkMutedColor?.bodyTextColor,
                        size: 48.w + animationController.value * 30.w,
                      ),
                    ),
                  ),
                ),
              ),
              AnimatedBuilder(
                  animation: animationController,
                  builder: (BuildContext context, Widget? child) => AnimatedPositioned(
                      duration: const Duration(milliseconds: 50),
                      top: 480.w,
                      left: 30.w,
                      child: AnimatedOpacity(
                        opacity: animationController.value,
                        duration: const Duration(milliseconds: 200),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Post malne',
                              style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w500, color: p.darkMutedColor?.titleTextColor),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 30.w),
                              width: MediaQuery.of(context).size.width - 90.w,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.skip_previous,
                                        color: p.darkMutedColor?.bodyTextColor,
                                        size: 66.w,
                                      ),
                                      Padding(padding: EdgeInsets.symmetric(horizontal: 50.w)),
                                      Icon(
                                        Icons.skip_next,
                                        color: p.darkMutedColor?.bodyTextColor,
                                        size: 66.w,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    child: Icon(
                                      Icons.favorite,
                                      size: 42.w,
                                      color: p.darkMutedColor?.bodyTextColor,
                                    ),
                                    onTap: () {},
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )))
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTopWidget(PaletteGenerator p) {
    return SafeArea(
        child: Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 30.w),
          child: Row(
            children: [
              SimpleExtendedImage(
                'http://p1.music.126.net/bfipOCObq0KmuW4m0o31mQ==/109951168928616871.jpg?param=180y180',
                width: 80.w,
                height: 80.w,
                borderRadius: BorderRadius.circular(50.w),
              ),
              Padding(padding: EdgeInsets.symmetric(horizontal: 10.w)),
              Expanded(
                  child: Text(
                'Post malne',
                style: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.w500, color: p.darkMutedColor?.titleTextColor),
              )),
              Icon(Icons.favorite, color: p.darkMutedColor?.titleTextColor)
            ],
          ),
        )
      ],
    ));
  }
}
