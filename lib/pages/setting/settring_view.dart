import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/key.dart';
import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/app_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getVersion());
  }

  @override
  dispose() {
    super.dispose();
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  _update() async {
    WidgetUtil.showLoadingDialog(context);
    try {
      Response value = await Https.dioProxy.get('https://gitee.com/yasengsuoai/bujuan_version/raw/master/version.json');
      if (mounted) Navigator.of(context).pop();
      Map<String, dynamic> versionData = value.data..putIfAbsent('oldVersion', () => version);
      if (int.parse((versionData['version'] ?? '0').replaceAll('.', '')) > int.parse(version.replaceAll('.', ''))) {
        if (mounted) AutoRouter.of(context).push(const UpdateView().copyWith(queryParams: versionData));
      } else {
        WidgetUtil.showToast('已是最新版本');
      }
    } on DioError catch (e) {
      WidgetUtil.showToast('网络错误');
      if (mounted) Navigator.of(context).pop();
    }
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
          children: [_buildUiSetting(), _buildAppSetting()],
        ),
      ),
    );
  }

  Widget _buildUiSetting() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(25.w)),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
            alignment: Alignment.centerLeft,
            child: Text(
              'UI设置',
              style: TextStyle(fontSize: 28.sp, color: Theme.of(context).cardColor.withOpacity(.4)),
            ),
          ),
          ListTile(
            title: Text(
              '渐变播放背景(需开启智能取色)',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              Home.to.gradientBackground.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity(Home.to.gradientBackground.value ? 0.7 : .4),
            )),
            onTap: () {
              Home.to.gradientBackground.value = !Home.to.gradientBackground.value;
              Home.to.box.put(gradientBackgroundSp, Home.to.gradientBackground.value);
            },
          ),
          ListTile(
            title: Text(
              '顶部歌词',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
                  Home.to.topLyric.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
                  size: 56.w,
                  color: Theme.of(context).cardColor.withOpacity(Home.to.topLyric.value ? 0.7 : .4),
                )),
            onTap: () {
              Home.to.topLyric.value = !Home.to.topLyric.value;
              Home.to.box.put(topLyricSp, Home.to.topLyric.value);
            },
          ),
          ListTile(
            title: Text(
              '圆形专辑',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              Home.to.roundAlbum.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity(Home.to.roundAlbum.value ? 0.7 : .4),
            )),
            onTap: () {
              Home.to.roundAlbum.value = !Home.to.roundAlbum.value;
              Home.to.box.put(roundAlbumSp, Home.to.roundAlbum.value);
            },
          ),
          ListTile(
            title: Text(
              '自定义背景',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Icon(
              TablerIcons.chevron_right,
              size: 42.w,
              color: Theme.of(context).cardColor.withOpacity(.6),
            ),
            onTap: () async {
              XFile? x = await _picker.pickImage(source: ImageSource.gallery, requestFullMetadata: false);
              if (x != null && mounted) {
                context.router.push( ImageBlur(path: x.path));
              }
            },
          ),
          ListTile(
            title: Text(
              '清除自定义背景',
              style: TextStyle(fontSize: 30.sp),
            ),
            // trailing: Icon(
            //   TablerIcons.chevron_right,
            //   size: 42.w,
            //   color: Theme.of(context).cardColor.withOpacity(.6),
            // ),
            onTap: () async {
              if(Home.to.background.value.isEmpty){
                WidgetUtil.showToast('没有设置背景');
                return;
              }
              Home.to.background.value = '';
              Home.to.box.put(backgroundSp, '');
              WidgetUtil.showToast('清除成功');
            },
          ),

          ListTile(
            title: Text(
              '自定义启动图',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Icon(
              TablerIcons.chevron_right,
              size: 42.w,
              color: Theme.of(context).cardColor.withOpacity(.6),
            ),
            onTap: () async {
              XFile? x = await _picker.pickImage(source: ImageSource.gallery, requestFullMetadata: false);
              if (x != null && mounted) {
                Home.to.box.put(splashBackgroundSp, x.path);
              }
            },
          ),
          ListTile(
            title: Text(
              '清除启动图',
              style: TextStyle(fontSize: 30.sp),
            ),
            onTap: () async {
              Home.to.box.put(splashBackgroundSp, '');
              WidgetUtil.showToast('清除成功');
            },
          )
        ],
      ),
    );
  }

  Widget _buildAppSetting() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(25.w)),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
            alignment: Alignment.centerLeft,
            child: Text(
              'App设置',
              style: TextStyle(fontSize: 28.sp, color: Theme.of(context).cardColor.withOpacity(.4)),
            ),
          ),
          ListTile(
            title: Text(
              '开启高音质(与会员有关)',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
                  Home.to.high.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
                  size: 56.w,
                  color: Theme.of(context).cardColor.withOpacity(Home.to.high.value ? 0.7 : .4),
                )),
            onTap: () {
              Home.to.high.value = !Home.to.high.value;
              Home.to.box.put(highSong, Home.to.high.value);
            },
          ),
          ListTile(
            title: Text(
              '开启缓存',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
                  Home.to.cache.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
                  size: 56.w,
                  color: Theme.of(context).cardColor.withOpacity(Home.to.cache.value ? 0.7 : .4),
                )),
            onTap: () {
              Home.to.cache.value = !Home.to.cache.value;
              Home.to.box.put(cacheSp, Home.to.cache.value);
            },
          ),
          // ListTile(
          //   title: Text(
          //     '清理缓存',
          //     style: TextStyle(fontSize: 30.sp),
          //   ),
          //   trailing: Icon(
          //     TablerIcons.chevron_right,
          //     size: 42.w,
          //     color: Theme.of(context).cardColor.withOpacity(.6),
          //   ),
          //   onTap: () async {
          //     WidgetUtil.showLoadingDialog(context);
          //     await Downloader.clearCachedFiles();
          //     if (mounted) Navigator.of(context).pop();
          //   },
          // ),
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



class SettingViewL extends StatefulWidget {
  const SettingViewL({Key? key}) : super(key: key);

  @override
  State<SettingViewL> createState() => _SettingViewStateL();
}

class _SettingViewStateL extends State<SettingViewL> {
  String version = '1.0.0';
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _getVersion());
  }

  @override
  dispose() {
    super.dispose();
  }

  _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  _update() async {
    WidgetUtil.showLoadingDialog(context);
    try {
      Response value = await Https.dioProxy.get('https://gitee.com/yasengsuoai/bujuan_version/raw/master/version.json');
      if (mounted) Navigator.of(context).pop();
      Map<String, dynamic> versionData = value.data..putIfAbsent('oldVersion', () => version);
      if (int.parse((versionData['version'] ?? '0').replaceAll('.', '')) > int.parse(version.replaceAll('.', ''))) {
        if (mounted) AutoRouter.of(context).push(const UpdateView().copyWith(queryParams: versionData));
      } else {
        WidgetUtil.showToast('已是最新版本');
      }
    } on DioError catch (e) {
      WidgetUtil.showToast('网络错误');
      if (mounted) Navigator.of(context).pop();
    }
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
          children: [_buildUiSetting(), _buildAppSetting()],
        ),
      ),
    );
  }

  Widget _buildUiSetting() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(25.w)),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
            alignment: Alignment.centerLeft,
            child: Text(
              'UI设置',
              style: TextStyle(fontSize: 28.sp, color: Theme.of(context).cardColor.withOpacity(.4)),
            ),
          ),
          ListTile(
            title: Text(
              '渐变播放背景(需开启智能取色)',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              Home.to.gradientBackground.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity(Home.to.gradientBackground.value ? 0.7 : .4),
            )),
            onTap: () {
              Home.to.gradientBackground.value = !Home.to.gradientBackground.value;
              Home.to.box.put(gradientBackgroundSp, Home.to.gradientBackground.value);
            },
          ),
          ListTile(
            title: Text(
              '顶部歌词',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              Home.to.topLyric.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity(Home.to.topLyric.value ? 0.7 : .4),
            )),
            onTap: () {
              Home.to.topLyric.value = !Home.to.topLyric.value;
              Home.to.box.put(topLyricSp, Home.to.topLyric.value);
            },
          ),
          ListTile(
            title: Text(
              '圆形专辑',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              Home.to.roundAlbum.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity(Home.to.roundAlbum.value ? 0.7 : .4),
            )),
            onTap: () {
              Home.to.roundAlbum.value = !Home.to.roundAlbum.value;
              Home.to.box.put(roundAlbumSp, Home.to.roundAlbum.value);
            },
          ),
          ListTile(
            title: Text(
              '自定义背景',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Icon(
              TablerIcons.chevron_right,
              size: 42.w,
              color: Theme.of(context).cardColor.withOpacity(.6),
            ),
            onTap: () async {
              XFile? x = await _picker.pickImage(source: ImageSource.gallery, requestFullMetadata: false);
              if (x != null && mounted) {
                context.router.push( ImageBlur(path: x.path));
              }
            },
          ),
          ListTile(
            title: Text(
              '清除自定义背景',
              style: TextStyle(fontSize: 30.sp),
            ),
            // trailing: Icon(
            //   TablerIcons.chevron_right,
            //   size: 42.w,
            //   color: Theme.of(context).cardColor.withOpacity(.6),
            // ),
            onTap: () async {
              if(Home.to.background.value.isEmpty){
                WidgetUtil.showToast('没有设置背景');
                return;
              }
              Home.to.background.value = '';
              Home.to.box.put(backgroundSp, '');
              WidgetUtil.showToast('清除成功');
            },
          ),

          ListTile(
            title: Text(
              '自定义启动图',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Icon(
              TablerIcons.chevron_right,
              size: 42.w,
              color: Theme.of(context).cardColor.withOpacity(.6),
            ),
            onTap: () async {
              XFile? x = await _picker.pickImage(source: ImageSource.gallery, requestFullMetadata: false);
              if (x != null && mounted) {
                Home.to.box.put(splashBackgroundSp, x.path);
              }
            },
          ),
          ListTile(
            title: Text(
              '清除启动图',
              style: TextStyle(fontSize: 30.sp),
            ),
            onTap: () async {
              Home.to.box.put(splashBackgroundSp, '');
              WidgetUtil.showToast('清除成功');
            },
          )
        ],
      ),
    );
  }

  Widget _buildAppSetting() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.w),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onSecondary, borderRadius: BorderRadius.circular(25.w)),
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15.w, horizontal: 10.w),
            alignment: Alignment.centerLeft,
            child: Text(
              'App设置',
              style: TextStyle(fontSize: 28.sp, color: Theme.of(context).cardColor.withOpacity(.4)),
            ),
          ),
          ListTile(
            title: Text(
              '开启高音质(与会员有关)',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              Home.to.high.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity(Home.to.high.value ? 0.7 : .4),
            )),
            onTap: () {
              Home.to.high.value = !Home.to.high.value;
              Home.to.box.put(highSong, Home.to.high.value);
            },
          ),
          ListTile(
            title: Text(
              '开启缓存',
              style: TextStyle(fontSize: 30.sp),
            ),
            trailing: Obx(() => Icon(
              Home.to.cache.value ? TablerIcons.toggle_right : TablerIcons.toggle_left,
              size: 56.w,
              color: Theme.of(context).cardColor.withOpacity(Home.to.cache.value ? 0.7 : .4),
            )),
            onTap: () {
              Home.to.cache.value = !Home.to.cache.value;
              Home.to.box.put(cacheSp, Home.to.cache.value);
            },
          ),
          // ListTile(
          //   title: Text(
          //     '清理缓存',
          //     style: TextStyle(fontSize: 30.sp),
          //   ),
          //   trailing: Icon(
          //     TablerIcons.chevron_right,
          //     size: 42.w,
          //     color: Theme.of(context).cardColor.withOpacity(.6),
          //   ),
          //   onTap: () async {
          //     WidgetUtil.showLoadingDialog(context);
          //     await Downloader.clearCachedFiles();
          //     if (mounted) Navigator.of(context).pop();
          //   },
          // ),
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