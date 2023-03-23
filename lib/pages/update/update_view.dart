import 'package:auto_route/auto_route.dart';
import 'package:bujuan/common/constants/icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../common/constants/other.dart';
// import 'package:url_launcher/url_launcher.dart';

class UpdateView extends StatelessWidget {
  const UpdateView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        left: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.w),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        AutoRouter.of(context).pop();
                      },
                      icon: const Icon(TablerIcons.x),
                      iconSize: 52.w,
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                AppIcons.update,
                width: Get.width / 1.5,
                fit: BoxFit.fitWidth,
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 30.w)),
              Text(
                '检测到APP有新版本~',
                style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 28),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 10.w)),
              Text(
                '当前版本: ${context.routeData.queryParams.getString('oldVersion')}  最新版本: ${context.routeData.queryParams.getString('version')}',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 20.w)),
              Text(
                context.routeData.queryParams.getString('versionInfo').replaceAll(';', '\n'),
                maxLines: 10,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40.w),
                child: GestureDetector(
                  child: Container(
                    height: 88.w,
                    alignment: Alignment.center,
                    width: Get.width,
                    margin: EdgeInsets.symmetric(vertical: 40.w, horizontal: 25.w),
                    decoration: BoxDecoration(color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(20.w)),
                    child: Text(
                      '立即更新(并复制密码)',
                      style: TextStyle(fontSize: 32.sp, color: Colors.white),
                    ),
                  ),
                  onTap: () async {
                    Clipboard.setData(const ClipboardData(text: '2697')).then((value) async {
                      WidgetUtil.showToast('复制成功');
                      await launchUrl(Uri.parse(context.routeData.queryParams.getString('downloadUrl')), mode: LaunchMode.externalApplication);
                    });
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
