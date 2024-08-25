import 'package:flutter/material.dart';

enum ClickyBoundaryStyle {
  fromInitialTouchPoint,
  fromWidgetOutline,
  both,
}

class ClickyStyle {
  const ClickyStyle({
    this.color = Colors.transparent,
    this.borderRadius = 7,
    this.shrinkScale = const ShrinkScale.byRatio(0.03),
    this.curveColorIn = Curves.easeOutCirc,
    this.curveColorOut = Curves.easeOutBack,
    this.curveSizeIn = Curves.easeOut,
    this.curveSizeOut = Curves.easeOut,
    this.durationIn = const Duration(milliseconds: 150),
    this.durationOut = const Duration(milliseconds: 150),
    this.boundaryFromInitialTouchPoint = 70,
    this.boundaryFromWidgetOutline = 0,
    this.boundaryStyle = ClickyBoundaryStyle.fromWidgetOutline,
  });

  /// the color of the clicky effect
  final Color color;
  final double borderRadius;
  final Curve curveColorIn;
  final Curve curveColorOut;
  final ShrinkScale shrinkScale;
  final Curve curveSizeIn;
  final Curve curveSizeOut;
  final Duration durationIn;
  final Duration durationOut;
  final double boundaryFromInitialTouchPoint;
  final double boundaryFromWidgetOutline;
  final ClickyBoundaryStyle boundaryStyle;
}

class ShrinkScale {
  final double? ratio;
  // final double? value;

  // make validator, ratio and value cannot be null at the same time
  double byRatio() {
    assert(ratio != null);
    return ratio!;
  }

  // double byValue() {
  //   assert(ratio != null || value != null);
  //   return value!;
  // }

  const ShrinkScale.byRatio(this.ratio);
  // const ShrinkScale.byValue(this.value) : ratio = null;
}
