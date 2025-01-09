import 'dart:async';
import 'package:bujuan_music_api/api/user/entity/qr_check_entity.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../common/request_state.dart';

class LoginRequestState extends RequestState<LoginData> {
  LoginRequestState({super.isLoading, super.data, super.isError, super.isEmpty});

  @override
  LoginRequestState copyWith({bool? isLoading, LoginData? data, bool? isError, bool? isEmpty}) {
    return LoginRequestState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      isError: isError ?? this.isError,
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }
}

class LoginData {
  final String? qrCode;
  final bool? qrIsExpired;

  LoginData({this.qrCode, this.qrIsExpired});

  LoginData copyWith({String? qrCode, bool? qrIsExpired}) {
    return LoginData(qrCode: qrCode ?? this.qrCode, qrIsExpired: qrIsExpired ?? this.qrIsExpired);
  }
}

// 定义 StateNotifier
class LoginRequestNotifier extends StateNotifier<LoginRequestState> {
  Timer? _timer;

  LoginRequestNotifier() : super(LoginRequestState()) {
    _fetchData();
  }

  // 刷新数据
  refresh({bool showLoading = false}) async {
    await _fetchData(showLoading: showLoading, refresh: true);
    return true;
  }

  // 启动定时器，每 3 秒检查一次登录状态
  startTimer() {
    stopTimer();
    _timer = Timer.periodic(const Duration(seconds: 3), (value) {
      checkLogin();
    });
  }

  // 停止定时器
  stopTimer() {
    _timer?.cancel();
  }

  // 检查二维码登录状态
  checkLogin() async {
    final qrCode = state.data?.qrCode;
    if (qrCode?.isNotEmpty ?? false) {
      final checkLogin = await BujuanMusicManager().checkQrCode(key: qrCode!);
      // _handleLoginCheckResponse(checkLogin);
    }
  }

  // 根据返回的登录状态处理逻辑
  _handleLoginCheckResponse(QrCheckEntity? checkLogin) {
    // 如果 checkLogin 为 null 或 code 为 0，直接返回
    if (checkLogin == null || checkLogin.code == 0) return;

    // 根据不同的状态码执行相应的操作
    switch (checkLogin.code) {
      case 800: // 二维码已过期
        state = state.copyWith(data: state.data?.copyWith(qrIsExpired: true));
        stopTimer();
        break;
      case 803: // 扫码成功，获取用户信息
        stopTimer();
        BujuanMusicManager().userInfo();
        break;
      default:
        // 如果有其他未知的状态码，暂时不做任何处理
        break;
    }
  }

  // 登录手机号（具体实现可根据需要填充）
  loginCellPhone() async {}

  // 获取二维码信息并更新状态
  Future<void> _fetchData({bool showLoading = true, bool refresh = false}) async {
    if (showLoading) {
      state = state.copyWith(isLoading: true);
    }

    final qrKey = await BujuanMusicManager().qrCodeKey();
    if (qrKey?.unikey?.isNotEmpty ?? false) {
      state = state.copyWith(
        isLoading: false,
        data: LoginData(qrCode: qrKey!.unikey, qrIsExpired: false),
        isError: false,
      );
      // startTimer();
    } else {
      state = state.copyWith(isLoading: false, isError: true);
    }
  }
}

// 创建 StateNotifierProvider
final loginProvider =
    StateNotifierProvider.autoDispose<LoginRequestNotifier, LoginRequestState>((ref) {
  final loginRequestNotifier = LoginRequestNotifier();

  // 当页面销毁时停止定时器
  ref.onDispose(() {
    if (kDebugMode) {
      print('首页页面Provider被销毁了========');
    }
    loginRequestNotifier.stopTimer();
  });

  return loginRequestNotifier;
});
