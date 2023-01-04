import 'package:auto_route/auto_route.dart';
import 'package:bujuan/widget/request_widget/request_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../common/netease_api/src/api/event/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';

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

  DioMetaData commentListDioMetaData2(String id, String type, {int pageNo = 1, int pageSize = 20, bool showInner = true, int? sortType}) {
    String typeKey = _type2key(type) + id;
    var params = {'threadId': typeKey, 'pageNo': pageNo, 'pageSize': pageSize, 'showInner': showInner, 'sortType': 2};
    return DioMetaData(joinUri('/api/v2/resource/comments'),
        data: params, options: joinOptions(encryptType: EncryptType.EApi, eApiUrl: '/api/v2/resource/comments', cookies: {'os': 'android'}));
  }

  final RequestRefreshController _refreshController = RequestRefreshController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RequestWidget<CommentList2Wrap>(
        refreshController: _refreshController,
        dioMetaData: commentListDioMetaData2((context.routeData.args as String), 'song',pageNo: pageNum),
        childBuilder: (data) => ListView.builder(
          itemBuilder: (BuildContext context, int index) => _buildItem((data.data.comments??[])[index]),
          itemCount: (data.data.comments ?? []).length,
        ),
      ),
    );
  }

  Widget _buildItem(CommentItem data){
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 32.w),
        child: Text(data.content??''),
      ),
      onTap: (){
        pageNum++;
        _refreshController.callRefreshWithParams(commentListDioMetaData2((context.routeData.args as String), 'song',pageNo: pageNum));
      },
    );
  }
}
