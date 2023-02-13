import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../common/constants/key.dart';
import '../../common/storage.dart';
import '../home/home_controller.dart';

class ImageBlur extends StatefulWidget {
  final String path;

  const ImageBlur({Key? key, required this.path}) : super(key: key);

  @override
  State<ImageBlur> createState() => _ImageBlurState();
}

class _ImageBlurState extends State<ImageBlur> {
  double blur = 0;
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Stack(
        children: [
          RepaintBoundary(
            key: _globalKey,
            child: Stack(
              children: [
                Image.file(
                  File(widget.path),
                  fit: BoxFit.cover,
                  width: 750.w,
                  height: Get.height,
                ),
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
                  child: Container(),
                )
              ],
            ),
          ),
          SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SliderTheme(data: SliderThemeData(
                    thumbColor: Theme.of(context).primaryColor,
                    activeTrackColor: Theme.of(context).primaryColor,
                    inactiveTickMarkColor: Theme.of(context).primaryColor.withOpacity(.6),
                  ), child: Slider(
                      value: blur,
                      max: 10,
                      min: 0,
                      onChanged: (v) {
                        setState(() {
                          blur = v;
                        });
                      })),
                  TextButton(onPressed: () async {
                    _saveImage();
                  }, child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(35.w)
                    ),
                    width: 150.w,
                    height: 70.w,
                    child: const Text('保存',style: TextStyle(color: Colors.white,fontSize: 16),),
                  ))
                ],
              ))
        ],
      ),
    );
  }

  _saveImage() async {
    WidgetUtil.showLoadingDialog(context);
    Uint8List data = await widgetToImage();
    var directory = await getApplicationSupportDirectory();
    String path = '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpeg';
    File file = File(path);
    if(await file.exists()){
      file.delete();
    }
    await file.writeAsBytes(data);
    Home.to.background.value = path;
    StorageUtil().setString(backgroundSp, path);
    if (mounted) Navigator.of(context).pop();
    if (mounted) Navigator.of(context).pop();
  }

  Future<Uint8List> widgetToImage() async {
    Completer<Uint8List> completer = Completer();

    RenderRepaintBoundary render = _globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await render.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    completer.complete(byteData?.buffer.asUint8List());

    return completer.future;
  }
}
