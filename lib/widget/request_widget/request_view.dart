import 'package:bujuan/common/constants/other.dart';
import 'package:bujuan/common/netease_api/src/api/bean.dart';
import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:bujuan/widget/request_widget/request_loadmore_view.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../common/netease_api/src/dio_ext.dart';

typedef RequestChildBuilder<T> = Widget Function(T data);
typedef OnData<T> = Function(T data);

class RequestWidget<T> extends StatefulWidget {
  final DioMetaData dioMetaData;
  final RequestChildBuilder<T> childBuilder;
  final RequestRefreshController? refreshController;
  final bool refresh;
  final OnData<T>? onData;

  const RequestWidget({Key? key, required this.dioMetaData, required this.childBuilder, this.refreshController, this.refresh = true, this.onData}) : super(key: key);

  @override
  State<RequestWidget> createState() => RequestWidgetState<T>();
}

class RequestWidgetState<T> extends State<RequestWidget<T>> with RefreshState {
  late T data;
  bool _loading = true;
  bool _error = false;
  DioMetaData? dioMetaData;

  @override
  initState() {
    dioMetaData = widget.dioMetaData;
    super.initState();
    _bindController();
  }

  // 绑定Controller
  void _bindController() {
    widget.refreshController?.bindEasyRefreshState(this);
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const LoadingView()
        : _error
            ? const ErrorView()
            : widget.childBuilder(data);
  }

  @override
  callRefresh() {
    Https.dioProxy.postUri(dioMetaData!).then((Response value) {
      int code = 0;
      if (JsonConvert.fromJsonAsT<T>(value.data) is ServerStatusBean) {
        ServerStatusBean serverStatusBean = JsonConvert.fromJsonAsT<T>(value.data) as ServerStatusBean;
        code = serverStatusBean.code;
      } else {
        code = value.data['code'];
      }
      _loading = false;
      if (code == 200) {
        data = JsonConvert.fromJsonAsT<T>(value.data) as T;
        widget.onData?.call(data);
        _error = false;
      } else {
        _error = true;
      }
      if (widget.refresh) setState(() {});
      // if(serverStatusBean.code ==200){
      //   data = JsonConvert.fromJsonAsT<T>(value.data)!;
      // }
    }, onError: (e) {
      setState(() {
        _loading = false;
        _error = true;
      });
    });
  }

  @override
  setParams(DioMetaData params) {
    dioMetaData = params;
  }
}
