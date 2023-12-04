import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Ripple extends StatefulWidget {
  final VoidCallback onPressed;
  final Widget child;
  const Ripple({
    Key? key,
    required this.child,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<Ripple> createState() => _RippleState();
}

class _RippleState extends State<Ripple> with SingleTickerProviderStateMixin {
  late double _scale;

  late AnimationController _animate;

  VoidCallback get onPressed => widget.onPressed;

  @override
  void initState() {
    _animate = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 200),
        lowerBound: 0.0,
        upperBound: 0.1)
      ..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _animate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _animate.value;
    return GestureDetector(
        onTap: _onTap,
        child: Transform.scale(
          scale: _scale,
          child: widget.child,
        ));
  }

  void _onTap() {
    HapticFeedback.mediumImpact();
    _animate.forward();
    Future.delayed(const Duration(milliseconds: 100), () {
      _animate.reverse();
      onPressed();
    });
  }
}
