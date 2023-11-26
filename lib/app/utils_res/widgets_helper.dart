import 'dart:io';

import 'package:biograph/app/utils/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../app.dart';
import 'color_helper.dart';
import 'styles_helper.dart';

class WidgetsHelper {
  static featuresItem(label, image, textColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 2.h),
          child: Image.asset(
            image,
            width: 24.w,
            height: 24.h,
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: textColor,
              fontSize: 16.sp,
              height: 1.5,
              fontFamily: FontFamily.INTER,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  static comingsoonBadge(double textSize) {
    return Container(
      margin: EdgeInsets.only(left: 4.w),
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0x4D375767),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Text(
        "coming soon",
        style: TextStyle(
          color: Color(0xff6FAFCF),
          fontFamily: FontFamily.INTER,
          fontWeight: FontWeight.w600,
          fontStyle: FontStyle.italic,
          fontSize: textSize,
        ),
      ),
    );
  }

  static itemPointsText({@required text}) {
    return Row(
      children: [
        Image.asset(
          'assets/ic_star_point.png',
          height: 24.h,
          width: 24.w,
          fit: BoxFit.contain,
        ),
        SizedBox(
          width: 8.w,
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: activeColor,
              fontFamily: FontFamily.INTER,
              fontWeight: FontWeight.w400,
              height: 1.5,
              fontSize: 16.sp,
            ),
          ),
        ),
      ],
    );
  }

  static itemInfoCard(label, imgLabel) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,
          width: 1.0,
          style: BorderStyle.solid,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
      padding: EdgeInsets.all(8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            imgLabel,
            height: 60.h,
            width: 60.w,
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: 16.w,
          ),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: primaryBlackColor,
                fontFamily: FontFamily.INTER,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

// static goBackCrafting(BuildContext context) async {
//   // WidgetsFlutterBinding.ensureInitialized();
//
//   App.setLandscape = false;
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   // App.setLandscape = false;
//   await Future.delayed(const Duration(milliseconds: 50));
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]).then((value) {
//     Get.offNamed(
//       Routes.craftingLoadingPage1,
//     );
//     // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//     //         overlays: SystemUiOverlay.values)
//     //     .then((value) {
//     //   Future.delayed(const Duration(milliseconds: 1200), () {
//     //     Get.back();
//     //     Future.delayed(const Duration(milliseconds: 100), () {
//     //       Get.back();
//     //     });
//     //   });
//     // });
//
//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.portraitUp,
//       DeviceOrientation.portraitDown,
//     ]).then((value) {
//       Future.delayed(const Duration(milliseconds: 1800), () {
//         SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//                 overlays: SystemUiOverlay.values)
//             .then((value) {
//           Future.delayed(const Duration(milliseconds: 100), () {
//             Get.back();
//             // Navigator.popAndPushNamed(context, "/home");
//
//             // Get.offNamed(
//             //   Routes.craftingLoadingPostPage,
//             // );
//           });
//         });
//       });
//     });
//   });
// }
}
