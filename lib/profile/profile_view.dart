import 'package:bujuan/profile/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            elevation: 0.0,
            floating: true,
            pinned: true,
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: Stack(
                children: [
                  CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 230.0,
                    imageUrl: "https://pic1.zhimg.com/80/v2-7ff2d917aa926cfbf2e8b85b035e2563_1440w.jpg?source=1940ef5c",
                  ),
                  Column(
                    children: [
                      Expanded(child: Container()),
                      Hero(
                          tag: "${Get.arguments["avatar"]}",
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(100.0)),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${Get.arguments["avatar"]}",
                              height: 100.0,
                              width: 100.0,
                            ),
                          ))
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1300,
            ),
          )
        ],
      ),
    );
  }
}
