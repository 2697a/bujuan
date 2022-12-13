import 'package:flutter/material.dart';

typedef RequestChildBuilder<T> = Widget Function(T data);

class DataWidget<T> extends StatefulWidget {
  final AsyncWidgetBuilder<T> builder;
  final Future<T>? future;

  const DataWidget({Key? key, required this.builder, this.future}) : super(key: key);

  @override
  State<DataWidget> createState() => _DataWidgetState();
}

class _DataWidgetState<T> extends State<DataWidget<T>> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: widget.builder,
      future: widget.future,
    );
  }
}

class DataView<T> extends StatefulWidget {
  final AsyncSnapshot<T> snapshot;
  final Widget childBuilder;
  final Widget? emptyView;
  final Widget? errorView;
  final Widget? loadingView;

  const DataView({Key? key, required this.snapshot, required this.childBuilder, this.emptyView, this.errorView, this.loadingView}) : super(key: key);

  @override
  State<DataView> createState() => _DataViewState();
}

class _DataViewState<T> extends State<DataView<T>> {
  @override
  Widget build(BuildContext context) {
    var returnWidget = widget.loadingView ?? const LoadingView();
    if (widget.snapshot.connectionState == ConnectionState.done) {
      if (widget.snapshot.hasError || widget.snapshot.error != null || !widget.snapshot.hasData) {
        returnWidget = widget.errorView ?? const Text('错误');
      }
      returnWidget = widget.childBuilder;
    }
    return returnWidget;
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('加载中'),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('暂无数据'),
    );
  }
}
