import 'package:bujuan/pages/search/search_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchView extends GetView<SearchController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Card(
            child: SafeArea(
              child: Row(
                children: [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
                  IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=>Get.back()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 3)),
                  Expanded(
                      child: TextField(
                        autofocus: true,
                        controller: controller.textEditingController,
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value){
                          Get.toNamed('/search_details',arguments: {'content':'$value'});
                          controller.textEditingController.text = '';
                        },
                        // inputFormatters: [FilteringTextInputFormatter(RegExp('[a-zA-Z]|[0-9.]'), allow: true)],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: '搜索',
                        ),
                      ))
                ],
              ),
            ),
          ),
          Expanded(child: Obx(()=>ListView.builder(itemBuilder: (context,index){
            return InkWell(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                padding: EdgeInsets.symmetric(horizontal: 12.0,vertical: 15.0),
                child: Row(
                  children: [
                    Text('${index+1}. '),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
                    Visibility(child:  CachedNetworkImage(
                      width: 16.0,
                      height: 16.0,
                      fit: BoxFit.fitWidth,
                      imageUrl: '${controller.searchList[index].iconUrl}',
                    ),visible: !GetUtils.isNullOrBlank(controller.searchList[index].iconUrl),),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 3.0)),
                    Text('${controller.searchList[index].content}')
                  ],
                ),
              ),
              onTap: (){
                Get.toNamed('/search_details',arguments: {'content':'${controller.searchList[index].searchWord}'});
              },
            );
          },itemCount: controller.searchList.length,padding: EdgeInsets.all(0),)))
        ],
      ),
    );
  }
}
