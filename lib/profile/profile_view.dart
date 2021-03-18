import 'package:bujuan/entity/user_profile_entity.dart';
import 'package:bujuan/over_scroll.dart';
import 'package:bujuan/profile/profile_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends GetView<ProfileController> {
  @override
  Widget build(BuildContext context) {
    UserProfileEntity profile = Get.arguments['profile'];
    return Scaffold(
      body: ScrollConfiguration(
          behavior: OverScrollBehavior(),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0.0,
                floating: false,
                pinned: true,
                title: Text('${profile.profile.nickname}'),
                expandedHeight: 260.0,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Stack(
                    children: [
                      Container(
                        child: Card(
                          margin: EdgeInsets.all(0),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100.0))),
                          clipBehavior: Clip.antiAlias,
                          child: CachedNetworkImage(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            imageUrl: '${profile.profile.backgroundUrl}',
                          ),
                        ),
                      ),
                      Container(
                        color: Theme.of(context).primaryColor.withOpacity(.4),
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
                            child: Hero(
                                tag: 'avatar',
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadiusDirectional.circular(80.0)),
                                  clipBehavior: Clip.antiAlias,
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    imageUrl: '${profile.profile.avatarUrl}',
                                    height: 100.0,
                                    width: 100.0,
                                  ),
                                )),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 3.0)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text('${profile.profile.nickname}', style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                decoration: BoxDecoration(color: Theme.of(context).accentColor, borderRadius: BorderRadius.circular(20.0)),
                                child: Text('lv.${profile.level}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 1.5)),
                          Container(
                            child: Text(
                              '${profile.profile.signature}',
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ),
                          Padding(padding: EdgeInsets.symmetric(vertical: 1.5)),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text('关注：${profile.profile.follows}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
                                child: Text('粉丝：${profile.profile.followeds}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                                child: Text('听歌量：${profile.listenSongs}', style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold)),
                              )
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
