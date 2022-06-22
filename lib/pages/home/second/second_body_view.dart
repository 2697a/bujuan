import 'package:bujuan/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../common/constants/other.dart';

class SecondBodyView extends GetView<HomeController> {
  const SecondBodyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Opacity(
      opacity: controller.slidePosition.value,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20.w),
            child: SizedBox(height: controller.getPanelMinSize() + controller.getPanelAdd()),
          ),
          Row(
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                         'n',
                        style: TextStyle(fontSize: 36.sp, fontWeight: FontWeight.bold, color: controller.rx.value.dark?.bodyTextColor),
                        maxLines: 1,
                      ),
                      Padding(padding: EdgeInsets.symmetric(vertical: 5.w)),
                      Text(
                        'a',
                        style: TextStyle(fontSize: 28.sp, color: controller.rx.value.dark?.bodyTextColor),
                        maxLines: 1,
                      )
                    ],
                  )),
            ],
          ),
          _buildSlide(),
          _buildPlayController()
        ],
      ),
    ));
  }

  Widget _buildSlide() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        children: [
          SizedBox(
            child: SliderTheme(
                data: SliderThemeData(
                    activeTrackColor: controller.rx.value.dark?.bodyTextColor,
                    trackHeight: 3.w,
                    thumbShape: RoundSliderThumbShape(elevation: 0, enabledThumbRadius: 3.w),
                    thumbColor: Colors.transparent),
                child: Slider(
                    value: 1,
                    max: 100,
                    onChanged: (value) {
                    })),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ImageUtils.getTimeStamp(0),
                  style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 32.sp),
                ),
                Text(
                  ImageUtils.getTimeStamp(0),
                  style: TextStyle(color: controller.rx.value.dark?.bodyTextColor, fontSize: 32.sp),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPlayController() {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(vertical: 50.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.skip_previous,
                size: 60.w,
                color: controller.rx.value.dark?.bodyTextColor,
              )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 60.w),
            child: InkWell(
              child: Icon(
               Icons.play_circle_fill,
                size: 140.w,
                color: controller.rx.value.dark?.bodyTextColor.withOpacity(.6),
              ),
              onTap: () => controller.playOrPause(),
            ),
          ),
          IconButton(
              onPressed: (){},
              icon: Icon(
                Icons.skip_next,
                size: 60.w,
                color: controller.rx.value.dark?.bodyTextColor,
              )),
        ],
      ),
    ));
  }
}
