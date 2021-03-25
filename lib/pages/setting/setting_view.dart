import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/setting/setting_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              child: Obx(() => CustomScrollView(
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
                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0)),
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
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(80.0)),
                                      clipBehavior: Clip.antiAlias,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: 'https://pic3.zhimg.com/80/v2-c954015fa97a2986de8d4557376c587c_1440w.jpg',
                                        height: 100.0,
                                        width: 100.0,
                                      ),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                                  Container(
                                    child: Text(
                                      '不倦App',
                                      style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                                  Container(
                                    child: Text(
                                      '版本号：1.0.5',
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
                            Get.bottomSheet(
                              _buildThemeBottomSheet(),
                              backgroundColor: Theme.of(Get.context).primaryColor,
                              elevation: 6.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0), topRight: Radius.circular(8.0)),
                              ),
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                          child: SwitchListTile(
                        title: Text('开启主屏滑动'),
                        subtitle: Text('隐藏底部导航栏(更多空间)'),
                        value: Get.find<HomeController>().scroller.value,
                        onChanged: (value) => Get.find<HomeController>().changeBottomState(),
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
                            Text('高'),
                            Padding(padding: EdgeInsets.symmetric(horizontal: 2.0)),
                            Icon(
                              Icons.keyboard_arrow_right,
                              size: 22.0,
                            )
                          ],
                        ),
                      )),
                    ],
                  ))),
          Offstage(
              offstage: !Get.find<HomeController>().login.value,
              child: ListTile(
                title: Text(
                  '退出登录',
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                onTap: () => controller.exit(),
              ))
        ],
      ),
    );
  }

  Widget _buildThemeBottomSheet() {
    return Obx(() => Container(
          child: Wrap(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                  child: Text(
                    '主题设置',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  )),
              ListTile(
                title: Text('跟随系统'),
                onTap: () => controller.changeTheme(true),
                trailing: controller.isSystemTheme.value ? Icon(Icons.check_circle_outline_sharp, color: Theme.of(Get.context).accentColor) : null,
              ),
              ListTile(
                title: Text('日间模式'),
                onTap: () => controller.changeTheme(false, value: false),
                trailing: !controller.isSystemTheme.value && !controller.isDark.value ? Icon(Icons.check_circle_outline_sharp, color: Theme.of(Get.context).accentColor) : null,
              ),
              ListTile(
                title: Text('夜间模式'),
                onTap: () => controller.changeTheme(false, value: true),
                trailing: !controller.isSystemTheme.value && controller.isDark.value ? Icon(Icons.check_circle_outline_sharp, color: Theme.of(Get.context).accentColor) : null,
              )
            ],
          ),
        ));
  }
}
