import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:bujuan/generated/json/base/json_convert_content.dart';
import 'package:bujuan/pages/home/home_controller.dart';
import 'package:bujuan/widget/data_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tabler_icons/flutter_tabler_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../common/constants/enmu.dart';
import '../../common/netease_api/src/api/play/bean.dart';
import '../../common/netease_api/src/dio_ext.dart';
import '../../common/netease_api/src/netease_handler.dart';
import '../../pages/home/view/panel_view.dart';
import '../../pages/user/user_controller.dart';

typedef RequestChildBuilder<T> = Widget Function(List<T> data);
typedef OnData<T> = Function(T data);

class RequestPlaylistLoadMoreWidget extends StatefulWidget {
  final RequestChildBuilder<MediaItem> childBuilder;
  final RequestRefreshController? refreshController;
  final bool enableLoad;
  final List<String> ids;
  final int pageSize;
  final ScrollController? scrollController;
  final OnData<SongDetailWrap>? onData;
  final List<String> listKey;
  final String? lastField;

  const RequestPlaylistLoadMoreWidget({
    Key? key,
    required this.ids,
    required this.childBuilder,
    this.refreshController,
    this.enableLoad = true,
    this.onData,
    required this.listKey,
    this.scrollController,
    this.pageSize = 30,
    this.lastField,
  }) : super(key: key);

  @override
  State<RequestPlaylistLoadMoreWidget> createState() => RequestPlaylistLoadMoreWidgetState();
}

class RequestPlaylistLoadMoreWidgetState extends State<RequestPlaylistLoadMoreWidget> with RefreshState {
  bool _loading = true;
  bool _error = false;
  bool _empty = false;
  DioMetaData? dioMetaData;
  List<MediaItem> list = [];
  final RefreshController _refreshController = RefreshController();
  int pageNum = 0;
  CancelToken cancelToken = CancelToken();
  bool noMore = false;
  Map<String, dynamic>? map;

  @override
  initState() {
    dioMetaData = songDetailDioMetaData(widget.ids);
    super.initState();
    _bindController();
  }

  DioMetaData songDetailDioMetaData(List<String> songIds) {
    var params = setPage();
    return DioMetaData(joinUri('/api/v3/song/detail'), data: params, options: joinOptions());
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

  setPage() {
    int start = 0;
    int end = 0;
    if (pageNum * widget.pageSize > widget.ids.length - 1) {
      return;
    }
    start = pageNum * widget.pageSize;
    end = pageNum * widget.pageSize + widget.pageSize;
    if (pageNum * widget.pageSize + widget.pageSize > widget.ids.length - 1) {
      end = widget.ids.length;
    }
    return {
      'c': '[${widget.ids.sublist(start, end).map((id) => '{"id":$id}').join(',')}]',
    };
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const ClassStatelessWidget(
            child: LoadingView(),
          )
        : _empty
            ? const EmptyView()
            : _error
                ? const ErrorView()
                : SmartRefresher(
                    // physics: const NeverScrollableScrollPhysics(),
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
                      pageNum = 0;
                      dioMetaData?.data = setPage();
                      callRefresh();
                    },
                    onLoading: () async {
                      if (noMore) return;
                      pageNum++;
                      dioMetaData?.data = setPage();
                      callRefresh();
                    },
                    child: widget.childBuilder(list),
                  );
  }

  @override
  callRefresh() async {
    if (widget.ids.isEmpty) {
      setState(() {
        _loading = false;
        _empty = true;
      });
      return;
    }
    Response value = await Https.dioProxy.postUri(dioMetaData!, cancelToken: cancelToken);
    int code = value.data['code'];
    if (widget.listKey.length == 2) {
      map = value.data[widget.listKey.first];
    }
    _loading = false;
    if (code == 200) {
      _error = false;
      SongDetailWrap data = JsonConvert.fromJsonAsT<SongDetailWrap>(value.data) as SongDetailWrap;
      if (widget.onData != null) {
        widget.onData?.call(data);
      }
      if (pageNum == 0) list.clear();
      setState(() {
        list.addAll(HomeController.to.song2ToMedia(data.songs ?? []));
        _empty = list.isEmpty;
      });
      if (pageNum == 0) {
        _refreshController.refreshCompleted();
      } else {
        _refreshController.loadComplete();
      }
      if ((data.songs ?? []).length < widget.pageSize) {
        noMore = true;
        _refreshController.loadNoData();
      }
    } else {
      _error = true;
      setState(() {});
    }
  }

  parseData(List<Song2> songs) {
    return songs
        .map((e) => MediaItem(
            id: e.id,
            duration: Duration(milliseconds: e.dt ?? 0),
            artUri: Uri.parse('${e.al?.picUrl ?? ''}?param=500y500'),
            extras: {
              'type': MediaType.playlist.name,
              'image': e.al?.picUrl ?? '',
              'liked': HomeController.to.likeIds.contains(int.tryParse(e.id)),
              'artist': (e.ar ?? []).map((e) => jsonEncode(e.toJson())).toList().join(' / '),
              'mv': e.mv
            },
            title: e.name ?? "",
            album: jsonEncode(e.al?.toJson()),
            artist: (e.ar ?? []).map((e) => e.name).toList().join(' / ')))
        .toList();
  }

  @override
  setParams(DioMetaData params) {
    setState(() {
      _loading = true;
      _error = false;
      _empty = false;
    });
    pageNum = 0;
    dioMetaData = params;
  }
}

class RequestPlaylistLoadMoreWidget1 extends StatelessWidget {
  const RequestPlaylistLoadMoreWidget1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
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
