import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class CurvedTabIndicator extends Decoration {
  final double radius;
  final double tabExtent;
  final Color color;

  CurvedTabIndicator({
    required this.radius,
    required this.tabExtent,
    required this.color,
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _CurvedTabPainter(this, onChanged);
  }
}

class _CurvedTabPainter extends BoxPainter {
  final CurvedTabIndicator decoration;

  _CurvedTabPainter(this.decoration, VoidCallback? onChanged)
      : super(onChanged);

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    final width = configuration.size!.width;
    final height = 44.0;
    final _radius = decoration.radius;
    final _tabExtent = decoration.tabExtent;
    final _color = decoration.color;

    final double rightPos = width - 0;
    final double leftPos = 0;

    final Paint paint = Paint()..color = _color;

    final Path horizontalPath = Path()
      ..moveTo(0, _radius)
      ..quadraticBezierTo(
        0,
        0,
        -_radius,
        0,
      )
      ..lineTo(width + _radius, -40)
      ..lineTo(width + _radius, 0)
      ..quadraticBezierTo(
        width,
        0,
        width,
        _radius,
      )
      ..lineTo(width, height - _tabExtent - _radius)
      ..quadraticBezierTo(
        width,
        height - _tabExtent,
        max(width - _radius, rightPos),
        height - _tabExtent,
      )
      ..lineTo(
          min(max(width - _radius, rightPos), min(width, rightPos + _radius)),
          height - _tabExtent)
      ..quadraticBezierTo(
        rightPos,
        height - _tabExtent,
        rightPos,
        height - _tabExtent + _radius,
      )
      ..lineTo(rightPos, height - _radius)
      ..quadraticBezierTo(
        rightPos,
        height,
        rightPos - _radius,
        height,
      )
      ..lineTo(leftPos + _radius, height)
      ..quadraticBezierTo(
        leftPos,
        height,
        leftPos,
        height - _radius,
      )
      ..lineTo(leftPos, height - _tabExtent + _radius)
      ..quadraticBezierTo(
        leftPos,
        height - _tabExtent,
        max(min(_radius, leftPos), max(0, leftPos - _radius)),
        height - _tabExtent,
      )
      ..lineTo(min(_radius, leftPos), height - _tabExtent)
      ..quadraticBezierTo(
        0,
        height - _tabExtent,
        0,
        height - _tabExtent - _radius,
      );
    final Path startHorizontalPath = Path()
      ..moveTo(0, -80)
      ..lineTo(width + _radius, 0)
      ..quadraticBezierTo(
        width,
        0,
        width,
        _radius,
      )
      ..lineTo(width, height - _tabExtent - _radius)
      ..quadraticBezierTo(
        width,
        height - _tabExtent,
        max(width - _radius, rightPos),
        height - _tabExtent,
      )
      ..lineTo(
          min(max(width - _radius, rightPos), min(width, rightPos + _radius)),
          height - _tabExtent)
      ..quadraticBezierTo(
        rightPos,
        height - _tabExtent,
        rightPos,
        height - _tabExtent + _radius,
      )
      ..lineTo(rightPos, height - _radius)
      ..quadraticBezierTo(
        rightPos,
        height,
        rightPos - _radius,
        height,
      )
      ..lineTo(leftPos + _radius, height)
      ..quadraticBezierTo(
        leftPos,
        height,
        leftPos,
        height - _radius,
      )
      ..lineTo(leftPos, height - _tabExtent + _radius)
      ..quadraticBezierTo(
        leftPos,
        height - _tabExtent,
        max(min(_radius, leftPos), max(0, leftPos - _radius)),
        height - _tabExtent,
      )
      ..lineTo(min(_radius, leftPos), height - _tabExtent)
      ..quadraticBezierTo(
        0,
        height - _tabExtent,
        0,
        height - _tabExtent - _radius,
      )
      ..lineTo(0, -80);

    // canvas.save();
    canvas.scale(1, -1);
    canvas.translate(0, -height);
    print("offset.dx: ${offset.dx}");
    if (offset.dx < 20) {
      canvas.drawPath(startHorizontalPath.shift(offset), paint);
    } else {
      canvas.drawPath(horizontalPath.shift(offset), paint);
    }
    // canvas.restore();
  }
}
