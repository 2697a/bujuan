import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/storage.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: const Text('设置'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            _buildUiSetting()
          ],
        ),
      ),
    );
  }

  Widget _buildUiSetting(){
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSecondary,
        borderRadius: BorderRadius.circular(25.w)
      ),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.w,horizontal: 10.w),
            alignment: Alignment.centerLeft,
            child: Text(
              'UI设置',
              style: TextStyle(fontSize: 28.sp, color: Theme.of(context).cardColor.withOpacity(.4)),
            ),
          ),
          ListTile(
            title: Text(
              '首页右上角图片',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              HomeController.to.leftImage.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity( HomeController.to.leftImage.value ?0.7:.4),
            )),
            onTap: () {
              HomeController.to.leftImage.value = !HomeController.to.leftImage.value;
              StorageUtil().setBool(leftImageSp, HomeController.to.leftImage.value);
            },
          ),
          ListTile(
            title: Text(
              '渐变播放背景',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              HomeController.to.gradientBackground.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity( HomeController.to.gradientBackground.value ?0.7:.4),
            )),
            onTap: () {
              HomeController.to.gradientBackground.value = !HomeController.to.gradientBackground.value;
              StorageUtil().setBool(gradientBackgroundSp, HomeController.to.gradientBackground.value);
            },
          )
        ],
      ),
    );
  }
}
