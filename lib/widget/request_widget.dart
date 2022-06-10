import 'package:bujuan/widget/refresh_controller.dart';
import 'package:flutter/material.dart';
import '../common/api/src/netease_util.dart';

typedef RequestChildBuilder<T> = Widget Function(T data);

class RequestBox<T> extends StatefulWidget {
  final RequestChildBuilder<T> childBuilder;
  final Error? onError;
  final Success<T>? onSuccess;
  final String url;
  final Map? data; //FormData示例：FormData.from({'start': '0', 'count': '10'})
  final bool wantKeepAlive;
  final bool showError;
  final String? baseUrl;
  final Widget? replacement;
  final RequestRefreshController? controller;

  const RequestBox(
      {Key? key,
      required this.url,
      required this.childBuilder,
      this.controller,
      this.data,
      this.onError,
      this.onSuccess,
      this.wantKeepAlive = false,
      this.baseUrl,
      this.replacement,
      this.showError = false})
      : super(key: key);

  @override
  RequestBoxState createState() {
    return RequestBoxState<T>();
  }
}

class RequestBoxState<T> extends State<RequestBox<T>> with RefreshState {
  late T _entity;
  bool _isLoaded = false;
  bool _isError = false;

  @override
  void initState() {
    super.initState();
    _bindController();
  }

  // 绑定Controller
  void _bindController() {
    widget.controller?.bindEasyRefreshState(this);
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isError) {
      return const SizedBox.shrink();
    }
    return _isLoaded
        ? widget.childBuilder(_entity)
        : widget.replacement ??
            const Center(
              child: Text('加载中'),
            );
  }

  @override
  callRefresh() {
    NetUtils().doHandler<T>(widget.url,
        param: widget.data ?? {},
        onSuccess: (data) {
          widget.onSuccess?.call(data);
          if (mounted) {
            setState(() {
              _entity = data;
              _isLoaded = true;
            });
          }
        },
        onError: () => setState(() => _isError = true));
  }

  @override
  setParams(Map<String, dynamic> params) {
    widget.data?.addEntries(params.entries);
  }
}
