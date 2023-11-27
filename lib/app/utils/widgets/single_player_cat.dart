// import 'package:fitmint_flutter/app/app.dart';
// import 'package:fitmint_flutter/app/models/category_profile.dart';
// import 'package:fitmint_flutter/app/newui/widgets/custom_buttons.dart';
// import 'package:fitmint_flutter/app/newui/widgets/gradient_text.dart';
// import 'package:fitmint_flutter/app/utils/category.dart';
// import 'package:fitmint_flutter/app/utils/color_helper.dart';
// import 'package:fitmint_flutter/app/utils/font_family.dart';
// import 'package:fitmint_flutter/app/utils/styles_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
//
// class SinglePlayerCat extends StatelessWidget {
//   const SinglePlayerCat({
//     Key? key,
//     required this.catTitle,
//     required this.catLevel,
//     required this.catMin,
//     required this.catDesc1,
//     required this.catDesc2,
//     required this.catImage,
//     required this.catImageGroup,
//     required this.onPressedCont,
//     this.buttonText = "Continue",
//   }) : super(key: key);
//
//   //title
//   final String catTitle;
//   final String catLevel;
//   final String catMin;
//
//   //desc
//   final String catDesc1;
//   final String catDesc2;
//
//   //images
//   final String catImage;
//   final String catImageGroup;
//
//   //button
//   final onPressedCont;
//   final String buttonText;
//
//   @override
//   Widget build(BuildContext context) {
//     CategoryDetails catItem =
//         Category.getCategory(category: catTitle.toLowerCase());
//     CategoryDetails currentCatItem =
//         Category.getCategory(category: App.playerData.category.toLowerCase());
//     return DraggableScrollableSheet(
//         initialChildSize: 0.80,
//         minChildSize: 0.50,
//         maxChildSize: 1.0,
//         builder: (context, controller) {
//           return Container(
//             padding: EdgeInsets.only(
//               left: 20.0,
//               right: 20.0,
//               top: 8.0,
//             ),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.vertical(
//                 top: Radius.circular(25.0),
//               ),
//               color: bgWhiteColor,
//             ),
//             child: ListView(
//               controller: controller,
//               children: [
//                 Column(
//                   children: [
//                     StylesHelper.getTopLine(),
//                     SizedBox(
//                       height: 36,
//                     ),
//                     Image.asset(
//                       catImage,
//                       width: 90,
//                       height: 90,
//                     ),
//                     SizedBox(
//                       height: 20,
//                     ),
//                     Text(
//                       catTitle.toUpperCase(),
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: primaryBlackColor,
//                         fontWeight: FontWeight.w800,
//                         fontFamily: FontFamily.MONO_SANS_EBI,
//                         fontStyle: FontStyle.italic,
//                         fontSize: 20,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     (catTitle.toLowerCase() != Category.goat.toLowerCase())
//                         ? Container(
//                             width: 140.0,
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.only(
//                               top: 8.0,
//                               bottom: 8.0,
//                             ),
//                             decoration: BoxDecoration(
//                               color: catItem.bgColor.withOpacity(0.1),
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(16.0)),
//                             ),
//                             child: Text(
//                               catLevel.toUpperCase(),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: catItem.bgColor,
//                                 fontWeight: FontWeight.w900,
//                                 fontFamily: FontFamily.INTER_BLACK,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           )
//                         : Container(
//                             width: 140.0,
//                             alignment: Alignment.center,
//                             padding: const EdgeInsets.only(
//                               top: 8.0,
//                               bottom: 8.0,
//                             ),
//                             decoration: BoxDecoration(
//                               color: Color(0xFFC55F1A).withOpacity(0.1),
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(20.0),
//                               ),
//                             ),
//                             child: GradientText(
//                               catLevel.toUpperCase(),
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: catItem.bgColor,
//                                 fontWeight: FontWeight.w900,
//                                 fontFamily: FontFamily.INTER_BLACK,
//                                 fontStyle: FontStyle.normal,
//                                 fontSize: 12,
//                               ),
//                               gradient: const LinearGradient(colors: [
//                                 Color(0xFFBD7E09),
//                                 Color(0xFFF0C55F),
//                               ]),
//                             ),
//                           ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 28,
//                 ),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.people_rounded,
//                       size: 16,
//                       color: primaryBlackColor.withOpacity(0.6),
//                     ),
//                     SizedBox(
//                       width: 2,
//                     ),
//                     Text(
//                       '${catItem.percentageUser.toString()}% Fitminters ',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: primaryBlackColor.withOpacity(0.6),
//                         fontWeight: FontWeight.w700,
//                         fontFamily: FontFamily.INTER_BLACK,
//                         fontStyle: FontStyle.normal,
//                         fontSize: 14,
//                       ),
//                     ),
//                     Text(
//                       'are here',
//                       textAlign: TextAlign.left,
//                       style: TextStyle(
//                         color: primaryBlackColor.withOpacity(0.6),
//                         fontWeight: FontWeight.w500,
//                         fontFamily: FontFamily.INTER_MEDIUM,
//                         fontStyle: FontStyle.normal,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 32,
//                 ),
//                 Container(
//                   decoration: StylesHelper.cardStyles,
//                   child: Padding(
//                     padding: const EdgeInsets.all(20.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               Text(
//                                 'DAILY ACTIVE GOAL',
//                                 textAlign: TextAlign.left,
//                                 style: TextStyle(
//                                   color: primaryBlackColor,
//                                   fontWeight: FontWeight.w800,
//                                   fontFamily: FontFamily.MONO_SANS_EBW,
//                                   fontStyle: FontStyle.normal,
//                                   fontSize: 12.sp,
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 8.0,
//                               ),
//                               Container(
//                                 width: 220,
//                                 // margin: const EdgeInsets.only(top: 5.0),
//                                 child: Text(
//                                   catItem.categoryMapLabel.toString(),
//                                   textAlign: TextAlign.left,
//                                   softWrap: true,
//                                   style: TextStyle(
//                                     color: bgBlackColor.withOpacity(0.6),
//                                     fontWeight: FontWeight.w500,
//                                     fontFamily: FontFamily.INTER_MEDIUM,
//                                     fontStyle: FontStyle.normal,
//                                     fontSize: 14.sp,
//                                     height: 1.4,
//                                   ),
//                                 ),
//
//                                 /*   Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     mainAxisAlignment: MainAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         catDesc1,
//                                         textAlign: TextAlign.left,
//                                         softWrap: true,
//                                         style: TextStyle(
//                                           color: secondaryBlackColor,
//                                           fontWeight: FontWeight.normal,
//                                           fontFamily: FontFamily.INTER,
//                                           fontStyle: FontStyle.normal,
//                                           fontSize: 8.sp,
//                                         ),
//                                       ),
//                                       // Text(
//                                       //   'Each day counts',
//                                       //   textAlign: TextAlign.left,
//                                       //   softWrap: true,
//                                       //   style: TextStyle(
//                                       //     color: secondaryBlackColor,
//                                       //     fontWeight: FontWeight.normal,
//                                       //     fontFamily: FontFamily.INTER,
//                                       //     fontStyle: FontStyle.normal,
//                                       //     fontSize: 8.sp,
//                                       //   ),
//                                       // ),
//                                     ],
//                                   ),*/
//                               ),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             Text(
//                               catMin,
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: primaryBlackColor,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: FontFamily.MONO_SANS_EBW,
//                                 fontStyle: FontStyle.italic,
//                                 fontSize: 54.sp,
//                               ),
//                             ),
//                             Text(
//                               'min'.toUpperCase(),
//                               textAlign: TextAlign.left,
//                               style: TextStyle(
//                                 color: primaryBlackColor,
//                                 fontWeight: FontWeight.bold,
//                                 fontFamily: FontFamily.MONO_SANS_EBW,
//                                 fontStyle: FontStyle.italic,
//                                 fontSize: 10.sp,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 Container(
//                   decoration: StylesHelper.cardStyles,
//                   child: Container(
//                     padding: EdgeInsets.all(
//                       20,
//                     ),
//                     width: Get.width,
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           catItem.categoryMap,
//                           width: 240,
//                           height: 180,
//                         ),
//                         SizedBox(
//                           height: 4.0,
//                         ),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(
//                               'UNLOCK FASHION THAT YOU CAN FLAUNT',
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: primaryBlackColor,
//                                 fontWeight: FontWeight.w800,
//                                 fontFamily: FontFamily.MONO_SANS_EBW,
//                                 fontSize: 12.sp,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 12.0,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text(
//                                   catItem.categoryMapSubLabel.toString(),
//                                   textAlign: TextAlign.center,
//                                   softWrap: true,
//                                   style: TextStyle(
//                                     color: secondaryBlackColor.withOpacity(
//                                       0.6,
//                                     ),
//                                     fontWeight: FontWeight.normal,
//                                     fontFamily: FontFamily.INTER_MEDIUM,
//                                     height: 1.4,
//                                     fontSize: 14.sp,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   height: 12.0,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 24,
//                 ),
//                 CustomButtons.roundedPrimaryButton(
//                   buttonText.toUpperCase(),
//                   // onPressed: onPressedCont
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   isLoading: false.obs,
//                   isActive: true.obs,
//                 ),
//                 const SizedBox(
//                   height: 24.0,
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
