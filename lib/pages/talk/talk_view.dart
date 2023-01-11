import 'package:auto_route/auto_route.dart';
import 'package:bujuan/widget/custom_filed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';

import '../../common/netease_api/src/api/event/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../widget/app_bar.dart';
import '../../widget/request_widget/request_loadmore_view.dart';
import '../../widget/simple_extended_image.dart';

class TalkView extends StatefulWidget {
  const TalkView({Key? key}) : super(key: key);

  @override
  State<TalkView> createState() => _TalkViewState();
}

class _TalkViewState extends State<TalkView> {
  int pageNum = 1;

  String _type2key(String type) {
    String typeKey = 'R_SO_4_';
    switch (type) {
      case 'song':
        typeKey = 'R_SO_4_';
        break;
      case 'mv':
        typeKey = 'R_MV_5_';
        break;
      case 'playlist':
        typeKey = 'A_PL_0_';
        break;
      case 'album':
        typeKey = 'R_AL_3_';
        break;
      case 'dj':
        typeKey = 'A_DJ_1_';
        break;
      case 'video':
        typeKey = 'R_VI_62_';
        break;
      case 'event':
        typeKey = 'A_EV_2_';
        break;
    }
    return typeKey;
  }

  DioMetaData commentListDioMetaData2(String id, String type, {int pageNo = 1, int pageSize = 30, bool showInner = true, int? sortType}) {
    String typeKey = _type2key(type) + id;
    var params = {
      'threadId': typeKey,
      'pageNo': pageNo,
      'pageSize': pageSize,
      'showInner': showInner,
      'sortType': 99,
      'cursor': (pageNum - 1) * pageSize,
    };
    return DioMetaData(joinUri('/api/v2/resource/comments'),
        data: params, options: joinOptions(encryptType: EncryptType.EApi, eApiUrl: '/api/v2/resource/comments', cookies: {'os': 'pc'}));
  }

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: RequestLoadMoreWidget<CommentList2Wrap, CommentItem>(
        listKey: const ['data', 'comments'],
        isPageNmu: true,
        pageSize: 30,
        dioMetaData: commentListDioMetaData2(context.routeData.queryParams.getString('id'), context.routeData.queryParams.getString('type'), pageNo: pageNum),
        childBuilder: (List<CommentItem> comments) => ListView.builder(
          itemBuilder: (BuildContext context, int index) => _buildItem(comments[index]),
          itemCount: comments.length,
        ),
      ),
      // bottomSheet: Padding(
      //   padding: EdgeInsets.symmetric(horizontal: 20.w),
      //   child: Row(
      //     children: [
      //       Expanded(child: CustomFiled(iconData: TablerIcons.message_2, textEditingController: _textEditingController)),
      //       IconButton(onPressed: (){}, icon: const Icon(TablerIcons.send),)
      //     ],
      //   ),
      // ),
    );
  }

  Widget _buildItem(CommentItem comment) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.w, horizontal: 30.w),
      child: Column(
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
                (comment.user.nickname ?? ''),
                style: TextStyle(fontSize: 28.sp),
              ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 20.w, left: 80.w),
            child: Text(
              (comment.content ?? '').replaceAll('\n', ''),
              style: TextStyle(fontSize: 24.sp),
            ),
          ),
          Visibility(
              visible: (comment.replyCount ?? 0) > 0,
              child: GestureDetector(
                child: Container(
                  margin: EdgeInsets.only(left: 60.w),
                  padding: EdgeInsets.symmetric(vertical: 16.w, horizontal: 20.w),
                  child: Text('${comment.replyCount}条回复 >', style: TextStyle(fontSize: 24.sp, color: Colors.blue)),
                ),
              ))
        ],
      ),
    );
  }
}
