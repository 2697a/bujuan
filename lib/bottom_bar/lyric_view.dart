import 'package:bujuan/api/lyric/lyric_controller.dart';
import 'package:bujuan/api/lyric/lyric_util.dart';
import 'package:bujuan/api/lyric/lyric_widget.dart';
import 'package:flutter/material.dart';

class LyricView extends StatefulWidget {
  final lyric;
  final pos;

  const LyricView({Key key, this.lyric, this.pos}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LyricViewState();
}

class LyricViewState extends State<LyricView> {
  LyricController lyricController;
  final GlobalKey globalKey = GlobalKey();

  @override
  void initState() {
    lyricController = LyricController();
    super.initState();
  }

  @override
  void dispose() {
    lyricController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.pos != null) {
      lyricController.progress = Duration(seconds: widget.pos);
    }
    return Expanded(
        child: OrientationBuilder(
            key: globalKey,
            builder: (context, orientation) {
              return LyricWidget(
                  lyricMaxWidth: orientation == Orientation.landscape
                      ? MediaQuery.of(context).size.width / 1.4
                      : MediaQuery.of(context).size.width / 1.4,
                  enableDrag: false,
                  controller: lyricController,
                  lyrics: LyricUtil.formatLyric(widget.lyric),
                  size: Size(
                      orientation == Orientation.landscape
                          ? MediaQuery.of(context).size.width / 1.4
                          : MediaQuery.of(context).size.width / 1.4,
                      double.infinity));
            }));
  }
}
