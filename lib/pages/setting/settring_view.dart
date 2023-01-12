import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/storage.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../common/netease_api/src/dio_ext.dart';
import '../../routes/router.gr.dart';

class SettingView extends StatefulWidget {
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  String version = '1.0.0';
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getVersion());
  }

  _getVersion() async{
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
     setState(() {
       version = packageInfo.version;
     });
  }

  _update() {
    Https.dioProxy.get('https://gitee.com/yasengsuoai/bujuan_version/raw/master/version.json').then((value)  {
      Map<String, dynamic> versionData = value.data..putIfAbsent('oldVersion', () => version)..putIfAbsent('splash', () => '');
      if (int.parse((versionData['version']??'0').replaceAll('.', '')) > int.parse(version.replaceAll('.', ''))) {
        AutoRouter.of(context).push(const UpdateView().copyWith(queryParams: versionData));
      }
    });
  }

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
            _buildUiSetting(),
            _buildAppSetting()
          ],
        ),
      ),
    );
  }

  Widget _buildUiSetting(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
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


  Widget _buildAppSetting(){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
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
              'App设置',
              style: TextStyle(fontSize: 28.sp, color: Theme.of(context).cardColor.withOpacity(.4)),
            ),
          ),

          ListTile(
            title: Text(
              '检测更新',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Text(version),
            onTap: () => _update(),
          ),
        ],
      ),
    );
  }
}
