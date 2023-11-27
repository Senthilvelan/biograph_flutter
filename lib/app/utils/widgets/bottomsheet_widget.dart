//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../utils_res/color_helper.dart';
// import '../../utils_res/font_family.dart';
// import '../../utils_res/styles_helper.dart';
// import 'buttons.dart';
//
// class BottomSheetUtil {
//   static errorBottomSheet(
//     BuildContext context,
//     label,
//     content, {
//     @required onRetryPressed,
//     @required onCloseResived,
//   }) {
//     return showModalBottomSheet(
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       context: context,
//       builder: (context) {
//         return StylesHelper.bottomSheetStyles(
//           height: 0.38,
//           child: Column(
//             children: [
//               Text(
//                 'UH OH! STAKING UNSUCCESSFUL',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   fontFamily: FontFamily.NEUE,
//                   color: redWhite,
//                   fontSize: 16.sp,
//                 ),
//               ),
//               SizedBox(
//                 height: 16.h,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 32.w,
//                 ),
//                 child: Text(
//                   'There was some issue while transfering your \$FITT to our contract. Please try again',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontWeight: FontWeight.w400,
//                     fontFamily: FontFamily.INTER,
//                     color: activeColor,
//                     height: 1.5,
//                     fontSize: 16.sp,
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 48.h,
//               ),
//               CustomButtons.pairButtons(
//                 'RETRY',
//                 'CLOSE',
//                 onMainPressed: onRetryPressed,
//                 onDefaultPressed: onCloseResived,
//               )
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   static customBlackGradientBottomSheet({
//     required BuildContext context,
//     required child,
//   }) {
//     return showModalBottomSheet<void>(
//         backgroundColor: Colors.black.withOpacity(0),
//         context: context,
//         builder: (BuildContext context) {
//           return Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 padding: const EdgeInsets.only(
//                     left: 24, right: 24, top: 20, bottom: 40),
//                 decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color.fromRGBO(0, 0, 0, 0),
//                     Colors.black,
//                   ],
//                 )),
//                 child: Center(child: child),
//               ));
//         });
//   }
// }
