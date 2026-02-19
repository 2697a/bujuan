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
              onPressed: _isSendingCode ? null : () => showCodeBottomSheet(),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(HugeIconsSolid.qrCode),
                SizedBox(width: 10.w),
                Text(
                  'QR code login',
                  style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void showCodeBottomSheet() async {
    if (phoneController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter phone number')),
      );
      return;
    }

    if (_lastSentPhone == phoneController.text) {
      _showCodeInputSheet();
      return;
    }

    setState(() {
      _isSendingCode = true;
    });

    try {
      var boolEntity = await BujuanMusicManager().sendSmsCode(phone: phoneController.text);
      if (boolEntity != null && boolEntity.code == 200) {
        _lastSentPhone = phoneController.text;
        _showCodeInputSheet();
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
      builder: (BuildContext context) {
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
                  Text('Enter the code sent to the number', style: TextStyle(fontSize: 16.sp)),
                  SizedBox(height: 30.w),
                  Text(phoneController.text,
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  SizedBox(height: 60.w),
                  Pinput(
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    onCompleted: (v) {
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
                      Navigator.pop(context);
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
        _showCodeInputSheet();
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
            Navigator.popUntil(context, (route) => route.isFirst);
            context.replace(AppRouter.home);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to get user info')),
          );
        }
      } else {
        // 修复：LoginEntity 可能没有 message 字段，使用固定错误信息
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed, please check your code and try again.')),
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