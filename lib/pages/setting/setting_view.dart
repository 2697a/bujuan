import 'package:bujuan/global/global_config.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/setting/setting_controller.dart';
import 'package:bujuan/utils/sp_util.dart';
import 'package:bujuan/widget/preload_page_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0.0,
                floating: false,
                pinned: true,
                title: Text('设置'),
                expandedHeight: 240.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(100.0)),
                        ),
                      ),
                      Column(
                        children: [
                          AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            leading: Container(),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadiusDirectional.circular(80.0)),
                              clipBehavior: Clip.antiAlias,
                              child: Image.asset(
                                'assets/images/logo.png',
                                width: 80.0,
                                height: 80.0,
                              ),
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                          Container(
                            child: Text(
                              '不倦App',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                          Container(
                            child: Text(
                              '版本号：1.0.9',
                              style: TextStyle(fontSize: 14.0),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  title: Text("主题设置"),
                  subtitle: Text("切换主题"),
                  trailing: Wrap(
                    children: [
                      Text(
                        controller.isSystemTheme.value
                            ? "跟随系统"
                            : controller.isDark.value
                                ? '夜间模式'
                                : '日间模式',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 22.0,
                      )
                    ],
                  ),
                  onTap: () {
                    Get.bottomSheet(_buildThemeBottomSheet(),
                        isScrollControlled: true,
                        backgroundColor: Theme.of(Get.context).primaryColor,
                        elevation: 6.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0)),
                        ));
                  },
                ),
              ),
              SliverToBoxAdapter(
                  child: GetBuilder<HomeController>(
                builder: (_) => ListTile(
                  title: Text('播放页样式'),
                  subtitle: Text('切换风格'),
                  trailing: Wrap(
                    children: [
                      Text(
                        _.secondPlayView ? '方形' : '圆形',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
                      Icon(
                        Icons.keyboard_arrow_right,
                        size: 22.0,
                      )
                    ],
                  ),
                  onTap: () {
                    Get.bottomSheet(
                      _buildPlayViewBottomSheet(),
                      backgroundColor: Theme.of(Get.context).primaryColor,
                      elevation: 6.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      ),
                    );
                  },
                ),
                id: 'second_view',
                init: HomeController(),
              )),
              SliverToBoxAdapter(
                  child: SwitchListTile(
                title: Text('默认显示我的页面'),
                subtitle: Text('更改首屏页面'),
                value: controller.firstIndex.value == 0,
                onChanged: (value) {
                  controller.changeFirstIndex(value);
                },
              )),
              SliverToBoxAdapter(
                  child: GetBuilder<HomeController>(
                builder: (_) => SwitchListTile(
                  title: Text('mini播放页'),
                  subtitle: Text('mini'),
                  value: _.miniPlayView,
                  onChanged: (value) {
                    _.changeMiniPlayView(value);
                    SpUtil.putBool(MINI_PLAY_VIEW, value);
                  },
                ),
                id: 'view_type',
                init: HomeController(),
              )),
              SliverToBoxAdapter(
                  child: SwitchListTile(
                title: Text('忽略音频焦点'),
                subtitle: Text('其他音频应用开始播放时不会自动暂停'),
                value: controller.isIgnoreAudioFocus.value,
                onChanged: (value) => controller.toggleAudioFocus(value),
              )),
              SliverToBoxAdapter(
                  child: ListTile(
                title: Text('音质选择'),
                trailing: Wrap(
                  children: [
                    Text(
                      controller.quality.value == '128000'
                          ? "128k(中)"
                          : controller.quality.value == '320000'
                              ? '320k(高)'
                              : '999k(极高需会员)',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
                    Icon(
                      Icons.keyboard_arrow_right,
                      size: 22.0,
                    )
                  ],
                ),
                onTap: () {
                  Get.bottomSheet(
                    _buildQualityBottomSheet(),
                    backgroundColor: Theme.of(Get.context).primaryColor,
                    elevation: 6.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(8.0)),
                    ),
                  );
                },
              )),
              SliverToBoxAdapter(
                child: ListTile(
                  title: Text('关于'),
                  subtitle: Text('关于bujuan'),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    size: 22.0,
                  ),
                  onTap: () => Get.toNamed('/about'),
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  title: Text('捐赠'),
                  subtitle: Text('请理性捐赠'),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    size: 22.0,
                  ),
                  onTap: () => Get.toNamed('/donate'),
                ),
              ),
              SliverToBoxAdapter(
                child: ListTile(
                  title: Text('检查更新'),
                  subtitle: Text('请理性捐赠'),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    size: 22.0,
                  ),
                  onTap: () async {
                    var dio = Dio();
                    var response =
                        await dio.get('http://www.sixbugs.com/update.json');
                    print(response.data['versionCode']);
                    if (response.statusCode == 200 &&
                        !GetUtils.isNullOrBlank(response.data) &&
                        !GetUtils.isNullOrBlank(response.data['downloadUrl']) &&
                        !GetUtils.isNullOrBlank(response.data['versionCode'])) {
                      PackageInfo packageInfo =
                          await PackageInfo.fromPlatform();
                      String buildNumber = packageInfo.buildNumber;
                      if (response.data['versionCode'] >
                          int.parse(buildNumber)) {
                        Get.defaultDialog(
                            title: '发现新版本（${response.data['version']}）',
                            content: Text('${response.data['updateInfo']}'),
                            textConfirm: '点击下载',
                            confirmTextColor: Colors.white,
                            onConfirm: () async {
                              var data = response.data['downloadUrl'];
                              print('${data}');
                              launch(data);
                            });
                      }
                    }
                  },
                ),
              )
            ],
          )),
    );
  }

  Widget _buildThemeBottomSheet() {
    return Obx(() => Container(
          child: Wrap(
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Text(
                    '主题设置',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
              ListTile(
                title: Text('跟随系统'),
                onTap: () => controller.changeTheme(true),
                trailing: controller.isSystemTheme.value
                    ? Icon(Icons.check_circle_outline_sharp,
                        color: Theme.of(Get.context).accentColor)
                    : null,
              ),
              ListTile(
                title: Text('日间模式'),
                onTap: () => controller.changeTheme(false, value: false),
                trailing:
                    !controller.isSystemTheme.value && !controller.isDark.value
                        ? Icon(Icons.check_circle_outline_sharp,
                            color: Theme.of(Get.context).accentColor)
                        : null,
              ),
              ListTile(
                title: Text('夜间模式'),
                onTap: () => controller.changeTheme(false, value: true),
                trailing:
                    !controller.isSystemTheme.value && controller.isDark.value
                        ? Icon(Icons.check_circle_outline_sharp,
                            color: Theme.of(Get.context).accentColor)
                        : null,
              )
            ],
          ),
        ));
  }

  Widget _buildQualityBottomSheet() {
    return Obx(() => Container(
          child: Wrap(
            children: [
              Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Text(
                    '音质选择',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
              ListTile(
                title: Text('128k(中)'),
                onTap: () => controller.changeQuality('128000'),
                trailing: controller.quality.value == '128000'
                    ? Icon(Icons.check_circle_outline_sharp,
                        color: Theme.of(Get.context).accentColor)
                    : null,
              ),
              ListTile(
                title: Text('320k(高)'),
                onTap: () => controller.changeQuality('320000'),
                trailing: controller.quality.value == '320000'
                    ? Icon(Icons.check_circle_outline_sharp,
                        color: Theme.of(Get.context).accentColor)
                    : null,
              ),
              ListTile(
                title: Text('999k(极高需会员)'),
                onTap: () => controller.changeQuality('999000'),
                trailing: controller.quality.value == '999000'
                    ? Icon(Icons.check_circle_outline_sharp,
                        color: Theme.of(Get.context).accentColor)
                    : null,
              )
            ],
          ),
        ));
  }

  Widget _buildPlayViewBottomSheet() {
    return Column(
      children: [
        ListTile(
          title: Text('播放页样式'),
          trailing: Text('确定'),
          onTap: () {
            HomeController.to
                .changeSecondPlayView(controller.playViewIndex == 1);
            SpUtil.putBool(SECOND_PLAY_VIEW, controller.playViewIndex == 1);
            Get.back();
          },
        ),
        Expanded(
            child: PreloadPageView(
          controller: PreloadPageController(
              initialPage: controller.playViewIndex, viewportFraction: .9),
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Card(
                color: Theme.of(Get.context).accentColor.withOpacity(.5),
                child: Column(
                  children: [
                    ListTile(
                      title: Center(
                        child: Text('圆形播放页'),
                      ),
                    ),
                    Card(
                      shadowColor: Colors.blue[300].withOpacity(.1),
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadiusDirectional.circular(200.0)),
                      color: Colors.grey[300],
                      child: SizedBox(
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                    Expanded(
                        child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.skip_previous),
                          Icon(
                            Icons.play_arrow,
                            size: 38.0,
                          ),
                          Icon(Icons.skip_next),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.0),
              child: Card(
                color: Theme.of(Get.context).accentColor.withOpacity(.5),
                child: Column(
                  children: [
                    ListTile(
                      title: Center(
                        child: Text('方形播放页'),
                      ),
                    ),
                    Card(
                      color: Colors.grey[300],
                      child: SizedBox(
                        width: 200.0,
                        height: 200.0,
                      ),
                    ),
                    Expanded(
                        child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.skip_previous),
                          Icon(
                            Icons.play_arrow,
                            size: 38.0,
                          ),
                          Icon(Icons.skip_next),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            ),
          ],
          onPageChanged: (index) {
            controller.playViewIndex = index;
          },
        ))
      ],
    );
  }
}
