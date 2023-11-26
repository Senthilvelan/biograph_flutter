
import 'package:biograph/app/utils/sizer.dart';
import 'package:biograph/app/utils_res/string_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../utils_res/color_helper.dart';


final List<Map<String,dynamic>> imgList = [
  {"image":"assets/w1.svg","label" : "Conveniently book lab tests\nand doctor consultation"},
  {"image":"assets/w2.svg","label" : "Professional at-home \nhealth care"},
  {"image":"assets/w3.svg","label" : "Clarity on all your health related concerns"},
];
// final List<Map<String,dynamic>> imgList = [
//   {"image":"assets/w1.png","label" : "One click away from \nall your COVID needs"},
//   {"image":"assets/w2.png","label" : "Request for appointments\n& speak to our doctors"},
//   {"image":"assets/w3.png","label" : "All your health \nrecords in one place"},
// ];
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _current = 0;

  final PageController _controller = PageController();

  final List<Widget> imageSliders = imgList
      .map((item) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StringHelper.getNotoSansText(item['label'], fontSize: IntroHeadingSize,color: Black,font: FontWeight.w500,maxLines: 2,alignment: TextAlign.center),
          SvgPicture.asset(item['image'],fit: BoxFit.contain, height: 250,),
        ],
      ))
  // Image.asset(item['image'], fit: BoxFit.cover,),
  // SvgPicture.asset(item['image'],fit: BoxFit.contain)
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(2.5.h),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _current == 1 || _current == 2 ? InkWell(
                      child: const Icon(Icons.arrow_back, size: 21,color: backArrawColor),
                      onTap: () {
                        _controller.animateToPage(_current - 1, duration: const Duration(milliseconds: 400),curve: Curves.easeIn);
                        setState(() {
                          _current = _current - 1;
                        });
                      },
                    ) : Container(),
                    _current == 0 || _current == 1 ? InkWell(
                      child: StringHelper.getNotoSansText("SKIP", fontSize: IntroSkipSize,color: skipColor),
                      onTap: () {
                        StringHelper().setPreferenceSplash(false);
                        Get.offAndToNamed(Routes.mobileNumberPage);
                      },
                    ) : Container(),
                  ],
                ),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (value) {
                      setState(() {
                        _current = value;
                      });
                    },
                    children: imageSliders,
                  ),
                ),
                SizedBox(height: 2.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imgList.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key, duration: const Duration(milliseconds: 400),curve: Curves.easeIn),
                      child: Container(
                        width: 3.w,
                        height: 3.w,
                        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == entry.key ? blueColor : introDotColor
                        ),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: 2.h,),
                InkWell(
                  onTap: () {
                    if(_current == 2){
                      StringHelper().setPreferenceSplash(false);
                      Get.offAndToNamed(Routes.mobileNumberPage);
                    }
                    _controller.animateToPage(_current + 1, duration: const Duration(milliseconds: 400),curve: Curves.easeIn);
                  },
                  child: Container(
                      height: 7.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            stops: [0.4,1.0],
                            colors: [startGradientColor, endGradientColor]
                        ),
                      ),
                      child: Center(child: StringHelper.getNotoSansText(_current == 2 ? "Login":"Next", fontSize: IntroLoginSize,font: FontWeight.w400,color: White),)
                  ),
                ),
              ]
          ),
        ),
      ),
    );
  }
}
