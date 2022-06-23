import 'package:bujuan/common/bean/playlist_entity.dart';
import 'package:bujuan/common/bean/song_details_entity.dart';
import 'package:bujuan/pages/details/details_controller.dart';
import 'package:bujuan/widget/request_widget.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailsView extends GetView<DetailsController> {
  const DetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }

}
