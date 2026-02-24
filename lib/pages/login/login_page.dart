import 'dart:async';
import 'package:bujuan_music/common/values/app_config.dart';
import 'package:bujuan_music/common/values/app_images.dart';
import 'package:bujuan_music/router/app_router.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';
import 'package:qr_flutter/qr_flutter.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _phoneController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56.w,
    height: 56.w,
    textStyle: TextStyle(
        fontSize: 18.sp, color: const Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20.w),
    ),
  );

  bool _isSendingCode = false;
  bool _isLoggingIn = false;
  bool _isCookieLoggingIn = false;
  String? _lastSentPhone;

  bool _isQrMode = false;
  String? _qrKey;
  String? _qrUrl;
  Timer? _qrTimer;
  bool _isQrLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _qrTimer?.cancel();
    super.dispose();
  }

  void _showTopSnackBar(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10,
          left: 10,
          right: 10,
        ),
        duration: const Duration(seconds: 5),
      ),
    );
  }

  // ---------- 手机号登录部分 ----------
  Future<void> _sendCode() async {
    if (_phoneController.text.isEmpty) {
      _showTopSnackBar('Please enter phone number');
      return;
    }
    setState(() => _isSendingCode = true);
    try {
      final result = await BujuanMusicManager()
          .sendSmsCode(phone: _phoneController.text);
      if (result?.code == 200) {
        _lastSentPhone = _phoneController.text;
        _showCodeInputSheet();
      } else {
        _showTopSnackBar('Failed to send code');
      }
    } catch (e) {
      _showTopSnackBar('Error: $e');
    } finally {
      if (mounted) setState(() => _isSendingCode = false);
    }
  }

  void _showCodeInputSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.w),
          topRight: Radius.circular(20.w),
        ),
      ),
      builder: (context) {
        return Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 30.w),
                  Text('Verification',
                      style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 30.w),
                  Text('Enter the code sent to the number',
                      style: TextStyle(fontSize: 16.sp)),
                  SizedBox(height: 30.w),
                  Text(_phoneController.text,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 60.w),
                  Pinput(
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (code) => _loginWithCode(code),
                  ),
                  SizedBox(height: 30.w),
                  Text("Didn't receive code?",
                      style: const TextStyle(color: Color(0XFF1ED760))),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _resendCode();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text('Resend',
                          style: const TextStyle(
                            color: Color(0XFF1ED760),
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _resendCode() async {
    setState(() => _isSendingCode = true);
    try {
      final result = await BujuanMusicManager()
          .sendSmsCode(phone: _phoneController.text);
      if (result?.code == 200) {
        _showCodeInputSheet();
      } else {
        _showTopSnackBar('Failed to resend code');
      }
    } catch (e) {
      _showTopSnackBar('Error: $e');
    } finally {
      if (mounted) setState(() => _isSendingCode = false);
    }
  }

  Future<void> _loginWithCode(String code) async {
    if (_isLoggingIn) return;
    setState(() => _isLoggingIn = true);
    try {
      final loginEntity = await BujuanMusicManager().loginCellPhone(
        phone: _phoneController.text,
        captcha: code,
      );
      if (loginEntity != null && loginEntity.code == 200) {
        final userInfo = await BujuanMusicManager().userInfo();
        if (userInfo?.profile != null) {
          await setValue(AppConfig.userInfoKey, userInfo!.profile!.toJson());
          if (mounted) {
            Navigator.popUntil(context, (route) => route.isFirst);
            context.replace(AppRouter.home);
          }
        } else {
          _showTopSnackBar('Failed to get user info');
        }
      } else {
        final errorMsg = loginEntity?.message ?? 'Login failed (code: ${loginEntity?.code})';
        _showTopSnackBar(errorMsg);
      }
    } catch (e) {
      _showTopSnackBar('Login error: $e');
    } finally {
      if (mounted) setState(() => _isLoggingIn = false);
    }
  }

  // ---------- 二维码登录部分 ----------
  Future<void> _startQrLogin() async {
    setState(() {
      _isQrMode = true;
      _isQrLoading = true;
      _qrKey = null;
      _qrUrl = null;
    });
    _qrTimer?.cancel();

    try {
      final keyEntity = await BujuanMusicManager().qrCodeKey();
      if (keyEntity?.unikey == null) {
        _showTopSnackBar('Failed to get QR key');
        setState(() => _isQrLoading = false);
        return;
      }
      final key = keyEntity!.unikey!;
      final qrUrl = BujuanMusicManager().qrCode(key: key);

      setState(() {
        _qrKey = key;
        _qrUrl = qrUrl;
        _isQrLoading = false;
      });

      _qrTimer = Timer.periodic(const Duration(seconds: 2), (timer) async {
        if (_qrKey == null) return;
        try {
          final result = await BujuanMusicManager().qrCodeLogin(key: _qrKey!);
          if (result == null) return;

          switch (result.code) {
            case 800:
              _showTopSnackBar('QR code expired, please refresh');
              timer.cancel();
              setState(() {
                _isQrMode = false;
                _qrKey = null;
              });
              break;
            case 801:
            case 802:
              // waiting
              break;
            case 803:
              timer.cancel();
              if (result.cookie != null && result.cookie!.isNotEmpty) {
                // 关键修复：添加 await 确保 cookie 保存完成
                await BujuanMusicManager().addCookie(result.cookie!);
                try {
                  final userInfo = await BujuanMusicManager().userInfo();
                  if (userInfo?.profile != null) {
                    await setValue(AppConfig.userInfoKey, userInfo!.profile!.toJson());
                    if (mounted) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      context.replace(AppRouter.home);
                    }
                  } else {
                    _showTopSnackBar('Failed to get user info with this cookie');
                    await BujuanMusicManager().clearCookies(); // 添加 await
                  }
                } catch (e) {
                  _showTopSnackBar('Error fetching user info: $e');
                  await BujuanMusicManager().clearCookies(); // 添加 await
                }
              } else {
                _showTopSnackBar('No cookie received, please try manual input');
              }
              break;
            default:
              if (result.message != null) {
                _showTopSnackBar(result.message!);
              }
          }
        } catch (e) {
          print('QR check error: $e');
        }
      });
    } catch (e) {
      _showTopSnackBar('QR login error: $e');
      setState(() => _isQrLoading = false);
    }
  }

  void _cancelQrLogin() {
    _qrTimer?.cancel();
    setState(() {
      _isQrMode = false;
      _qrKey = null;
      _qrUrl = null;
    });
  }

  // ---------- Cookie 登录部分 ----------
  Future<void> _showCookieDialog() async {
    final TextEditingController _cookieController = TextEditingController();
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Cookie Login'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tip: Scan the QR code in your browser (for mobile, \'Via\' is recommended), '
                  'then copy the correct cookie from your browser.',
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 16.w),
                TextField(
                  controller: _cookieController,
                  cursorColor: const Color(0XFF1ED760), // 设置光标为绿色
                  decoration: InputDecoration(
                    hintText: 'Paste your cookie here',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.w),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.w),
                      borderSide: const BorderSide(color: Color(0XFF1ED760), width: 2),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.w),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                  maxLines: 3,
                  minLines: 1,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: _isCookieLoggingIn
                  ? null
                  : () async {
                      final cookie = _cookieController.text.trim();
                      if (cookie.isEmpty) {
                        _showTopSnackBar('Please paste a cookie');
                        return;
                      }
                      Navigator.pop(context); // 关闭对话框
                      await _loginWithCookie(cookie);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0XFF1ED760),
                foregroundColor: Colors.white,
              ),
              child: _isCookieLoggingIn
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    )
                  : const Text('Login'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _loginWithCookie(String cookie) async {
    if (_isCookieLoggingIn) return;
    setState(() => _isCookieLoggingIn = true);
    try {
      // 关键修复：添加 await
      await BujuanMusicManager().addCookie(cookie);
      final userInfo = await BujuanMusicManager().userInfo();
      if (userInfo?.profile != null) {
        await setValue(AppConfig.userInfoKey, userInfo!.profile!.toJson());
        if (mounted) {
          Navigator.popUntil(context, (route) => route.isFirst);
          context.replace(AppRouter.home);
        }
      } else {
        _showTopSnackBar('Invalid cookie or login failed');
        await BujuanMusicManager().clearCookies(); // 添加 await
      }
    } catch (e) {
      _showTopSnackBar('Login error: $e');
      await BujuanMusicManager().clearCookies(); // 添加 await
    } finally {
      if (mounted) setState(() => _isCookieLoggingIn = false);
    }
  }

  // ---------- UI 构建 ----------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _isQrMode
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: _cancelQrLogin,
              )
            : null,
      ),
      body: _isQrMode ? _buildQrPanel() : _buildPhonePanel(),
    );
  }

  Widget _buildPhonePanel() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.asset(AppImages.logo, width: 120.w, height: 120.w),
          SizedBox(height: 20.w),
          Text(
            'Bujuan Music',
            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 60.w),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w),
            padding: EdgeInsets.symmetric(vertical: 2.w),
            decoration: BoxDecoration(
                color: Colors.grey.withAlpha(15),
                borderRadius: BorderRadius.circular(30.w)),
            child: TextField(
              controller: _phoneController,
              cursorColor: const Color(0XFF1ED760),
              style: TextStyle(fontSize: 18.sp),
              decoration: InputDecoration(
                hintText: 'Please input phone number',
                hintStyle: TextStyle(fontSize: 18.sp),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w),
              ),
            ),
          ),
          SizedBox(height: 30.w),
          ElevatedButton(
            onPressed: _isSendingCode ? null : _sendCode,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0XFF1ED760),
              foregroundColor: Colors.white,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.w),
              ),
              textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            child: _isSendingCode
                ? SizedBox(
                    width: 20.w,
                    height: 20.w,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('Get an SMS QR code'),
          ),
          SizedBox(height: 30.w),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(HugeIconsSolid.qrCode, size: 24.w),
                onPressed: _startQrLogin,
              ),
              SizedBox(width: 10.w),
              Text(
                'QR code login',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(height: 20.w),
          TextButton(
            onPressed: _showCookieDialog,
            child: const Text(
              'Cookie Login',
              style: TextStyle(color: Color(0XFF1ED760)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQrPanel() {
    return Center(
      child: _isQrLoading
          ? const CircularProgressIndicator()
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_qrUrl != null)
                  QrImageView(
                    data: _qrUrl!,
                    version: QrVersions.auto,
                    size: 250.w,
                    backgroundColor: Colors.white,
                  ),
                SizedBox(height: 30.w),
                const Text('Scan with your phone'),
                SizedBox(height: 10.w),
                TextButton(
                  onPressed: _startQrLogin,
                  child: const Text('Refresh QR code'),
                ),
                SizedBox(height: 20.w),
                TextButton(
                  onPressed: _showCookieDialog,
                  child: const Text(
                    'Already scanned? Enter cookie manually',
                    style: TextStyle(color: Color(0XFF1ED760), fontSize: 14),
                  ),
                ),
              ],
            ),
    );
  }
}