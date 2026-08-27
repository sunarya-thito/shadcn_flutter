import 'dart:ui' as ui;

import 'package:shadcn_flutter/shadcn_flutter.dart';

/// The axis a colour component varies along inside a colour field.
///
/// A component set to [none] is held constant across the whole field. A
/// component set to [horizontal] or [vertical] ramps from its minimum at the
/// left/top edge to its maximum at the right/bottom edge.
enum ColorFieldAxis {
  /// The component does not vary; it is held at a single value.
  none,

  /// The component ramps from left (minimum) to right (maximum).
  horizontal,

  /// The component ramps from top (minimum) to bottom (maximum).
  vertical,
}

/// The pure hue wheel sampled at every 60 degrees.
///
/// Hue-to-RGB is piecewise linear with breakpoints exactly on these stops, so
/// interpolating between them reproduces the wheel exactly rather than
/// approximating it.
const List<Color> _hueSpectrum = <Color>[
  Color(0xFFFF0000),
  Color(0xFFFFFF00),
  Color(0xFF00FF00),
  Color(0xFF00FFFF),
  Color(0xFF0000FF),
  Color(0xFFFF00FF),
  Color(0xFFFF0000),
];

const Color _opaqueWhite = Color(0xFFFFFFFF);
const Color _clearWhite = Color(0x00FFFFFF);
const Color _opaqueBlack = Color(0xFF000000);
const Color _clearBlack = Color(0x00000000);
const Color _opaqueGrey = Color.from(alpha: 1, red: 0.5, green: 0.5, blue: 0.5);
const Color _clearGrey = Color.from(alpha: 0, red: 0.5, green: 0.5, blue: 0.5);

ui.Shader _ramp(
  Rect rect,
  ColorFieldAxis axis,
  List<Color> colors, [
  List<double>? stops,
]) {
  final horizontal = axis == ColorFieldAxis.horizontal;
  // dart:ui only infers stops for a two-colour gradient, so space the rest
  // evenly — which is what the hue spectrum's 60-degree steps want anyway.
  final resolvedStops =
      stops ??
      (colors.length == 2
          ? null
          : <double>[
              for (int i = 0; i < colors.length; i++) i / (colors.length - 1),
            ]);
  return ui.Gradient.linear(
    horizontal ? rect.centerLeft : rect.topCenter,
    horizontal ? rect.centerRight : rect.bottomCenter,
    colors,
    resolvedStops,
  );
}

/// Lays down the fully saturated hue the rest of the layers are folded into.
void _paintHue(
  Canvas canvas,
  Rect rect,
  Paint paint,
  ColorFieldAxis axis,
  double constantHue,
) {
  if (axis == ColorFieldAxis.none) {
    paint.shader = null;
    paint.color = HSVColor.fromAHSV(
      1,
      constantHue.clamp(0, 360),
      1,
      1,
    ).toColor();
  } else {
    paint.color = _opaqueWhite;
    paint.shader = _ramp(rect, axis, _hueSpectrum);
  }
  canvas.drawRect(rect, paint);
}

/// Composites a veil that is [opaque] where the component is 0 and
/// [transparent] where it is 1, either as a ramp along [axis] or as a flat
/// wash at [constantOpacity] when the component is held constant.
void _paintVeil(
  Canvas canvas,
  Rect rect,
  Paint paint,
  ColorFieldAxis axis,
  Color opaque,
  Color transparent,
  double constantOpacity,
) {
  if (axis == ColorFieldAxis.none) {
    if (constantOpacity <= 0) return;
    paint.shader = null;
    paint.color = opaque.withValues(alpha: constantOpacity.clamp(0, 1));
  } else {
    paint.color = _opaqueWhite;
    paint.shader = _ramp(rect, axis, <Color>[opaque, transparent]);
  }
  canvas.drawRect(rect, paint);
}

/// Multiplies everything painted so far by the alpha channel.
///
/// Only valid inside a save layer, since [BlendMode.dstIn] would otherwise
/// punch through whatever was already on the canvas.
void _paintAlpha(
  Canvas canvas,
  Rect rect,
  Paint paint,
  ColorFieldAxis axis,
  double constantAlpha,
) {
  paint.blendMode = BlendMode.dstIn;
  if (axis == ColorFieldAxis.none) {
    paint.shader = null;
    paint.color = _opaqueBlack.withValues(alpha: constantAlpha.clamp(0, 1));
  } else {
    paint.color = _opaqueWhite;
    paint.shader = _ramp(rect, axis, const <Color>[_clearBlack, _opaqueBlack]);
  }
  canvas.drawRect(rect, paint);
  paint.blendMode = BlendMode.srcOver;
}

/// Paints an HSV colour field into [rect] as a stack of gradients.
///
/// Each component either ramps along an axis or is held at the value it has in
/// [color]; alpha is treated as fully opaque unless [alphaAxis] varies it,
/// matching how the sliders present a colour independent of its transparency.
///
/// The layers reproduce `HSVColor.toColor` exactly: an RGB triple for
/// `HSVColor.fromAHSV(1, h, s, v)` is `v * ((1 - s) + s * hue(h))`, so a white
/// veil at `1 - s` blends the hue toward white and a black veil at `1 - v`
/// scales the result by `v`.
void paintHSVColorField(
  Canvas canvas,
  Size size, {
  required HSVColor color,
  ColorFieldAxis hueAxis = ColorFieldAxis.none,
  ColorFieldAxis saturationAxis = ColorFieldAxis.none,
  ColorFieldAxis valueAxis = ColorFieldAxis.none,
  ColorFieldAxis alphaAxis = ColorFieldAxis.none,
}) {
  final rect = Offset.zero & size;
  if (rect.isEmpty) return;
  final needsAlpha = alphaAxis != ColorFieldAxis.none || color.alpha < 1;
  if (needsAlpha) canvas.saveLayer(rect, Paint());
  final paint = Paint()..isAntiAlias = false;
  _paintHue(canvas, rect, paint, hueAxis, color.hue);
  _paintVeil(
    canvas,
    rect,
    paint,
    saturationAxis,
    _opaqueWhite,
    _clearWhite,
    1 - color.saturation,
  );
  _paintVeil(
    canvas,
    rect,
    paint,
    valueAxis,
    _opaqueBlack,
    _clearBlack,
    1 - color.value,
  );
  if (needsAlpha) {
    _paintAlpha(canvas, rect, paint, alphaAxis, color.alpha);
    canvas.restore();
  }
}

/// Paints an HSL colour field into [rect] as a stack of gradients.
///
/// Follows the same layering as [paintHSVColorField]. `HSLColor.toColor` gives
/// `l + chroma * (hue(h) - 0.5)` with `chroma = (1 - |2l - 1|) * s`, so
/// saturation fades the hue toward mid grey and lightness darkens below the
/// midpoint and lightens above it — which is why lightness needs a hard stop at
/// 0.5 rather than a single ramp.
void paintHSLColorField(
  Canvas canvas,
  Size size, {
  required HSLColor color,
  ColorFieldAxis hueAxis = ColorFieldAxis.none,
  ColorFieldAxis saturationAxis = ColorFieldAxis.none,
  ColorFieldAxis lightnessAxis = ColorFieldAxis.none,
  ColorFieldAxis alphaAxis = ColorFieldAxis.none,
}) {
  final rect = Offset.zero & size;
  if (rect.isEmpty) return;
  final needsAlpha = alphaAxis != ColorFieldAxis.none || color.alpha < 1;
  if (needsAlpha) canvas.saveLayer(rect, Paint());
  final paint = Paint()..isAntiAlias = false;
  _paintHue(canvas, rect, paint, hueAxis, color.hue);
  _paintVeil(
    canvas,
    rect,
    paint,
    saturationAxis,
    _opaqueGrey,
    _clearGrey,
    1 - color.saturation,
  );
  if (lightnessAxis == ColorFieldAxis.none) {
    final lightness = color.lightness.clamp(0.0, 1.0);
    if (lightness < 0.5) {
      _paintVeil(
        canvas,
        rect,
        paint,
        ColorFieldAxis.none,
        _opaqueBlack,
        _clearBlack,
        1 - lightness * 2,
      );
    } else if (lightness > 0.5) {
      _paintVeil(
        canvas,
        rect,
        paint,
        ColorFieldAxis.none,
        _opaqueWhite,
        _clearWhite,
        lightness * 2 - 1,
      );
    }
  } else {
    paint.color = _opaqueWhite;
    paint.shader = _ramp(
      rect,
      lightnessAxis,
      const <Color>[_opaqueBlack, _clearBlack, _clearWhite, _opaqueWhite],
      const <double>[0, 0.5, 0.5, 1],
    );
    canvas.drawRect(rect, paint);
  }
  if (needsAlpha) {
    _paintAlpha(canvas, rect, paint, alphaAxis, color.alpha);
    canvas.restore();
  }
}
