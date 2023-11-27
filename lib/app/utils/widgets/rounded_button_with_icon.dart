// import 'package:flutter/material.dart';
//
// import '../../utils_res/string_helper.dart';
//
// class RoundedButtonWithIconWidget extends StatelessWidget {
//   const RoundedButtonWithIconWidget(
//       {Key? key,
//       required this.borderColor,
//       required this.backgroundColor,
//       required this.selectionIConColor,
//       required this.textColor,
//       required this.selectionText,
//       this.selectionIcons})
//       : super(key: key);
//
//   final String selectionText;
//   final String? selectionIcons;
//   final Color selectionIConColor;
//   final Color textColor;
//   final Color borderColor;
//   final Color backgroundColor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 35,
//       width: 150,
//       decoration: BoxDecoration(
//           border: Border.all(
//             width: 2,
//             color: borderColor,
//           ),
//           borderRadius: BorderRadius.all(Radius.circular(20)),
//           color: backgroundColor),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           StringHelper.getNotoSansText(selectionText,
//               fontSize: HomeHeadingRowSize, color: textColor),
//           SizedBox(
//               height: 25,
//               width: 25,
//               child: Image.asset(
//                 selectionIcons!,
//                 color: selectionIConColor,
//               ))
//         ],
//       ),
//     );
//   }
// }
