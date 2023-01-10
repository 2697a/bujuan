import 'package:bujuan/widget/data_widget.dart';
import 'package:flutter/material.dart';

import '../common/netease_api/src/api/bean.dart';

class BaseWidget<T extends ServerStatusBean> extends StatefulWidget {
  final Future<T> future;
  final Widget Function(T data) childBuilder;

  const BaseWidget({Key? key, required this.future, required this.childBuilder}) : super(key: key);

  @override
  State<BaseWidget> createState() => _BaseWidgetState();
}

class _BaseWidgetState<T extends ServerStatusBean> extends State<BaseWidget<T>> {
  bool loading = true;
  bool error = false;
  ServerStatusBean? serverStatusBean;

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const LoadingView();
    if (error) return const ErrorView();
    if (serverStatusBean == null) return const ErrorView();
    return widget.childBuilder(serverStatusBean! as T);
  }

  getData() async {
    serverStatusBean = (await widget.future);
    if (mounted) setState(() => loading = false);
    if (mounted) setState(() => error = serverStatusBean?.code != 200);
  }
}
