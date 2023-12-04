import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../routes/app_pages.dart';
import '../../utils/custom_button.dart';
import '../../utils_res/color_helper.dart';
import '../../utils_res/font_family.dart';
import 'login_page_controller.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  LoginPageController pageController = Get.put(LoginPageController());
  int _currentIndex = 1;
  late AnimationController _controller;
  late Animation<int> _animation;
  List<Widget> _images = [];
  Timer? animationTimer = null;

  @override
  void dispose() {
    try {
      if (animationTimer != null) {
        animationTimer?.cancel();
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }

    try {
      if (_controller != null) {
        _controller.dispose();
      }
    } catch (e) {
      if (kDebugMode) print(e);
    }

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 15))
          ..repeat();
    _animation = IntTween(begin: 0, end: 116).animate(_controller);
    for (int i = 1; i < 13; i++) {
      _images.add(
        FractionallySizedBox(
          heightFactor: 1,
          child: Image.asset(
            'assets/n_assets/welcome-page-avatars/$i.png',
            width: Get.width,
            fit: BoxFit.cover,
            // alignment: Alignment.center,
          ),
        ),
      );
    }

    Timer.periodic(const Duration(milliseconds: 500), (Timer timer) {
      animationTimer = timer;
      setState(() {
        _currentIndex = ((_currentIndex + 1) % 12);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgWhiteColor,
      body: GetBuilder<LoginPageController>(
        builder: (logic) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.center,
                end: Alignment.topCenter,
                colors: [
                  Color.fromRGBO(242, 242, 242, 0),
                  Color.fromRGBO(230, 156, 20, 0.29)
                ],
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    // width: Get.width,
                    // height: Get.height,
                    child: Image.asset("assets/logo_biograph_green.png"),
                  ),
                ),
                // Align(
                //   alignment: Alignment.topCenter,
                //   child: Padding(
                //     padding: EdgeInsets.only(top: 60.h),
                //     child: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         ColorFiltered(
                //             colorFilter: const ColorFilter.mode(
                //               primaryBlackColor,
                //               BlendMode.modulate,
                //             ),
                //             child: Image.asset(
                //               'assets/logo.png',
                //               height: 28.h,
                //             )),
                //         SizedBox(width: 8.w),
                //         Text(
                //           'fitmint',
                //           style: TextStyle(
                //               fontSize: 28.sp,
                //               fontFamily: FontFamily.MONO_SANS_EBW),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: AnimatedContainer(
                //     curve: Curves.easeIn,
                //     duration: const Duration(milliseconds: 100),
                //     child: _images[_currentIndex],
                //   ),
                // ),
                Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Wrap(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: bgWhiteColor,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20.r),
                            topLeft: Radius.circular(20.r),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 4),
                              blurRadius: 18,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24.0, vertical: 32.0),
                          child: Column(
                            children: [
                              Text(
                                'Login / Signup',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  height: 1.5,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: FontFamily.MONO_SANS_EBW,
                                ),
                              ),

                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                'Trusted by 1M+ peoples across India',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: primaryBlackColor.withOpacity(0.7),
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.ROBOTO,
                                ),
                              ),
                              SizedBox(
                                height: 42.h,
                              ),

                              const Text(
                                'Enter Your Phone Number',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: FontFamily.ROBOTO,
                                ),
                              ),

                              CustomButtons.onBoardingButtons(
                                label: 'CONTINUE WITH GOOGLE',
                                imgPath: 'assets/ic_google.svg',
                                color: const Color(0xFF333333),
                                textColor: primaryWhiteColor,
                                onPressed: () {
                                  pageController.signInWithGoogle();
                                },
                              ),
                              // if (Platform.isIOS)
                              //   SizedBox(
                              //     height: 16.h,
                              //   ),
                              // if (Platform.isIOS)
                              //   CustomButtons.onBoardingButtons(
                              //     label: 'CONTINUE WITH APPLE',
                              //     imgPath: 'assets/ic_apple_logo.svg',
                              //     color: primaryWhiteColor,
                              //     textColor: const Color(0xFF111111),
                              //     onPressed: () {
                              //       pageController.signInWithApple();
                              //     },
                              //   ),
                              SizedBox(
                                height: 16.h,
                              ),

                              // CustomButtons.onBoardingButtons(
                              //   label: 'CONTINUE WITH EMAIL',
                              //   imgPath:
                              //       'assets/n_assets/ic_white_email.svg',
                              //   color: primaryWhiteColor,
                              //   textColor: const Color(0xFF111111),
                              //   onPressed: () {
                              //     Get.toNamed(
                              //       Routes.emailPage,
                              //     );
                              //   },
                              // ),
                              SizedBox(
                                height: 24.h,
                              ),
                              InkWell(
                                onTap: () {
                                  _openPrivacyPage();
                                },
                                child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'By continuing, you agree to our ',
                                        style: TextStyle(
                                          color: primaryBlackColor
                                              .withOpacity(0.7),
                                          fontSize: 14.sp,
                                          fontFamily: FontFamily.INTER,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Privacy Policy',
                                        style: TextStyle(
                                          color: categoryColor,
                                          fontSize: 14.sp,
                                          fontFamily: FontFamily.INTER,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _openPrivacyPage() async {
    String url = "https://biograph.io/privacy";
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
