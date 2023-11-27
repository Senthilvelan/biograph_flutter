// import 'package:fitmint_flutter/app/utils/color_helper.dart';
// import 'package:fitmint_flutter/app/utils/font_helper.dart';
// import 'package:fitmint_flutter/app/utils/string_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// class WidgetActivityTracker extends StatelessWidget {
//   const WidgetActivityTracker(
//       {Key? key,
//       required this.headerText,
//       required this.specialistsImageAsset,
//       required this.footerText,
//       required this.onClickText,
//       required this.onCardPressed})
//       : super(key: key);
//   final String headerText;
//   final String specialistsImageAsset;
//   final String footerText;
//
//   final String onClickText;
//   final GestureTapCallback onCardPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onCardPressed,
//       child: Card(
//         elevation: 2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//         shadowColor: Colors.blueAccent,
//         color: greyHeader,
//         child: Padding(
//           padding: const EdgeInsets.all(12.0),
//           child: Container(
//             height: 100,
//             width: 100,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     StringHelper.getNotoSansText(headerText,
//                         fontSize: HomeHeadingRowSize,
//                         color: useCameraSheetColor,
//                         font: FontWeight.bold),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 30,
//                   width: 30,
//                   child: Image.asset(
//                     specialistsImageAsset,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 StringHelper.getNotoSansText(footerText,
//                     fontSize: specialistsViewFooterText,
//                     color: Black,
//                     font: FontWeight.bold),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   children: [
//                     StringHelper.getNotoSansText(
//                       onClickText,
//                       fontSize: 12,
//                       color: Grey,
//                       font: FontWeight.normal,
//                     ),
//
//                     SizedBox(
//                         height: 8,
//                         width: 8,
//                         child: Image.asset(
//                           "assets/specialists_view_icons/down_arrow.png",
//                           color: Colors.grey,
//                         ))
//                     // SvgPicture.asset(
//                     //   forwardArrowAsset,
//                     // ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
