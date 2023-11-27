// import 'package:fitmint_flutter/app/utils/color_helper.dart';
// import 'package:fitmint_flutter/app/utils/font_family.dart';
// import 'package:fitmint_flutter/app/utils/shimmer_animation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
//
// class CustomButtons {
//   /*
//       NEW BUTTONS
//    */
//
//   /*
//       End BUTTONS
//    */
//
//   static simmerBox(height, width) {
//     return Shimmer.fromColors(
//       baseColor: Color(0xff1D2834),
//       highlightColor: Color(0xff253241),
//       enabled: true,
//       child: Container(
//         width: width,
//         height: height,
//         decoration: BoxDecoration(
//           color: Color(0xff253241),
//           borderRadius: const BorderRadius.all(
//             Radius.circular(24.0),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static pairButtons(pLabel, dLabel, {onMainPressed, onDefaultPressed}) {
//     return SizedBox(
//       width: Get.width,
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onMainPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withAlpha(125),
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 0),
//                   )
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   pLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           InkWell(
//             onTap: onDefaultPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF2A3541),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   dLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static pairButtonsWithBg(pLabel, dLabel, {onMainPressed, onDefaultPressed}) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onMainPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: BoxDecoration(
//                 color: primaryColor,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.blue.withAlpha(125),
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 0),
//                   )
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   pLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           InkWell(
//             onTap: onDefaultPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF2A3541),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   dLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static pairButtonsDanger(pLabel, dLabel, {onMainPressed, onDefaultPressed}) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onMainPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: BoxDecoration(
//                 color: logoutButtonColor,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.red.withAlpha(125),
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 0),
//                   )
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   pLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           InkWell(
//             onTap: onDefaultPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF2A3541),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   dLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static pairButtonsPrimaryLoading(String dLabel, bool danger) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           loaderButton(danger),
//           SizedBox(height: 20.h),
//           InkWell(
//             // onTap: onDefaultPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF2A3541),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   dLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static darkButton({@required label, @required onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         width: Get.width,
//         height: 54.w,
//         decoration: const BoxDecoration(
//           color: Color(0xFF2A3541),
//           borderRadius: BorderRadius.all(
//             Radius.circular(
//               8.0,
//             ),
//           ),
//         ),
//         child: Center(
//           child: Text(
//             label,
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 14.sp,
//               fontFamily: FontFamily.NEUE,
//               fontWeight: FontWeight.w700,
//               color: White,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static pairButtonsStates(pLabel, dLabel, isMainActive,
//       {onMainPressed, onDefaultPressed}) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: Column(
//         children: [
//           InkWell(
//             onTap: onMainPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: BoxDecoration(
//                 color: isMainActive.value ? primaryColor : primaryDisabledColor,
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//                 boxShadow: [
//                   if (isMainActive.value)
//                     BoxShadow(
//                       color: Colors.blue.withAlpha(125),
//                       blurRadius: 6,
//                       spreadRadius: 2,
//                       offset: const Offset(0, 0),
//                     )
//                 ],
//               ),
//               child: Center(
//                 child: Text(
//                   pLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: isMainActive.value ? White : Colors.white54,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 20.h),
//           InkWell(
//             onTap: onDefaultPressed,
//             child: Container(
//               width: Get.width,
//               height: 54.w,
//               decoration: const BoxDecoration(
//                 color: Color(0xFF2A3541),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   dLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static pairButtonsHorizontalWithFlag(pLabel, dLabel, linkVisible,
//       {onClosePressed, onLinkPressed}) {
//     return Container(
//       // width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             flex: 1,
//             child: InkWell(
//               onTap: onClosePressed,
//               child: Container(
//                 height: 56.w,
//                 decoration: const BoxDecoration(
//                   // color: isMainActive ? darkRed : primaryDisabledColor,
//                   color: Color(0xff2A3541),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       8.0,
//                     ),
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     pLabel,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontFamily: FontFamily.NEUE,
//                       fontWeight: FontWeight.w700,
//                       // color: isMainActive ? darkGreen : Colors.white54,
//                       color: White,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 16.h),
//           if (linkVisible)
//             Expanded(
//               flex: 1,
//               child: InkWell(
//                 onTap: onLinkPressed,
//                 child: Container(
//                   width: (Get.width / 2.5),
//                   height: 56.w,
//                   decoration: BoxDecoration(
//                     // color: Color(0xFF2A3541),
//                     color: primaryColor,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(
//                         8.0,
//                       ),
//                     ),
//                     boxShadow: [
//                       if (true)
//                         BoxShadow(
//                           color: primaryColor.withAlpha(125),
//                           blurRadius: 6,
//                           spreadRadius: 2,
//                           offset: const Offset(0, 0),
//                         )
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       dLabel,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontFamily: FontFamily.NEUE,
//                         fontWeight: FontWeight.w700,
//                         color: White,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   static pairButtonsHorizontal(pLabel, dLabel, isMainActive,
//       {onMainPressed, onDefaultPressed}) {
//     return Container(
//       // width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             flex: 1,
//             child: InkWell(
//               onTap: onDefaultPressed,
//               child: Container(
//                 height: 56.w,
//                 decoration: const BoxDecoration(
//                   // color: isMainActive ? darkRed : primaryDisabledColor,
//                   color: Color(0xff2A3541),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       8.0,
//                     ),
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     pLabel,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontFamily: FontFamily.NEUE,
//                       fontWeight: FontWeight.w700,
//                       // color: isMainActive ? darkGreen : Colors.white54,
//                       color: White,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 16.h),
//           Expanded(
//             flex: 1,
//             child: InkWell(
//               onTap: onMainPressed,
//               child: Container(
//                 width: (Get.width / 2.5),
//                 height: 56.w,
//                 decoration: BoxDecoration(
//                   // color: Color(0xFF2A3541),
//                   color: primaryColor,
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       8.0,
//                     ),
//                   ),
//                   boxShadow: [
//                     if (isMainActive)
//                       BoxShadow(
//                         color: primaryColor.withAlpha(125),
//                         blurRadius: 6,
//                         spreadRadius: 2,
//                         offset: const Offset(0, 0),
//                       )
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     dLabel,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontFamily: FontFamily.NEUE,
//                       fontWeight: FontWeight.w700,
//                       color: White,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static pairButtonsHorizontalState(pLabel, dLabel, RxBool isMainActive,
//       {onMainPressed, onDefaultPressed}) {
//     return Container(
//       // width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             flex: 1,
//             child: InkWell(
//               onTap: onDefaultPressed,
//               child: Container(
//                 height: 56.w,
//                 decoration: const BoxDecoration(
//                   color: Color(0xff2A3541),
//                   borderRadius: BorderRadius.all(
//                     Radius.circular(
//                       8.0,
//                     ),
//                   ),
//                 ),
//                 child: Center(
//                   child: Text(
//                     pLabel,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontFamily: FontFamily.NEUE,
//                       fontWeight: FontWeight.w700,
//                       // color: isMainActive ? darkGreen : Colors.white54,
//                       color: White,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 16.h),
//           Expanded(
//             flex: 1,
//             child: InkWell(
//               onTap: () {
//                 if (isMainActive.value) {
//                   onMainPressed();
//                 }
//               },
//               child: Obx(
//                 () => Container(
//                   width: (Get.width / 2.5),
//                   height: 56.w,
//                   decoration: BoxDecoration(
//                     color: isMainActive.value
//                         ? primaryColor
//                         : primaryDisabledColor,
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(
//                         8.0,
//                       ),
//                     ),
//                     boxShadow: [
//                       if (isMainActive.value)
//                         BoxShadow(
//                           color: primaryColor.withAlpha(125),
//                           blurRadius: 6,
//                           spreadRadius: 2,
//                           offset: const Offset(0, 0),
//                         )
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       dLabel,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14.sp,
//                         fontFamily: FontFamily.NEUE,
//                         fontWeight: FontWeight.w700,
//                         color: White,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static pairButtonsHorizontalLoader(pLabel, dLabel) {
//     return Container(
//       // width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           Expanded(
//             flex: 1,
//             child: Container(
//               height: 56.w,
//               decoration: const BoxDecoration(
//                 color: Color(0xff2A3541),
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//               ),
//               child: Center(
//                 child: Text(
//                   pLabel,
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontFamily: FontFamily.NEUE,
//                     fontWeight: FontWeight.w700,
//                     // color: isMainActive ? darkGreen : Colors.white54,
//                     color: White,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 16.h),
//           Expanded(
//             flex: 1,
//             child: Container(
//               width: (Get.width / 2.5),
//               height: 56.w,
//               decoration: BoxDecoration(
//                 color: primaryDisabledColor,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//               ),
//               child: Center(
//                 child: Lottie.asset('assets/animations/button_loader.json',
//                     height: 20.h),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static blueButtons(label, {onPressed}) {
//     return Container(
//       width: Get.width,
//       padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: InkWell(
//         onTap: onPressed,
//         child: Container(
//           width: Get.width,
//           height: 54.w,
//           decoration: BoxDecoration(
//             color: primaryColor,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 8.0,
//               ),
//             ),
//             // boxShadow: [
//             //   BoxShadow(
//             //     color: Colors.blue.withAlpha(125),
//             //     blurRadius: 6,
//             //     spreadRadius: 2,
//             //     offset: const Offset(0, 0),
//             //   )
//             // ],
//           ),
//           child: Center(
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: White,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static greenButton(label, {onPressed}) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: InkWell(
//         onTap: onPressed,
//         child: Container(
//           width: Get.width,
//           height: 54.w,
//           decoration: BoxDecoration(
//             color: const Color(0xFF4FAE6F),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 8.0,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.green.withAlpha(125),
//                 blurRadius: 6,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 0),
//               )
//             ],
//           ),
//           child: Center(
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: White,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static redButton(label, {onPressed}) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x690B1119),
//             Color(0xFF0B1119),
//           ],
//         ),
//       ),
//       child: InkWell(
//         onTap: onPressed,
//         child: Container(
//           width: Get.width,
//           height: 54.w,
//           decoration: BoxDecoration(
//             color: const Color(0xFFF85706),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 8.0,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.red.withAlpha(125),
//                 blurRadius: 6,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 0),
//               )
//             ],
//           ),
//           child: Center(
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: White,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static blueButton(label, RxBool isActive, {onPressed}) {
//     return Container(
//       width: Get.width,
//       decoration: const BoxDecoration(
//         gradient: blackGradientUp,
//       ),
//       child: InkWell(
//         onTap: onPressed,
//         child: Obx(
//           () => Container(
//             width: Get.width,
//             height: 54.w,
//             decoration: BoxDecoration(
//               color: isActive.value ? primaryColor : primaryDisabledColor,
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(
//                   8.0,
//                 ),
//               ),
//               boxShadow: [
//                 if (isActive.value)
//                   BoxShadow(
//                     color: Colors.blue.withAlpha(125),
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 0),
//                   )
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 label,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontFamily: FontFamily.NEUE,
//                   fontWeight: FontWeight.w700,
//                   color: isActive.value ? White : Colors.white54,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static roundedBlueButton(label, RxBool isActive, {onPressed}) {
//     return Container(
//       width: Get.width,
//       height: 100.h,
//       padding: EdgeInsets.all(20.h),
//       decoration: const BoxDecoration(
//         gradient: blackGradientUp,
//       ),
//       child: InkWell(
//         onTap: onPressed,
//         child: Obx(
//           () => Container(
//             width: Get.width,
//             height: 54.h,
//             decoration: BoxDecoration(
//               color: isActive.value ? primaryColor : primaryDisabledColor,
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(
//                   28.0,
//                 ),
//               ),
//               boxShadow: [
//                 if (isActive.value)
//                   BoxShadow(
//                     color: Colors.blue.withAlpha(125),
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 0),
//                   )
//               ],
//             ),
//             child: Center(
//               child: Text(
//                 label,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontSize: 14.sp,
//                   fontFamily: FontFamily.NEUE,
//                   fontWeight: FontWeight.w700,
//                   color: isActive.value ? White : Colors.white54,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static roundedBlueButtonWithoutBg(label, RxBool isActive, {onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: Obx(
//         () => Container(
//           width: Get.width,
//           height: 54.h,
//           decoration: BoxDecoration(
//             color: isActive.value ? primaryColor : primaryDisabledColor,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 28.0,
//               ),
//             ),
//             boxShadow: [
//               if (isActive.value)
//                 BoxShadow(
//                   color: Colors.blue.withAlpha(125),
//                   blurRadius: 6,
//                   spreadRadius: 2,
//                   offset: const Offset(0, 0),
//                 )
//             ],
//           ),
//           child: Center(
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: isActive.value ? White : Colors.white54,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static pairRoundedButtonsWithBg(pLabel, dLabel, pLIsActive, dLIsActive,
//       {required onMainPressed, required onDefaultPressed}) {
//     return Container(
//       width: Get.width,
//       height: 120,
//       alignment: Alignment.bottomCenter,
//       padding: EdgeInsets.all(0.h),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0, -1),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x0018212B),
//             Color(0xFF18212B),
//           ],
//         ),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: onDefaultPressed,
//               child: Obx(
//                 () => Container(
//                   width: Get.width,
//                   height: 48,
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF2A3541),
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(
//                         28,
//                       ),
//                     ),
//                   ),
//                   child: Center(
//                     child: Text(
//                       dLabel,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: FontFamily.NEUE,
//                         fontWeight: FontWeight.w700,
//                         color: dLIsActive.value ? White : Colors.white54,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: InkWell(
//               onTap: onMainPressed,
//               child: Obx(
//                 () => Container(
//                   width: Get.width,
//                   height: 48,
//                   margin:
//                       const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                   decoration: BoxDecoration(
//                     color:
//                         pLIsActive.value ? primaryColor : primaryDisabledColor,
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(
//                         28.0,
//                       ),
//                     ),
//                     boxShadow: [
//                       if (pLIsActive.value)
//                         BoxShadow(
//                           color: Colors.blue.withAlpha(125),
//                           blurRadius: 6,
//                           spreadRadius: 2,
//                           offset: const Offset(0, 0),
//                         )
//                     ],
//                   ),
//                   child: Center(
//                     child: Text(
//                       pLabel,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontFamily: FontFamily.NEUE,
//                         fontWeight: FontWeight.w700,
//                         color: pLIsActive.value ? White : Colors.white54,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static loaderButton(bool danger) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(gradient: blackGradientUp),
//       child: Container(
//         width: Get.width,
//         height: 54.w,
//         decoration: danger
//             ? BoxDecoration(
//                 color: const Color(0xFFD63A52),
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.red.withAlpha(125),
//                     blurRadius: 6,
//                     spreadRadius: 2,
//                     offset: const Offset(0, 0),
//                   )
//                 ],
//               )
//             : const BoxDecoration(
//                 color: primaryDisabledColor,
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(
//                     8.0,
//                   ),
//                 ),
//               ),
//         child: Center(
//             child: Center(
//           child: SizedBox(
//             // height: 80.0,
//             // width: 240.0,
//             child: Lottie.asset('assets/animations/button_loader.json',
//                 height: 28.h),
//           ),
//         )),
//       ),
//     );
//   }
//
//   static backButton({onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: SvgPicture.asset(
//         'assets/ic_back_withborder.svg',
//         height: 40.h,
//         width: 40.w,
//       ),
//     );
//
//     // return InkWell(
//     //   onTap: onPressed,
//     //   child: CircleAvatar(
//     //    // backgroundColor: cardBorderColorTrans,
//     //     radius: 24.h,
//     //     child: CircleAvatar(
//     //       radius: 22.h,
//     //       backgroundColor: backgroundColorTrans,
//     //       child: SvgPicture.asset(
//     //         'assets/ic_back_withborder.svg',
//     //         height: 24.h,
//     //         width: 24.w,
//     //       ),
//     //     ),
//     //   ),
//     // );
//   }
//
//
//   static workoutButtonFinishLoader() {
//     return Expanded(
//       child: Container(
//         height: 54.w,
//         decoration: BoxDecoration(
//           color: const Color(0xFFD63A52),
//           borderRadius: const BorderRadius.all(
//             Radius.circular(
//               8.0,
//             ),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.red.withAlpha(125),
//               blurRadius: 6,
//               spreadRadius: 2,
//               offset: const Offset(0, 0),
//             )
//           ],
//         ),
//         child: Center(
//           child: SizedBox(
//             // height: 80.0,
//             // width: 240.0,
//             child: Lottie.asset('assets/animations/button_loader.json',
//                 height: 28.h),
//           ),
//           // child: Text(
//           //   'FINISH',
//           //   textAlign: TextAlign.center,
//           //   style: TextStyle(
//           //     fontSize: 14.sp,
//           //     fontFamily: FontFamily.NEUE,
//           //     fontWeight: FontWeight.w700,
//           //     color: White,
//           //   ),
//           // ),
//         ),
//       ),
//     );
//     // return Expanded(
//     //   child: Container(
//     //     width: Get.width,
//     //     // padding: EdgeInsets.symmetric(horizontal: 12.w),
//     //     decoration: const BoxDecoration(gradient: blackGradientUp),
//     //     child: Container(
//     //       // width: Get.width,
//     //       height: 54.w,
//     //       decoration: danger
//     //           ? BoxDecoration(
//     //         color: const Color(0xFFD63A52),
//     //         borderRadius: const BorderRadius.all(
//     //           Radius.circular(
//     //             8.0,
//     //           ),
//     //         ),
//     //         boxShadow: [
//     //           BoxShadow(
//     //             color: Colors.red.withAlpha(125),
//     //             blurRadius: 6,
//     //             spreadRadius: 2,
//     //             offset: const Offset(0, 0),
//     //           )
//     //         ],
//     //       )
//     //           : const BoxDecoration(
//     //         color: primaryDisabledColor,
//     //         borderRadius: BorderRadius.all(
//     //           Radius.circular(
//     //             8.0,
//     //           ),
//     //         ),
//     //       ),
//     //       child: Center(
//     //           child: Center(
//     //             child: SizedBox(
//     //               // height: 80.0,
//     //               // width: 240.0,
//     //               child: Lottie.asset('assets/animations/button_loader.json',
//     //                   height: 28.h),
//     //             ),
//     //           )),
//     //     ),
//     //   ),
//     // );
//   }
//
//   static workoutButtonFinish({onFinish}) {
//     return Expanded(
//       child: InkWell(
//         onTap: onFinish,
//         child: Container(
//           height: 54.w,
//           decoration: BoxDecoration(
//             color: const Color(0xFFD63A52),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 8.0,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.red.withAlpha(125),
//                 blurRadius: 6,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 0),
//               )
//             ],
//           ),
//           child: Center(
//             child: Text(
//               'FINISH',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: White,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static workoutButtonResume({onResume}) {
//     return Expanded(
//       child: InkWell(
//         onTap: onResume,
//         child: Container(
//           height: 54.w,
//           decoration: BoxDecoration(
//             color: const Color(0xFF4FAE6F),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 8.0,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.lightGreen.withAlpha(125),
//                 blurRadius: 6,
//                 spreadRadius: 2,
//                 offset: const Offset(0, 0),
//               )
//             ],
//           ),
//           child: Center(
//             child: Text(
//               'RESUME',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: White,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static workoutButtons({onResume, onFinish}) {
//     return Container(
//       width: Get.width,
//       height: 140.h,
//       decoration: const BoxDecoration(gradient: trackerButtonsGradient),
//       child: Row(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: onFinish,
//               child: Container(
//                 height: 54.w,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFD63A52),
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(
//                       8.0,
//                     ),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.red.withAlpha(125),
//                       blurRadius: 6,
//                       spreadRadius: 2,
//                       offset: const Offset(0, 0),
//                     )
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     'FINISH',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontFamily: FontFamily.NEUE,
//                       fontWeight: FontWeight.w700,
//                       color: White,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 24.w,
//           ),
//           Expanded(
//             child: InkWell(
//               onTap: onResume,
//               child: Container(
//                 height: 54.w,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF4FAE6F),
//                   borderRadius: const BorderRadius.all(
//                     Radius.circular(
//                       8.0,
//                     ),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.lightGreen.withAlpha(125),
//                       blurRadius: 6,
//                       spreadRadius: 2,
//                       offset: const Offset(0, 0),
//                     )
//                   ],
//                 ),
//                 child: Center(
//                   child: Text(
//                     'RESUME',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontFamily: FontFamily.NEUE,
//                       fontWeight: FontWeight.w700,
//                       color: White,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static onBoardingButtons(label, imgPath, {onPressed}) {
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         decoration: BoxDecoration(
//           color: bottomSheetBg,
//           border: Border.all(color: inputBorderColor, width: 2.0),
//           borderRadius: BorderRadius.all(
//             Radius.circular(8.w),
//           ),
//         ),
//         height: 56.h,
//         padding: EdgeInsets.symmetric(horizontal: 16.w),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SvgPicture.asset(
//               imgPath,
//               height: 18.h,
//               width: 18.h,
//             ),
//             Text(
//               label,
//               style: TextStyle(
//                 color: White,
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w700,
//                 fontFamily: FontFamily.NEUE,
//               ),
//             ),
//             SizedBox(
//               width: 0.w,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   static circleButtons({
//     @required imgPath,
//     @required label,
//     @required color,
//     @required onPressed,
//   }) {
//     return InkWell(
//       onTap: onPressed,
//       child: Column(
//         children: [
//           CircleAvatar(
//             backgroundColor: backgroundColor,
//             radius: 32.r,
//             child: SvgPicture.asset(
//               imgPath,
//               height: 32.h,
//               width: 32.w,
//               fit: BoxFit.fill,
//               color: color,
//             ),
//           ),
//           SizedBox(
//             height: 12.h,
//           ),
//           Text(
//             label,
//             style: TextStyle(
//               color: color,
//               fontFamily: FontFamily.N27,
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   static themeButtons(label, primaryClr, {onPressed}) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x4AA469),
//             Color(0x18212B),
//           ],
//         ),
//       ),
//       child: InkWell(
//         onTap: onPressed,
//         child: Container(
//           width: Get.width,
//           height: 54.w,
//           decoration: BoxDecoration(
//             color: primaryClr,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 20.0,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blue.withAlpha(25),
//                 blurRadius: 1,
//                 spreadRadius: 1,
//                 offset: const Offset(0, 0),
//               )
//             ],
//           ),
//           child: Center(
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: White,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static whiteButtons(label, primaryClr, {onPressed}) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment(0.0, -1.0),
//           end: Alignment(0, 0),
//           colors: [
//             Color(0x000B1119),
//             Color(0x4AA469),
//             Color(0x18212B),
//           ],
//         ),
//       ),
//       child: InkWell(
//         onTap: onPressed,
//         child: Container(
//           width: Get.width,
//           height: 54.w,
//           decoration: BoxDecoration(
//             color: primaryClr,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 20.0,
//               ),
//             ),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.blue.withAlpha(25),
//                 blurRadius: 1,
//                 spreadRadius: 1,
//                 offset: const Offset(0, 0),
//               )
//             ],
//           ),
//           child: Center(
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: greyBlack,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   static colorButtons(label, buttonColor,textColor, {onPressed}) {
//     return Container(
//       width: Get.width,
//       // padding: EdgeInsets.symmetric(horizontal: 12.w),
//       // decoration: const BoxDecoration(
//       //   gradient: LinearGradient(
//       //     begin: Alignment(0.0, -1.0),
//       //     end: Alignment(0, 0),
//       //     colors: [
//       //       Color(0x000B1119),
//       //       Color(0x4AA469),
//       //       Color(0x18212B),
//       //     ],
//       //   ),
//       // ),
//       child: InkWell(
//         onTap: onPressed,
//         child: Container(
//           width: Get.width,
//           height: 54.w,
//           decoration: BoxDecoration(
//             color: buttonColor,
//             borderRadius: const BorderRadius.all(
//               Radius.circular(
//                 20.0,
//               ),
//             ),
//             // boxShadow: [
//             //   BoxShadow(
//             //     color: Colors.blue.withAlpha(25),
//             //     blurRadius: 1,
//             //     spreadRadius: 1,
//             //     offset: const Offset(0, 0),
//             //   )
//             // ],
//           ),
//           child: Center(
//             child: Text(
//               label,
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: 14.sp,
//                 fontFamily: FontFamily.NEUE,
//                 fontWeight: FontWeight.w700,
//                 color: textColor,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
