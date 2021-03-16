import 'package:bujuan/global/global_theme.dart';
import 'package:bujuan/home/home_controller.dart';
import 'package:bujuan/over_scroll.dart';
import 'package:bujuan/setting/setting_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SettingView extends GetView<SettingController> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      child: Obx(() => Scaffold(
        body: Column(
          children: [
            Expanded(child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  elevation: 0.0,
                  floating: false,
                  pinned: true,
                  title: Text("设置"),
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
                                  imageUrl: "https://pic3.zhimg.com/80/v2-c954015fa97a2986de8d4557376c587c_1440w.jpg",
                                  height: 100.0,
                                  width: 100.0,
                                ),
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                            Container(
                              child: Text(
                                "不倦App",
                                style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(padding: EdgeInsets.symmetric(vertical: 5.0)),
                            Container(
                              child: Text(
                                "版本号：1.0.5",
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
                  child: SwitchListTile(
                    title: Text("夜间模式"),
                    value: controller.isDark.value,
                    onChanged: (value) => controller.changeTheme(value),
                  ),
                ),
                SliverToBoxAdapter(
                    child: SwitchListTile(
                      title: Text("忽略音频焦点"),
                      subtitle: Text("其他音频应用开始播放时不会自动暂停"),
                      value: controller.isIgnoreAudioFocus.value,
                      onChanged: (value) => controller.toggleAudioFocus(value),
                    )
                )
              ],
            )),
            Offstage(
                offstage: !Get.find<HomeController>().login.value,
                child: ListTile(
                  title: Text(
                    "退出登录",
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                  onTap: () => controller.exit(),
                ))
          ],
        ),
      )),
      value: !Get.isDarkMode
          ? SystemUiOverlayStyle.light.copyWith(
              systemNavigationBarColor: lightTheme.primaryColor,
            )
          : SystemUiOverlayStyle.dark.copyWith(
              systemNavigationBarColor: darkTheme.primaryColor,
            ),
    );
  }

  Widget _buildAa(){
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text("设置"),
      ),
      body: Column(
        children: [
          Expanded(
              child: ScrollConfiguration(
                  behavior: OverScrollBehavior(),
                  child: ListView(
                    children: [
                      SwitchListTile(
                        title: Text("夜间模式"),
                        value: controller.isDark.value,
                        onChanged: (value) => controller.changeTheme(value),
                      ),
                      SwitchListTile(
                        title: Text("忽略音频焦点"),
                        subtitle: Text("其他音频应用开始播放时不会自动暂停"),
                        value: controller.isIgnoreAudioFocus.value,
                        onChanged: (value) => controller.toggleAudioFocus(value),
                      ),
                    ],
                  ))),
          Offstage(
              offstage: !Get.find<HomeController>().login.value,
              child: ListTile(
                title: Text(
                  "退出登录",
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                onTap: () => controller.exit(),
              ))
        ],
      ),
    );
  }
}
