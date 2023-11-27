// import 'package:flutter/material.dart';
//
// import '../../utils_res/string_helper.dart';
//
// class RoundedButtonWithoutIcon extends StatelessWidget {
//   const RoundedButtonWithoutIcon(
//       {Key? key,
//       required this.borderColor,
//       required this.backgroundColor,
//       required this.textColor,
//       required this.selectionText,
//       required this.onCardPressed})
//       : super(key: key);
//
//   final String selectionText;
//   final Color textColor;
//   final Color borderColor;
//   final Color backgroundColor;
//   final GestureTapCallback onCardPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onCardPressed,
//       child: Container(
//         height: 35,
//         decoration: BoxDecoration(
//             border: Border.all(
//               width: 2,
//               color: borderColor,
//             ),
//             borderRadius: BorderRadius.all(Radius.circular(20)),
//             color: backgroundColor),
//         child: FittedBox(
//           fit: BoxFit.none,
//           child: StringHelper.getNotoSansText(selectionText,
//               fontSize: HomeHeadingRowSize, color: textColor),
//         ),
//       ),
//     );
//   }
// }
