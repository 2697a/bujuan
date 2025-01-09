import 'package:bujuan/common/request_state.dart';
import 'package:bujuan/common/values/icons.dart';
import 'package:bujuan/pages/login/provider.dart';
import 'package:bujuan_music_api/common/music_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rive/rive.dart' as rive;
import 'package:qr_flutter/qr_flutter.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BaseRequestWidget<LoginData>(
          requestState: ref.watch(loginProvider),
          childBuilder: (LoginData data) => LoginDesktop(loginData: data)),
    );
  }
}

class LoginDesktop extends StatelessWidget {
  final LoginData loginData;

  const LoginDesktop({super.key, required this.loginData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xFF6C63FF).withOpacity(.3), Colors.white.withOpacity(.4)])),
      height: MediaQuery.of(context).size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Wrap(
                      direction: Axis.vertical,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          'BuJuan',
                          style: TextStyle(
                              fontSize: 34.sp,
                              color: const Color(0xFF6C63FF),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 15.h),
                        RichText(
                            text: TextSpan(
                              text: '音符悠然响',
                              children: const [
                                TextSpan(text: '  请君倾耳听', style: TextStyle(color: Color(0xFF6C63FF)))
                              ],
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  color: Colors.black.withOpacity(.6),
                                  fontWeight: FontWeight.w500),
                            )),
                        SizedBox(height: 65.h),
                        SizedBox(
                          width: 380.w,
                          height: 380.w,
                          child: const rive.RiveAnimation.asset(
                            AppIcons.loginIcon,
                            fit: BoxFit.cover,
                            controllers: [

                            ],
                            animations: ['Hair Wind', 'Idle', 'Blink'],
                          ),
                        ),
                      ],
                    ),
                    Card(
                      elevation: 0,
                      color: Colors.white.withOpacity(.3),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
                      shadowColor: Colors.black.withOpacity(.2),
                      borderOnForeground: false,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 30.h),
                        width: 360.w,
                        child: Wrap(
                          direction: Axis.vertical,
                          runAlignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            RichText(
                                text: TextSpan(
                                    text: '请使用',
                                    style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black.withOpacity(.6)),
                                    children: const [
                                  TextSpan(
                                      text: ' APP ', style: TextStyle(color: Color(0xFF6C63FF))),
                                  TextSpan(text: '扫码登录')
                                ])),
                            SizedBox(height: 25.h),
                            Consumer(builder: (context, ref, child) {
                              return Stack(
                                children: [
                                  QrImageView(
                                      data: BujuanMusicManager().qrCode(key: loginData.qrCode!),
                                      size: 210.w,
                                      padding: EdgeInsets.all(12.w),
                                      backgroundColor: Colors.white),
                                  Visibility(
                                    visible: ref.watch(loginProvider).data?.qrIsExpired ?? false,
                                    child: GestureDetector(
                                      child: Container(
                                        alignment: Alignment.center,
                                        width: 210.w,
                                        height: 210.w,
                                        color: Colors.grey.withOpacity(.8),
                                        child: const Text(
                                          '已过期',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      onTap: () {
                                        ref.read(loginProvider.notifier).refresh();
                                      },
                                    ),
                                  )
                                ],
                              );
                            }),
                            SizedBox(height: 25.h),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.r))),
                              onPressed: () {},
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.phone_android_sharp,
                                    size: 20.sp,
                                  ),
                                  Text(
                                    ' 手机号登录',
                                    style: TextStyle(fontSize: 14.sp),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ])
            ],
          )
        ],
      ),
    );
  }
}
