import 'package:bujuan_music/common/values/app_config.dart';
import 'package:bujuan_music/common/values/app_images.dart';
import 'package:bujuan_music/router/app_router.dart';
import 'package:bujuan_music_api/bujuan_music_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons_pro/hugeicons.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:pinput/pinput.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneController = TextEditingController();
  final defaultPinTheme = PinTheme(
    width: 56.w,
    height: 56.w,
    textStyle: TextStyle(
        fontSize: 18.sp, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20.w),
    ),
  );

  bool _isSendingCode = false;
  bool _isLoggingIn = false;
  String? _lastSentPhone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
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
                  color: Colors.grey.withAlpha(15), borderRadius: BorderRadius.circular(30.w)),
              child: TextField(
                controller: phoneController,
                cursorColor: Color(0XFF1ED760),
                style: TextStyle(fontSize: 18.sp),
                decoration: InputDecoration(
                    hintText: 'Please input phone number',
                    hintStyle: TextStyle(fontSize: 18.sp),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.w)),
              ),
            ),
            SizedBox(height: 30.w),
            ElevatedButton(
              onPressed: _isSendingCode ? null : () => showCodeDialog(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0XFF1ED760),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 13.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.w),
                ),
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: _isSendingCode
                  ? SizedBox(
                      width: 20.w,
                      height: 20.w,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text('Get an SMS QR code'),
            ),
            SizedBox(height: 60.w),
            // 二维码登录行，暂时不可点击并提示未实现
            Tooltip(
              message: 'QR code login not implemented yet',
              child: Opacity(
                opacity: 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(HugeIconsSolid.qrCode),
                    SizedBox(width: 10.w),
                    Text(
                      'QR code login (coming soon)',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCodeDialog() async {
    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter phone number')),
      );
      return;
    }

    if (_lastSentPhone == phoneController.text) {
      _showCodeInputDialog();
      return;
    }

    setState(() {
      _isSendingCode = true;
    });

    try {
      var boolEntity = await BujuanMusicManager().sendSmsCode(phone: phoneController.text);
      if (boolEntity != null && boolEntity.code == 200) {
        _lastSentPhone = phoneController.text;
        _showCodeInputDialog();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send code')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSendingCode = false;
        });
      }
    }
  }

  void _showCodeInputDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text('Verification', style: TextStyle(fontSize: 22.sp))),
          content: Container(
            width: double.maxFinite,
            constraints: BoxConstraints(maxWidth: 400.w), // 限制最大宽度
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Enter the code sent to the number', style: TextStyle(fontSize: 16.sp)),
                  SizedBox(height: 30.w),
                  Text(phoneController.text,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 30.w),
                  Pinput(
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (v) {
                      // 关闭对话框并执行登录
                      Navigator.of(context).pop(); // 关闭当前对话框
                      goToHome(v);
                    },
                  ),
                  SizedBox(height: 30.w),
                  Text(
                    "Didn't receive code?",
                    style: TextStyle(color: Color(0XFF1ED760)),
                  ),
                  GestureDetector(
                    onTap: () {
                      // 关闭当前对话框，重新发送验证码
                      Navigator.of(context).pop();
                      _resendCode();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.w),
                      child: Text('Resend',
                          style: TextStyle(
                            color: Color(0XFF1ED760),
                            decoration: TextDecoration.underline,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _resendCode() async {
    setState(() {
      _isSendingCode = true;
    });
    try {
      var boolEntity = await BujuanMusicManager().sendSmsCode(phone: phoneController.text);
      if (boolEntity != null && boolEntity.code == 200) {
        _showCodeInputDialog(); // 重新打开输入对话框
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to resend code')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isSendingCode = false;
        });
      }
    }
  }

  void goToHome(String code) async {
    if (_isLoggingIn) return;
    setState(() {
      _isLoggingIn = true;
    });

    try {
      var loginEntity = await BujuanMusicManager().loginCellPhone(
        phone: phoneController.text,
        captcha: code,
      );
      if (loginEntity != null && loginEntity.code == 200) {
        var userInfo = await BujuanMusicManager().userInfo();
        if (userInfo != null && userInfo.profile != null) {
          setValue(AppConfig.userInfoKey, userInfo.profile?.toJson());
          phoneController.text = '';
          if (mounted) {
            // 关闭所有弹窗并跳转
            Navigator.popUntil(context, (route) => route.isFirst);
            context.replace(AppRouter.home);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to get user info')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed: ${loginEntity?.message ?? 'unknown error'}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoggingIn = false;
        });
      }
    }
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}