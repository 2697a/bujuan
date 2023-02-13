import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/netease_api/netease_music_api.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RequestWidget<MvUrlWrap>(
            dioMetaData: mvUrlDioMetaData('${context.routeData.queryParams.getInt('mvId')}'),
            onData: (mvUrl) async {
              _controller ??= VideoPlayerController.network(mvUrl.data.url ?? '');
              _controller?.initialize().then((value) {
                setState(() {});
                _controller?.play();
                _controller?.addListener(() {});
              });
            },
            childBuilder: (mvUrl) {
              return Visibility(
                visible: _controller?.value.isInitialized ?? false,
                child: MvWidget(videoPlayerController: _controller!),
              );
            }),
      ),
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
  bool isLandscape = false;
  bool isDrag = false;

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
    return WillPopScope(
        child: GestureDetector(
          child: SizedBox(
            height: !isLandscape ? 750.w / (16 / 9) : Get.height,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: !isLandscape ? 750.w / (16 / 9) : Get.height,
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
                        color: Colors.black,
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: isLandscape ? 20.h : 0.w),
                        child: Row(
                          children: [
                            Expanded(
                                child: ProgressBar(
                              progress: position,
                              buffered: position,
                              total: widget.videoPlayerController.value.duration,
                              timeLabelLocation: TimeLabelLocation.sides,
                              timeLabelTextStyle: const TextStyle(color: Colors.white),
                              progressBarColor: Colors.red,
                              baseBarColor: Colors.white.withOpacity(0.24),
                              bufferedBarColor: Colors.white.withOpacity(0.24),
                              thumbColor: Colors.white,
                              barHeight: 3.0,
                              thumbRadius: 5.0,
                              onDragUpdate: (e) {
                                isDrag = true;
                              },
                              onDragEnd: () {
                                isDrag = false;
                                Future.delayed(const Duration(seconds: 3), () {
                                  showLayer = false;
                                });
                              },
                              onSeek: (duration) {
                                widget.videoPlayerController.seekTo(duration);
                              },
                            )),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isLandscape = !isLandscape;
                                  });
                                  SystemChrome.setEnabledSystemUIMode(isLandscape ? SystemUiMode.immersiveSticky : SystemUiMode.edgeToEdge);
                                  SystemChrome.setPreferredOrientations([isLandscape ? DeviceOrientation.landscapeLeft : DeviceOrientation.portraitUp]);
                                },
                                icon: const Icon(
                                  TablerIcons.maximize,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          onTap: () {
            setState(() {
              showLayer = !showLayer;
            });
          },
        ),
        onWillPop: () async {
          if (isLandscape) {
            SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
            SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
            isLandscape = false;
            return false;
          }
          return true;
        });
  }
}
