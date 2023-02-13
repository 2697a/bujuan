import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:keframe/keframe.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/netease_api/src/dio_ext.dart';

typedef RequestChildBuilder<T> = Widget Function(List<T> data);
typedef OnData<T> = Function(T data);

class RequestLoadMoreWidget<E, T> extends StatefulWidget {
  final DioMetaData dioMetaData;
  final RequestChildBuilder<T> childBuilder;
  final RequestRefreshController? refreshController;
  final bool enableLoad;
  final bool isPageNmu;
  final int pageSize;
  final ScrollController? scrollController;
  final OnData<E>? onData;
  final List<String> listKey;
  final String? lastField;

  const RequestLoadMoreWidget({
    Key? key,
    required this.dioMetaData,
    required this.childBuilder,
    this.refreshController,
    this.enableLoad = true,
    this.onData,
    required this.listKey,
    this.scrollController,
    this.isPageNmu = false,
    this.pageSize = 30,
    this.lastField,
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
  CancelToken cancelToken = CancelToken();
  bool noMore = false;
  Map<String, dynamic>? map;

  @override
  initState() {
    dioMetaData = widget.dioMetaData;
    if (widget.isPageNmu) pageNum = 1;
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
    cancelToken.cancel();
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
        waterDropColor: Theme.of(context).colorScheme.onSecondary,
        refresh: CupertinoActivityIndicator(
          color: Theme.of(context).iconTheme.color,
        ),
        complete: RichText(
            text: TextSpan(children: [
              const WidgetSpan(
                  child: Padding(
                    padding: EdgeInsets.only(right: 16),
                    child: Icon(TablerIcons.mood_unamused),
                  )),
              TextSpan(text: '呼～  搞定', style: TextStyle(color: Theme.of(context).iconTheme.color))
            ])),
        idleIcon: Icon(
          TablerIcons.refresh,
          size: 15,
          color: Theme.of(context).cardColor,
        ),
      ),
      controller: _refreshController,
      onRefresh: () async {
        noMore = false;
        _refreshController.resetNoData();
        pageNum = widget.isPageNmu ? 1 : 0;
        if (widget.isPageNmu) {
          dioMetaData?.data['pageNo'] = pageNum;
        }
        if ((widget.lastField ?? '').isNotEmpty) {
          dioMetaData?.data[widget.lastField] = 0;
        }
        if (dioMetaData?.data['offset'] != null) {
          dioMetaData?.data['offset'] = pageNum;
        }
        callRefresh();
      },
      onLoading: () async {
        if (noMore) return;
        pageNum++;
        if (widget.isPageNmu) {
          dioMetaData?.data['pageNo'] = pageNum;
        }
        if ((widget.lastField ?? '').isNotEmpty) {
          dioMetaData?.data[widget.lastField] = map![widget.lastField];
        }
        if (dioMetaData?.data['offset'] != null) {
          dioMetaData?.data['offset'] = pageNum * widget.pageSize;
        }
        callRefresh();
      },
      child: widget.childBuilder(list),
    );
  }

  @override
  callRefresh() {
    Https.dioProxy.postUri(dioMetaData!, cancelToken: cancelToken).then((Response value) {
      int code = value.data['code'];
      if (widget.listKey.length == 2) {
        map = value.data[widget.listKey.first];
      }
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
        if (pageNum == (widget.isPageNmu ? 1 : 0)) list.clear();
        var listData = (mapData as List);
        setState(() {
          list.addAll(listData.map((e) => JsonConvert.fromJsonAsT<T>(e) as T).toList());
          _empty = list.isEmpty;
        });
        if (pageNum == (widget.isPageNmu ? 1 : 0)) {
          _refreshController.refreshCompleted();
        } else {
          _refreshController.loadComplete();
        }
        if (listData.length < widget.pageSize) {
          noMore = true;
          _refreshController.loadNoData();
        }
      } else {
        _error = true;
        setState(() {});
      }
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
    setState(() {
      _loading = true;
      _error = false;
      _empty = false;
    });
    pageNum = widget.isPageNmu ? 1 : 0;
    dioMetaData = params;
  }
}

mixin RefreshState {
  initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      callRefresh();
    });
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
