import 'package:bujuan/play_view/timing/timing_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimingView extends GetView<TimingController> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width/5*2.15+60,
      child: Obx(()=>Column(
        children: [
          SwitchListTile(
            value: controller.isStart.value,
            onChanged: (value) =>controller.changeState(value),
            title: Row(
              children: [Text("定时停止播放${controller.selectIndex}===${controller.time.value}")],
            ),
          ),
          Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            height: MediaQuery.of(context).size.width/5*2.15,
            child: GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10,
                  crossAxisCount: 5, //每行三列
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 1),
              itemBuilder: (context, index) {
                return InkWell(
                  child: Card(
                    color: controller.selectIndex.value==index?Theme.of(context).accentColor:CardTheme.of(context).color,
                    child: Container(
                      padding: EdgeInsets.only(bottom: 6.0),
                      child: Column(
                        children: [
                          Expanded(child: Center(
                            child: Text("${controller.data[index].name}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          )),
                          Text("${controller.data[index].format}",style: TextStyle(fontSize: 12),)
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    controller.changeIndex(index);
                  },
                );
              },
              itemCount: controller.data.length,
            ),
          )
        ],
      )),
    );
  }
}
