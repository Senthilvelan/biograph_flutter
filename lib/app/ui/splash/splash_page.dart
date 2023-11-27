import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils_res/color_helper.dart';
import '../../utils_res/font_helper.dart';
import '../../utils_res/string_helper.dart';
import 'splash_conroller.dart';


class SplashPage extends StatelessWidget {
  SplashController splashController = Get.put(SplashController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: White,
        body: Container(
          child: Stack(
            children: [
              InkWell(
                onTap: () async {
                  // if(await StringHelper().getPreferenceSplash() == null){
                  //   Get.offAndToNamed(Routes.introScreen);
                  // } else {
                  //   Get.offAndToNamed(Routes.mobileNumberPage);
                  // }
                },
                child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/mobile_logo.png",
                            width: 174,
                            height: 204,
                          ),
                          SizedBox(height: 80),
                          StringHelper.getNotoSansText("Convenience. Care. Clarity", fontSize: SplashPageLabelSize,color: Color.fromRGBO(109, 109, 109, 1),font: FontWeight.w600,maxLines: 1,alignment: TextAlign.center)
                        ],
                      ),
                    ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
