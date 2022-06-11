import 'package:bujuan/pages/index/index_controller.dart';
import 'package:bujuan/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../common/bean/personalized_entity.dart';
import '../../widget/request_widget.dart';
import '../../widget/simple_extended_image.dart';

class IndexView extends GetView<IndexController> {
  const IndexView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _rightView(),
        ],
      ),
      backgroundColor: Colors.transparent,
    );
  }

  Widget _rightView() {
    return Wrap(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.w),
          child: Text(
            '推荐歌单',
            style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold),
          ),
        ),
        RequestBox<PersonalizedEntity>(
          url: '/personalized',
          childBuilder: (data) => GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.w),
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.w,
              mainAxisSpacing: 20.w,
              childAspectRatio: .7,
            ),
            itemCount: data.result?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _buildItem(data.result![index]);
            },
          ),
        )
      ],
    );
  }

  Widget _buildItem(PersonalizedResult data) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.w), boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
          )
        ]),
        child: Column(
          children: [
            SimpleExtendedImage(
              data.picUrl ?? '',
              borderRadius: BorderRadius.circular(20.w),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 8.w),
              child: Text(
                data.name ?? '',
                style: TextStyle(fontSize: 24.sp),
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
      onTap: () => Get.toNamed(Routes.details,arguments: DetailsArguments(data)),
    );
  }

}
