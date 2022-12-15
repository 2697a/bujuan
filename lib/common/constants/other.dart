import 'dart:io';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:palette_generator/palette_generator.dart';

typedef ImageColorCallBack = void Function(PaletteColorData paletteColorData);

class ImageUtils {
  // static ImageStreamListener? _imageStreamListener;
  // static ImageStream? _imageStream;


  static getImageColor(String url, ImageColorCallBack imageCallBack) {
    ExtendedNetworkImageProvider imageProvider = ExtendedNetworkImageProvider(url);
    _getImageColorByProvider(imageProvider).then((value) {
      imageCallBack.call(value);
    });
    // _imageStream = imageProvider.resolve(ImageConfiguration.empty);
    // _imageStreamListener = ImageStreamListener((ImageInfo image, bool synchronousCall) async {
    //   ImageProvider _imageProvider = imageProvider;
    //   _imageStream?.removeListener(_imageStreamListener!);
    //   _getImageColorByProvider(_imageProvider).then((value) {
    //     imageCallBack.call(value);
    //   });
    // }, onError: (Object exception, StackTrace? stackTrace) {
    //   ImageProvider imageProvider =  AssetImage('');
    //   _getImageColorByProvider(imageProvider).then((value) {
    //     imageCallBack.call(value);
    //   });
    // });
    // _imageStream?.addListener(_imageStreamListener!);
  }
  static Future<PaletteColorData> getImageColor2(String url) async{
    ImageProvider imageProvider = ExtendedFileImageProvider(File(url));
    if(url.isEmpty){
      imageProvider = ExtendedAssetImageProvider('assets/images/placeholder.png');
    }
    return await _getImageColorByProvider(imageProvider);
    // _imageStream = imageProvider.resolve(ImageConfiguration.empty);
    // _imageStreamListener = ImageStreamListener((ImageInfo image, bool synchronousCall) async {
    //   ImageProvider _imageProvider = imageProvider;
    //   _imageStream?.removeListener(_imageStreamListener!);
    //   _getImageColorByProvider(_imageProvider).then((value) {
    //     imageCallBack.call(value);
    //   });
    // }, onError: (Object exception, StackTrace? stackTrace) {
    //   ImageProvider imageProvider =  AssetImage('');
    //   _getImageColorByProvider(imageProvider).then((value) {
    //     imageCallBack.call(value);
    //   });
    // });
    // _imageStream?.addListener(_imageStreamListener!);
  }

  static Future<PaletteColorData> _getImageColorByProvider(ImageProvider imageProvider) async {
    PaletteColorData paletteColorData = PaletteColorData();
    final PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(imageProvider, size: Size(50.w, 50.w));
    paletteColorData.light = paletteGenerator.lightMutedColor ?? paletteGenerator.lightVibrantColor;
    paletteColorData.dark = paletteGenerator.darkMutedColor ?? paletteGenerator.darkVibrantColor;
    paletteColorData.main = paletteGenerator.dominantColor ?? paletteGenerator.mutedColor;
    if (paletteColorData.light == null && paletteColorData.dark != null) {
      paletteColorData.light = paletteColorData.dark;
    }
    if (paletteColorData.dark == null && paletteColorData.light != null) {
      paletteColorData.dark = paletteColorData.light;
    }
    paletteColorData.main ?? paletteColorData.light;
    return paletteColorData;
  }

  // static Future<Uint8List> testCompressList(Uint8List list) async {
  //   print('压缩前========${list.length}====${DateTime.now()}');
  //   var result = await FlutterImageCompress.compressWithList(
  //     list,
  //     minHeight: 400,
  //     minWidth: 400,
  //     quality: 96,
  //   );
  //   if (kDebugMode) {
  //     print('压缩后========${result.length}====${DateTime.now()}');
  //   }
  //   return result;
  // }

  static String getTimeStamp(int milliseconds) {
    int seconds = (milliseconds / 1000).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }
}

class PaletteColorData {
  PaletteColor? light;
  PaletteColor? dark;
  PaletteColor? main;

  PaletteColorData({this.light, this.dark, this.main});
}

class WidgetUtil{
  static showToast(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
