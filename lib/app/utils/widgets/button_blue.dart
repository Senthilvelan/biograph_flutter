// import 'package:fitmint_flutter/app/utils/color_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:fitmint_flutter/app/utils/font_helper.dart';
// import 'package:fitmint_flutter/app/utils/string_helper.dart';
//
// class ButtonBlueBg extends StatelessWidget {
//   const ButtonBlueBg(
//       {Key? key,
//       // required this.borderColor,
//       // required this.backgroundColor,
//       // required this.textColor,
//       required this.selectionText,
//       required this.onCardPressed})
//       : super(key: key);
//
//   final String selectionText;
//   final GestureTapCallback onCardPressed;
//
//   // final Color textColor;
//   // final Color borderColor;
//   // final Color backgroundColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onCardPressed,
//       child: Container(
//           height: 45,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(4),
//             gradient: LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 stops: [0.4, 1.0],
//                 colors: [startGradientColor, endGradientColor]),
//           ),
//           child: Center(
//             child: StringHelper.getNotoSansText(selectionText,
//                 fontSize: optionsSubmitSize,
//                 font: FontWeight.w400,
//                 color: White),
//           )),
//     );
//   }
//
// // @override
// // Widget build(BuildContext context) {
// //   return GestureDetector(
// //     onTap: onCardPressed,
// //     child: Container(
// //       height: 35,
// //       decoration: BoxDecoration(
// //           border: Border.all(
// //             width: 2,
// //             color: borderColor,
// //           ),
// //           borderRadius: BorderRadius.all(Radius.circular(20)),
// //           color: backgroundColor),
// //       child: FittedBox(
// //         fit: BoxFit.none,
// //         child: StringHelper.getNotoSansText(selectionText,
// //             fontSize: HomeHeadingRowSize, color: textColor),
// //       ),
// //     ),
// //   );
// // }
// }
