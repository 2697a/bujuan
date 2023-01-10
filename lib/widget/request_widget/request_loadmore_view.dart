import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/netease_api/src/dio_ext.dart';

typedef RequestChildBuilder<T> = Widget Function(List<T> data);
typedef OnData<T> = Function(T data);

class RequestLoadMoreWidget<E, T> extends StatefulWidget {
  final DioMetaData dioMetaData;
  final RequestChildBuilder<T> childBuilder;
  final RequestRefreshController? refreshController;
  final bool enableLoad;
  final ScrollController? scrollController;
  final OnData<E>? onData;
  final List<String> listKey;

  const RequestLoadMoreWidget({
    Key? key,
    required this.dioMetaData,
    required this.childBuilder,
    this.refreshController,
    this.enableLoad = true,
    this.onData,
    required this.listKey,
    this.scrollController,
  }) : super(key: key);

  @override
  State<RequestLoadMoreWidget> createState() => RequestLoadMoreWidgetState<E, T>();
}

class RequestLoadMoreWidgetState<E, T> extends State<RequestLoadMoreWidget<E, T>> with RefreshState {
  bool _loading = true;
  bool _error = false;
  bool _empty = false;
  DioMetaData? dioMetaData;
  List<T> list = [];
  final RefreshController _refreshController = RefreshController();
  int pageNum = 0;

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
  void dispose() {
    _refreshController.dispose();
    widget.refreshController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const LoadingView()
        : _empty
            ? const EmptyView()
            : _error
                ? const ErrorView()
                : SmartRefresher(
                    physics: const BouncingScrollPhysics(),
                    enablePullUp: widget.enableLoad,
                    scrollController: widget.scrollController,
                    header: WaterDropHeader(
                      waterDropColor: Theme.of(context).cardColor,
                    ),
                    controller: _refreshController,
                    onRefresh: () async {
                      pageNum = 0;
                      if (dioMetaData?.data['offset'] != null) {
                        dioMetaData?.data['offset'] = pageNum;
                      }
                      callRefresh();
                    },
                    onLoading: () async {
                      pageNum++;
                      if (dioMetaData?.data['offset'] != null) {
                        dioMetaData?.data['offset'] = pageNum * 30;
                      }
                      callRefresh();
                    },
                    child: widget.childBuilder(list),
                  );
  }

  @override
  callRefresh() {
    Https.dioProxy.postUri(dioMetaData!).then((Response value) {
      int code = value.data['code'];
      _loading = false;
      if (code == 200) {
        _error = false;
        if (widget.onData != null) {
          E data = JsonConvert.fromJsonAsT<E>(value.data) as E;
          if (data != null) widget.onData?.call(data);
        }
        var mapData = value.data;
        for (var element in widget.listKey) {
          mapData = mapData[element];
        }
        if (pageNum == 0) list.clear();
        var listData = (mapData as List);
        if (listData.length < 30) {
          _refreshController.loadNoData();
        }
        list.addAll(listData.map((e) => JsonConvert.fromJsonAsT<T>(e) as T).toList());
        _empty = list.isEmpty;
      } else {
        _error = true;
      }
      if (pageNum == 0) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.loadComplete();
      }
      if (mounted) setState(() {});
    }, onError: (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _error = true;
        });
      }
    });
  }

  @override
  setParams(DioMetaData params) {
    dioMetaData = params;
  }
}

mixin RefreshState {
  initState() {
    callRefresh();
  }

  setParams(DioMetaData params);

  callRefresh();
}

class RequestRefreshController {
  /// 更新入参并刷新
  void callRefreshWithParams(DioMetaData params) {
    _requestBoxState?.setParams(params);
    _requestBoxState?.callRefresh();
  }

  /// 触发刷新
  void callRefresh() {
    _requestBoxState?.callRefresh();
  }

  // 状态
  RefreshState? _requestBoxState;

  // 绑定状态
  void bindEasyRefreshState(RefreshState state) {
    _requestBoxState = state;
  }

  void dispose() {
    _requestBoxState = null;
  }
}
