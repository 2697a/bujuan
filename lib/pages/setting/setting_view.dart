import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/pages/setting/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                              child: Image.asset('assets/images/logo.png',width: 80.0,height: 80.0,),
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
                              '版本号：1.0.6',
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
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8.0),
                            topRight: Radius.circular(8.0)),
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                  child: SwitchListTile(
                title: Text('开启主屏滑动'),
                subtitle: Text('隐藏底部导航栏(更多空间)'),
                value: HomeController.to.scroller.value,
                onChanged: (value) => HomeController.to.changeBottomState(),
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
                  onTap: ()=>Get.toNamed('/about'),
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
                  onTap: ()=>Get.toNamed('/donate'),
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
}
