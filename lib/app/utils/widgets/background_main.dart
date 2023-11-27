import 'package:flutter/material.dart';

class MainBackground extends StatelessWidget {
  const MainBackground({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffF2F2F2),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SafeArea(
          child: child,
        ),
      ),
    );
  }
}

class BottomSheetBackground extends StatelessWidget {
  const BottomSheetBackground(
      {Key? key, required this.child, required this.bgColor})
      : super(key: key);

  final Widget child;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 0.8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12.0),
          topLeft: Radius.circular(12.0),
        ),
      ),
      child: child,
    );
  }
}
