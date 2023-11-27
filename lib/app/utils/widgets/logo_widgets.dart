import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils_res/color_helper.dart';

class LogoWidgets {
  static logoWhiteBg(logoRadius) {
    return Container(
      height: logoRadius,
      width: logoRadius,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: mainGradient,
      ),
      child: Padding(
        padding: EdgeInsets.all(2.w),
        child: SizedBox(
          child: CircleAvatar(
            backgroundColor: White,
            radius: logoRadius / 2,
            child: Container(
              padding: EdgeInsets.all(2.w),
              child: Image.asset(
                'assets/logo.png',
                fit: BoxFit.fitHeight,
                height: logoRadius - 4.h,
                width: logoRadius - 4.h,
              ),
            ),
          ),
        ),
      ),
    );
  }

  static logoBlackBg(logoRadius) {
    return Container(
      height: logoRadius,
      width: logoRadius,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: mainGradient,
      ),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SizedBox(
          child: CircleAvatar(
            backgroundColor: Black,
            radius: logoRadius,
            child: Image.asset(
              'assets/logo.png',
              height: 36.h,
              width: 40.w,
            ),
          ),
        ),
      ),
    );
  }
}
