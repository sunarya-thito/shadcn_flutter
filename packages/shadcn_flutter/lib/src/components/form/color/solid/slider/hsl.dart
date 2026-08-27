import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/form/color/solid/slider/color_field.dart';

/// A slider widget for adjusting HSL color components.
///
/// [HSLColorSlider] provides an interactive slider for modifying different
/// aspects of an HSL color (hue, saturation, lightness, and combinations).
/// The slider displays a gradient representing the selected color channel(s)
/// and allows users to drag to adjust values.
///
/// Example:
/// ```dart
/// HSLColorSlider(
///   color: HSLColor.fromColor(Colors.blue),
///   sliderType: HSLColorSliderType.hue,
///   onChanged: (newColor) {
///     print('New hue: ${newColor.hue}');
///   },
/// )
/// ```
class HSLColorSlider extends StatefulWidget {
  /// The current HSL color value.
  final HSLColor color;

  /// Called while the slider is being dragged.
  final ValueChanged<HSLColor>? onChanging;

  /// Called when the slider interaction is complete.
  final ValueChanged<HSLColor>? onChanged;

  /// The type of HSL component(s) this slider controls.
  final HSLColorSliderType sliderType;

  /// Whether to reverse the slider direction.
  final bool reverse;

  /// Corner radius for the slider.
  final Radius radius;

  /// Padding around the slider.
  final EdgeInsets padding;

  /// Creates an [HSLColorSlider].
  const HSLColorSlider({
    super.key,
    required this.color,
    this.onChanging,
    this.onChanged,
    required this.sliderType,
    this.reverse = false,
    this.radius = const Radius.circular(0),
    this.padding = const EdgeInsets.all(0),
  });

  @override
  State<HSLColorSlider> createState() => _HSLColorSliderState();
}

class _HSLColorSliderState extends State<HSLColorSlider> {
  late double _currentHorizontal;
  late double _currentVertical;
  late double _hue;
  late double _saturation;
  late double _lightness;
  late double _alpha;

  @override
  void initState() {
    super.initState();
    _currentHorizontal = horizontal;
    _currentVertical = vertical;
    HSLColor hsl = widget.color;
    _hue = hsl.hue;
    _saturation = hsl.saturation;
    _lightness = hsl.lightness;
    _alpha = hsl.alpha;
  }

  void _updateColor(Offset localPosition, Size size) {
    _currentHorizontal =
        ((localPosition.dx - widget.padding.left) /
                (size.width - widget.padding.horizontal))
            .clamp(0, 1);
    _currentVertical =
        ((localPosition.dy - widget.padding.top) /
                (size.height - widget.padding.vertical))
            .clamp(0, 1);
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        _hue = _currentHorizontal * 360;
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        _hue = _currentHorizontal * 360;
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        _hue = _currentHorizontal * 360;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        _saturation = _currentHorizontal;
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        _saturation = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        _lightness = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        _hue = _currentHorizontal * 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        _alpha = _currentHorizontal;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        _hue = _currentVertical * 360;
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        _hue = _currentVertical * 360;
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        _hue = _currentVertical * 360;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        _saturation = _currentVertical;
        _lightness = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        _saturation = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        _lightness = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        _lightness = _currentVertical;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        _alpha = _currentVertical;
      }
    }
    widget.onChanging?.call(
      HSLColor.fromAHSL(
        _alpha.clamp(0, 1),
        _hue.clamp(0, 360),
        _saturation.clamp(0, 1),
        _lightness.clamp(0, 1),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HSLColorSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      HSLColor hsl = widget.color;
      _hue = hsl.hue;
      _saturation = hsl.saturation;
      _lightness = hsl.lightness;
      _alpha = hsl.alpha;
      _currentHorizontal = horizontal;
      _currentVertical = vertical;
    }
  }

  bool get isSingleChannel {
    return widget.sliderType == HSLColorSliderType.hue ||
        widget.sliderType == HSLColorSliderType.sat ||
        widget.sliderType == HSLColorSliderType.lum ||
        widget.sliderType == HSLColorSliderType.alpha;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    double cursorRadius = theme.scaling * 16;
    double radDiv = isSingleChannel ? 4 : 2;
    return GestureDetector(
      onTapDown: (details) {
        _updateColor(details.localPosition, context.size!);
        widget.onChanged?.call(
          HSLColor.fromAHSL(
            _alpha.clamp(0, 1),
            _hue.clamp(0, 360),
            _saturation.clamp(0, 1),
            _lightness.clamp(0, 1),
          ),
        );
      },
      onPanUpdate: (details) {
        setState(() {
          _updateColor(details.localPosition, context.size!);
        });
      },
      onPanEnd: (details) {
        widget.onChanged?.call(
          HSLColor.fromAHSL(
            _alpha.clamp(0, 1),
            _hue.clamp(0, 360),
            _saturation.clamp(0, 1),
            _lightness.clamp(0, 1),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(painter: AlphaPainter()),
              ),
            ),
          ),
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: HSLColorSliderPainter(
                    sliderType: widget.sliderType,
                    color: HSLColor.fromAHSL(
                      _alpha.clamp(0, 1),
                      _hue.clamp(0, 360),
                      _saturation.clamp(0, 1),
                      _lightness.clamp(0, 1),
                    ),
                    reverse: widget.reverse,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: -cursorRadius / radDiv,
            top: -cursorRadius / radDiv,
            bottom: -cursorRadius / radDiv,
            right: -cursorRadius / radDiv,
            child: isSingleChannel
                ? (widget.reverse
                      ? Padding(
                          padding: EdgeInsets.only(
                            left: widget.padding.left,
                            right: widget.padding.right,
                          ),
                          child: Align(
                            alignment: Alignment(
                              (_currentHorizontal.clamp(0, 1) * 2) - 1,
                              (_currentVertical.clamp(0, 1) * 2) - 1,
                            ),
                            child: Container(
                              width: cursorRadius,
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: widget.color.toColor(),
                                border: Border.all(
                                  color: Colors.white,
                                  width: theme.scaling * 2,
                                ),
                                borderRadius: BorderRadius.all(widget.radius),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.only(
                            top: widget.padding.top,
                            bottom: widget.padding.bottom,
                          ),
                          child: Align(
                            alignment: Alignment(
                              (_currentHorizontal.clamp(0, 1) * 2) - 1,
                              (_currentVertical.clamp(0, 1) * 2) - 1,
                            ),
                            child: Container(
                              height: cursorRadius,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: widget.color.toColor(),
                                border: Border.all(
                                  color: Colors.white,
                                  width: theme.scaling * 2,
                                ),
                                borderRadius: BorderRadius.all(widget.radius),
                              ),
                            ),
                          ),
                        ))
                : Padding(
                    padding: widget.padding,
                    child: Align(
                      alignment: Alignment(
                        (_currentHorizontal.clamp(0, 1) * 2) - 1,
                        (_currentVertical.clamp(0, 1) * 2) - 1,
                      ),
                      child: Container(
                        width: cursorRadius,
                        height: cursorRadius,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.color.toColor(),
                          border: Border.all(
                            color: Colors.white,
                            width: theme.scaling * 2,
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  double get vertical {
    HSLColor hsl = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    }
    return 0;
  }

  double get horizontal {
    HSLColor hsl = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    } else {
      if (widget.sliderType == HSLColorSliderType.hueSat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.hueLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.hueAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.satLum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.satAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.lumAlpha) {
        return hsl.alpha;
      } else if (widget.sliderType == HSLColorSliderType.hue) {
        return hsl.hue / 360;
      } else if (widget.sliderType == HSLColorSliderType.sat) {
        return hsl.saturation;
      } else if (widget.sliderType == HSLColorSliderType.lum) {
        return hsl.lightness;
      } else if (widget.sliderType == HSLColorSliderType.alpha) {
        return hsl.alpha;
      }
    }
    return 0;
  }
}

/// Which axis each HSL channel runs along for a given slider type.
///
/// For the two-channel types the first channel in the name runs down the field
/// and the second runs across it; [HSLColorSliderPainter.reverse] swaps them.
/// Single-channel types run down the field unless reversed. Channels that do
/// not appear in the type are held constant.
class _HSLAxes {
  final ColorFieldAxis hue;
  final ColorFieldAxis saturation;
  final ColorFieldAxis lightness;
  final ColorFieldAxis alpha;

  const _HSLAxes({
    this.hue = ColorFieldAxis.none,
    this.saturation = ColorFieldAxis.none,
    this.lightness = ColorFieldAxis.none,
    this.alpha = ColorFieldAxis.none,
  });

  factory _HSLAxes.of(HSLColorSliderType type, bool reverse) {
    final first = reverse ? ColorFieldAxis.horizontal : ColorFieldAxis.vertical;
    final second = reverse
        ? ColorFieldAxis.vertical
        : ColorFieldAxis.horizontal;
    switch (type) {
      case HSLColorSliderType.hueSat:
        return _HSLAxes(hue: first, saturation: second);
      case HSLColorSliderType.hueLum:
        return _HSLAxes(hue: first, lightness: second);
      case HSLColorSliderType.hueAlpha:
        return _HSLAxes(hue: first, alpha: second);
      case HSLColorSliderType.satLum:
        return _HSLAxes(saturation: first, lightness: second);
      case HSLColorSliderType.satAlpha:
        return _HSLAxes(saturation: first, alpha: second);
      case HSLColorSliderType.lumAlpha:
        return _HSLAxes(lightness: first, alpha: second);
      case HSLColorSliderType.hue:
        return _HSLAxes(hue: first);
      case HSLColorSliderType.sat:
        return _HSLAxes(saturation: first);
      case HSLColorSliderType.lum:
        return _HSLAxes(lightness: first);
      case HSLColorSliderType.alpha:
        return _HSLAxes(alpha: first);
    }
  }
}

/// A custom painter for rendering HSL color slider gradients.
///
/// [HSLColorSliderPainter] draws the gradient background for HSL color sliders,
/// showing the range of possible colors for the selected slider type. The
/// gradient updates based on the current color and slider configuration.
class HSLColorSliderPainter extends CustomPainter {
  /// The type of slider being painted.
  final HSLColorSliderType sliderType;

  /// The current HSL color.
  final HSLColor color;

  /// Whether the gradient direction is reversed.
  final bool reverse;

  /// Creates an [HSLColorSliderPainter].
  HSLColorSliderPainter({
    required this.sliderType,
    required this.color,
    this.reverse = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final axes = _HSLAxes.of(sliderType, reverse);
    paintHSLColorField(
      canvas,
      size,
      // Sliders that do not carry the alpha channel show the color at full
      // opacity, so the transparency of [color] does not wash them out.
      color: axes.alpha == ColorFieldAxis.none
          ? HSLColor.fromAHSL(1, color.hue, color.saturation, color.lightness)
          : color,
      hueAxis: axes.hue,
      saturationAxis: axes.saturation,
      lightnessAxis: axes.lightness,
      alphaAxis: axes.alpha,
    );
  }

  @override
  bool shouldRepaint(covariant HSLColorSliderPainter oldDelegate) {
    if (oldDelegate.reverse != reverse ||
        oldDelegate.sliderType != sliderType) {
      return true;
    }
    // Only the channels held constant are baked into the gradient; the ones
    // that ramp across the field look the same whatever their current value.
    final axes = _HSLAxes.of(sliderType, reverse);
    const none = ColorFieldAxis.none;
    return (axes.hue == none && oldDelegate.color.hue != color.hue) ||
        (axes.saturation == none &&
            oldDelegate.color.saturation != color.saturation) ||
        (axes.lightness == none &&
            oldDelegate.color.lightness != color.lightness);
  }
}
