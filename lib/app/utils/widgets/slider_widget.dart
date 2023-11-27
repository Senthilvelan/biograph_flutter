import 'package:flutter/material.dart';

class SliderThumbShape extends SliderComponentShape {
  const SliderThumbShape({
    this.enabledThumbRadius = 15.0,
    required this.disabledThumbRadius,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
  });

  final double enabledThumbRadius;

  /// [enabledThumbRadius]
  final double disabledThumbRadius;

  double get _disabledThumbRadius => disabledThumbRadius;

  final double elevation;
  final double pressedElevation;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(context != null);
    assert(center != null);
    assert(enableAnimation != null);
    assert(sliderTheme != null);
    assert(sliderTheme.disabledThumbColor != null);
    assert(sliderTheme.thumbColor != null);
    assert(!sizeWithOverflow.isEmpty);

    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );

    final double radius = radiusTween.evaluate(enableAnimation);

    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    final double evaluatedElevation =
        elevationTween.evaluate(activationAnimation);

    {
      final Path path = Path()
        ..addArc(
            Rect.fromCenter(
                center: center, width: 1 * radius, height: 1 * radius),
            0,
            (3.14) * 2);
      final hsl = HSLColor.fromColor(sliderTheme.thumbColor!);
      final hslDark = hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0));

      Paint paint = Paint()..color = hslDark.toColor();
      paint.strokeWidth = 5;
      paint.style = PaintingStyle.stroke;
      canvas.drawCircle(
        center,
        radius,
        paint,
      );
      {
        Paint paint = Paint()
          ..color = sliderTheme.thumbColor!; //const Color(0xFF359F40);
        paint.style = PaintingStyle.fill;
        canvas.drawCircle(
          center,
          radius,
          paint,
        );
      }
    }
  }
}

class CustomTrackShape extends RectangularSliderTrackShape {
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class RoundSliderTrackShape extends SliderTrackShape {
  /// Create a slider track that draws 2 rectangles.
  const RoundSliderTrackShape({this.disabledThumbGapWidth = 2.0});

  /// Horizontal spacing, or gap, between the disabled thumb and the track.
  ///
  /// This is only used when the slider is disabled. There is no gap around
  /// the thumb and any part of the track when the slider is enabled. The
  /// Material spec defaults this gap width 2, which is half of the disabled
  /// thumb radius.
  final double disabledThumbGapWidth;

  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double? overlayWidth =
        sliderTheme.overlayShape?.getPreferredSize(isEnabled, isDiscrete).width;
    final double? trackHeight = sliderTheme.trackHeight;
    assert(overlayWidth! >= 0);
    assert(trackHeight! >= 0);
    assert(parentBox.size.width >= overlayWidth!);
    assert(parentBox.size.height >= trackHeight!);

    final double trackLeft = offset.dx + overlayWidth! / 2;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight!) / 2;
    // TODO(clocksmith): Although this works for a material, perhaps the default
    // rectangular track should be padded not just by the overlay, but by the
    // max of the thumb and the overlay, in case there is no overlay.
    final double trackWidth = parentBox.size.width - overlayWidth;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset,
      {required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required Animation<double> enableAnimation,
      required Offset thumbCenter,
      Offset? secondaryOffset,
      bool isEnabled = false,
      bool isDiscrete = true,
      required TextDirection textDirection}) {
    // TODO: implement paint
  }

//   @override
//   void paint(
//     PaintingContext context,
//     Offset offset, {
//     required RenderBox parentBox,
//     required SliderThemeData sliderTheme,
//     required Animation<double> enableAnimation,
//     required TextDirection textDirection,
//     required Offset thumbCenter,
//     bool isDiscrete = false,
//     bool isEnabled = false,
//   }) {
//     // If the slider track height is 0, then it makes no difference whether the
//     // track is painted or not, therefore the painting can be a no-op.
//     if (sliderTheme.trackHeight == 0) {
//       return;
//     }
//
//     // Assign the track segment paints, which are left: active, right: inactive,
//     // but reversed for right to left text.
//     final ColorTween activeTrackColorTween = ColorTween(
//         begin: sliderTheme.disabledActiveTrackColor,
//         end: sliderTheme.activeTrackColor);
//     final ColorTween inactiveTrackColorTween = ColorTween(
//         begin: sliderTheme.disabledInactiveTrackColor,
//         end: sliderTheme.inactiveTrackColor);
//     final Paint activePaint = Paint()
//       ..color = activeTrackColorTween.evaluate(enableAnimation)!;
//     final Paint inactivePaint = Paint()
//       ..color = inactiveTrackColorTween.evaluate(enableAnimation)!;
//     Paint leftTrackPaint;
//     Paint rightTrackPaint;
//     switch (textDirection) {
//       case TextDirection.ltr:
//         leftTrackPaint = activePaint;
//         rightTrackPaint = inactivePaint;
//         break;
//       case TextDirection.rtl:
//         leftTrackPaint = inactivePaint;
//         rightTrackPaint = activePaint;
//         break;
//     }
//
//     // Used to create a gap around the thumb iff the slider is disabled.
//     // If the slider is enabled, the track can be drawn beneath the thumb
//     // without a gap. But when the slider is disabled, the track is shortened
//     // and this gap helps determine how much shorter it should be.
//     // TODO(clocksmith): The new Material spec has a gray circle in place of this gap.
//     double horizontalAdjustment = 0.0;
//     if (!isEnabled) {
//       final double disabledThumbRadius =
//           (sliderTheme.thumbShape?.getPreferredSize(false, isDiscrete).width ??
//                   0) /
//               2.0;
//       final double gap = disabledThumbGapWidth * (1.0 - enableAnimation.value);
//       horizontalAdjustment = disabledThumbRadius + gap;
//     }
//
//     final Rect trackRect = getPreferredRect(
//       parentBox: parentBox,
//       offset: offset,
//       sliderTheme: sliderTheme,
//       isEnabled: isEnabled,
//       isDiscrete: isDiscrete,
//     );
//     final Rect leftTrackSegment = Rect.fromLTRB(trackRect.left - 0.3,
//         trackRect.top, thumbCenter.dx - horizontalAdjustment, trackRect.bottom);
//
//     context.canvas.drawArc(
//         Rect.fromCircle(
//             center: Offset(
//                 trackRect.left, trackRect.top + sliderTheme.trackHeight! / 2),
//             radius: sliderTheme.trackHeight! / 2),
//         -pi * 3 / 2, // -270 degrees
//         pi, // 180 degrees
//         false,
//         trackRect.left - thumbCenter.dx == 0.0
//             ? rightTrackPaint
//             : leftTrackPaint);
//
// // Right Arc
//
//     context.canvas.drawArc(
//         Rect.fromCircle(
//             center: Offset(
//                 trackRect.right, trackRect.top + sliderTheme.trackHeight! / 2),
//             radius: sliderTheme.trackHeight! / 2),
//         -pi / 2, // -90 degrees
//         pi, // 180 degrees
//         false,
//         trackRect.right - thumbCenter.dx == 0.0
//             ? leftTrackPaint
//             : rightTrackPaint);
//
//     context.canvas.drawRect(leftTrackSegment, leftTrackPaint);
//     final Rect rightTrackSegment = Rect.fromLTRB(
//         thumbCenter.dx + horizontalAdjustment,
//         trackRect.top,
//         trackRect.right,
//         trackRect.bottom);
//     context.canvas.drawRect(rightTrackSegment, rightTrackPaint);
//   }
}
