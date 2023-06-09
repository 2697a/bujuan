import 'package:auto_route/auto_route.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/routes/router.gr.dart';
import 'package:bujuan/widget/simple_extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/netease_api/src/api/event/bean.dart';

class CommentView extends GetView<Home> {
  const CommentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 30.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => Text(
                  '热评榜',
                  style: TextStyle(color: controller.bodyColor.value, fontSize: 44.sp),
                )),
                TextButton(
                    onPressed: () {
                      context.router.push(const TalkView().copyWith(queryParams: {'id': controller.mediaItem.value.id, 'type': 'song','name':controller.mediaItem.value.title}));
                    },
                    child: Obx(() => Text(
                      '查看更多>',
                      style: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                    )))
              ],
            ),
          ),
          Obx(() => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0),
            itemBuilder: (context1, index) => _buildItem(controller.comments[index], context),
            itemCount: controller.comments.length,
          )),
        ],
      ),
    );
  }

  Widget _buildItem(CommentItem comment, BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 30.w),
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SimpleExtendedImage.avatar(
                    '${comment.user.avatarUrl ?? ''}?param=150y150',
                    width: 60.w,
                    height: 60.w,
                  ),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 8.w)),
                  Expanded(
                      child: Text(
                    '${comment.user.nickname ?? ''}   (${comment.likedCount}赞)',
                    style: TextStyle(color: controller.bodyColor.value, fontSize: 28.sp),
                  ))
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.w, left: 80.w),
                child: Text(
                  (comment.content ?? '').replaceAll('\n', ''),
                  style: TextStyle(color: controller.bodyColor.value, fontSize: 24.sp),
                ),
              ),
            ],
          );
        }),
      ),
      onTap: () {
          context.router.push(const TalkView().copyWith(queryParams: {'id': controller.mediaItem.value.id, 'type': 'song','name':controller.mediaItem.value.title}));
      },
    );
  }
}
