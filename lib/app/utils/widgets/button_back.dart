import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonBack extends StatelessWidget {
  const ButtonBack({Key? key, required this.onBackPressed}) : super(key: key);

  final GestureTapCallback onBackPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackPressed,
      child: Padding(
        padding: EdgeInsets.all(6),
        child: SvgPicture.asset(
          'assets/ic_back.svg',
          fit: BoxFit.contain,
          height: 36,
          width: 36,
        ),
      ),
    );
  }
}
