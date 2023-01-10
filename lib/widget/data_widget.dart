import 'package:bujuan/common/constants/icon.dart';
import 'package:bujuan/widget/typewritertext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

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
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(AppIcons.loading,width: Get.width/2.9,),
          Lottie.asset('assets/lottie/empty_status.json', height: Get.width / 3.5, fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.low),
          Text('加载中...', style: TextStyle(fontSize: 28.sp)),
        ],
      ),
    );
  }
}


class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(AppIcons.loading,width: Get.width/2.9,),
          Lottie.asset('assets/lottie/empty_status.json', height: Get.width / 3.5, fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.low),
          Text('暂无数据...', style: TextStyle(fontSize: 28.sp)),
        ],
      ),
    );
  }
}

class ErrorView extends StatelessWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width,
      height: Get.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // SvgPicture.asset(AppIcons.loading,width: Get.width/2.9,),
          Lottie.asset('assets/lottie/no_internet_connection.json', height: Get.width / 2.5, fit: BoxFit.fitHeight,
              filterQuality: FilterQuality.low),
          Text('网络错误', style: TextStyle(fontSize: 32.sp)),
        ],
      ),
    );
  }
}

