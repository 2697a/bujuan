import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import 'package:video_player/video_player.dart';

class MvView extends StatefulWidget {
  const MvView({Key? key}) : super(key: key);

  @override
  State<MvView> createState() => _MvViewState();
}

class _MvViewState extends State<MvView> {
  DioMetaData mvDetailDioMetaData(String mvId) {
    var params = {'id': mvId};
    return DioMetaData(joinUri('/weapi/mv/detail'), data: params, options: joinOptions());
  }

  DioMetaData mvUrlDioMetaData(String mvId, {int resolution = 1080}) {
    var params = {'id': mvId, 'r': resolution};
    return DioMetaData(joinUri('/weapi/song/enhance/play/mv/url'), data: params, options: joinOptions());
  }

  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: RequestWidget<MvUrlWrap>(
          dioMetaData: mvUrlDioMetaData((context.routeData.args as String)),
          onData: (mvUrl) async {
            _controller ??= VideoPlayerController.network(mvUrl.data.url ?? '');
            _controller?.initialize().then((value) {
              setState(() {});
              _controller?.play();
              _controller?.addListener(() {});
            });
          },
          childBuilder: (mvUrl) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Visibility(
                    visible: _controller?.value.isInitialized ?? false,
                    child: MvWidget(videoPlayerController: _controller!),
                  ),
                ],
              ),
            );
          }),),
    );
  }
}

class MvWidget extends StatefulWidget {
  final VideoPlayerController videoPlayerController;

  const MvWidget({Key? key, required this.videoPlayerController}) : super(key: key);

  @override
  State<MvWidget> createState() => _MvWidgetState();
}

class _MvWidgetState extends State<MvWidget> {
  Duration position = Duration.zero;
  bool playing = true;
  bool showLayer = false;

  @override
  void initState() {
    // TODO: implement initState
    widget.videoPlayerController.addListener(() {
      setState(() {
        position = widget.videoPlayerController.value.position;
        playing = widget.videoPlayerController.value.isPlaying;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: SizedBox(
        height: 750.w /(16/9),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 750.w /(16/9),
              color: Colors.black,
            ),
            GestureDetector(
              child: AspectRatio(
                aspectRatio: widget.videoPlayerController.value.aspectRatio,
                child: VideoPlayer(widget.videoPlayerController),
              ),
            ),
            Visibility(
              visible: showLayer,
              child: Container(
                color: Theme.of(context).scaffoldBackgroundColor.withOpacity(.5),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            onPressed: () {
                              AutoRouter.of(context).pop();
                            },
                            icon: const Icon(TablerIcons.x)),
                        IconButton(onPressed: () {}, icon: const Icon(TablerIcons.maximize))
                      ],
                    ),
                    Expanded(
                        child: Center(
                          child: IconButton(
                              onPressed: () {
                                if (playing) {
                                  widget.videoPlayerController.pause();
                                } else {
                                  widget.videoPlayerController.play();
                                }
                              },
                              icon: Icon(playing ? TablerIcons.player_pause : TablerIcons.player_play)),
                        )),
                    Container(
                      alignment: Alignment.centerLeft,
                      height: 90.w,
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: ProgressBar(
                        progress: position,
                        buffered: position,
                        total: widget.videoPlayerController.value.duration,
                        timeLabelLocation: TimeLabelLocation.sides,
                        progressBarColor: Colors.red,
                        baseBarColor: Colors.white.withOpacity(0.24),
                        bufferedBarColor: Colors.white.withOpacity(0.24),
                        thumbColor: Colors.white,
                        barHeight: 3.0,
                        thumbRadius: 5.0,
                        onSeek: (duration) {
                          widget.videoPlayerController.seekTo(duration);
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          showLayer = true;
          Future.delayed(const Duration(seconds: 3), () {
            showLayer = false;
          });
        });
      },
    );
  }
}
