import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/form/color/solid/slider/color_field.dart';

/// A slider widget for adjusting HSV color components.
///
/// [HSVColorSlider] provides an interactive slider for modifying different
/// aspects of an HSV color (hue, saturation, value, and combinations).
/// The slider displays a gradient representing the selected color channel(s)
/// and allows users to drag to adjust values.
///
/// Example:
/// ```dart
/// HSVColorSlider(
///   value: HSVColor.fromColor(Colors.blue),
///   sliderType: HSVColorSliderType.hue,
///   onChanged: (newColor) {
///     print('New hue: ${newColor.hue}');
///   },
/// )
/// ```
class HSVColorSlider extends StatefulWidget {
  /// The current HSV color value.
  final HSVColor value;

  /// Called while the slider is being dragged.
  final ValueChanged<HSVColor>? onChanging;

  /// Called when the slider interaction is complete.
  final ValueChanged<HSVColor>? onChanged;

  /// The type of HSV component(s) this slider controls.
  final HSVColorSliderType sliderType;

  /// Whether to reverse the slider direction.
  final bool reverse;

  /// Corner radius for the slider.
  final Radius radius;

  /// Padding around the slider.
  final EdgeInsets padding;

  /// Creates an [HSVColorSlider].
  const HSVColorSlider({
    super.key,
    required this.value,
    this.onChanging,
    this.onChanged,
    required this.sliderType,
    this.reverse = false,
    this.radius = const Radius.circular(0),
    this.padding = const EdgeInsets.all(0),
  });

  @override
  State<HSVColorSlider> createState() => _HSVColorSliderState();
}

class _HSVColorSliderState extends State<HSVColorSlider> {
  late double _currentHorizontal;
  late double _currentVertical;
  late double _hue;
  late double _saturation;
  late double _value;
  late double _alpha;

  @override
  void initState() {
    super.initState();
    _currentHorizontal = horizontal;
    _currentVertical = vertical;
    HSVColor hsv = widget.value;
    _hue = hsv.hue;
    _saturation = hsv.saturation;
    _value = hsv.value;
    _alpha = hsv.alpha;
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
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        _hue = _currentHorizontal * 360;
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        _hue = _currentHorizontal * 360;
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        _hue = _currentHorizontal * 360;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        _saturation = _currentHorizontal;
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        _saturation = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentHorizontal * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentHorizontal;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        _hue = _currentVertical * 360;
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        _hue = _currentVertical * 360;
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        _hue = _currentVertical * 360;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        _saturation = _currentVertical;
        _value = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        _saturation = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        _value = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        _value = _currentVertical;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        _alpha = _currentVertical;
      }
    }
    widget.onChanging?.call(
      HSVColor.fromAHSV(
        _alpha.clamp(0, 1),
        _hue.clamp(0, 360),
        _saturation.clamp(0, 1),
        _value.clamp(0, 1),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HSVColorSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      HSVColor hsv = widget.value;
      _hue = hsv.hue;
      _saturation = hsv.saturation;
      _value = hsv.value;
      _alpha = hsv.alpha;
      _currentHorizontal = horizontal;
      _currentVertical = vertical;
    }
  }

  bool get isSingleChannel {
    return widget.sliderType == HSVColorSliderType.hue ||
        widget.sliderType == HSVColorSliderType.sat ||
        widget.sliderType == HSVColorSliderType.val ||
        widget.sliderType == HSVColorSliderType.alpha;
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
          HSVColor.fromAHSV(
            _alpha.clamp(0, 1),
            _hue.clamp(0, 360),
            _saturation.clamp(0, 1),
            _value.clamp(0, 1),
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
          HSVColor.fromAHSV(
            _alpha.clamp(0, 1),
            _hue.clamp(0, 360),
            _saturation.clamp(0, 1),
            _value.clamp(0, 1),
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
                  painter: HSVColorSliderPainter(
                    sliderType: widget.sliderType,
                    color: HSVColor.fromAHSV(
                      _alpha.clamp(0, 1),
                      _hue.clamp(0, 360),
                      _saturation.clamp(0, 1),
                      _value.clamp(0, 1),
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
                                color: widget.value.toColor(),
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
                                color: widget.value.toColor(),
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
                          color: widget.value.toColor(),
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
    HSVColor hsv = widget.value;
    if (widget.reverse) {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    }
    return 0;
  }

  double get horizontal {
    HSVColor hsv = widget.value;
    if (widget.reverse) {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    } else {
      if (widget.sliderType == HSVColorSliderType.hueSat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.hueVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.hueAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.satVal) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.satAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.valAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == HSVColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == HSVColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == HSVColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == HSVColorSliderType.alpha) {
        return hsv.alpha;
      }
    }
    return 0;
  }
}

/// Which axis each HSV channel runs along for a given slider type.
///
/// For the two-channel types the first channel in the name runs down the field
/// and the second runs across it; [HSVColorSliderPainter.reverse] swaps them.
/// Single-channel types run down the field unless reversed. Channels that do
/// not appear in the type are held constant.
class _HSVAxes {
  final ColorFieldAxis hue;
  final ColorFieldAxis saturation;
  final ColorFieldAxis value;
  final ColorFieldAxis alpha;

  const _HSVAxes({
    this.hue = ColorFieldAxis.none,
    this.saturation = ColorFieldAxis.none,
    this.value = ColorFieldAxis.none,
    this.alpha = ColorFieldAxis.none,
  });

  factory _HSVAxes.of(HSVColorSliderType type, bool reverse) {
    final first = reverse ? ColorFieldAxis.horizontal : ColorFieldAxis.vertical;
    final second = reverse
        ? ColorFieldAxis.vertical
        : ColorFieldAxis.horizontal;
    switch (type) {
      case HSVColorSliderType.hueSat:
        return _HSVAxes(hue: first, saturation: second);
      case HSVColorSliderType.hueVal:
        return _HSVAxes(hue: first, value: second);
      case HSVColorSliderType.hueAlpha:
        return _HSVAxes(hue: first, alpha: second);
      case HSVColorSliderType.satVal:
        return _HSVAxes(saturation: first, value: second);
      case HSVColorSliderType.satAlpha:
        return _HSVAxes(saturation: first, alpha: second);
      case HSVColorSliderType.valAlpha:
        return _HSVAxes(value: first, alpha: second);
      case HSVColorSliderType.hue:
        return _HSVAxes(hue: first);
      case HSVColorSliderType.sat:
        return _HSVAxes(saturation: first);
      case HSVColorSliderType.val:
        return _HSVAxes(value: first);
      case HSVColorSliderType.alpha:
        return _HSVAxes(alpha: first);
    }
  }
}

/// A custom painter for rendering HSV color slider gradients.
///
/// [HSVColorSliderPainter] draws the gradient background for HSV color sliders,
/// showing the range of possible colors for the selected slider type. The
/// gradient updates based on the current color and slider configuration.
class HSVColorSliderPainter extends CustomPainter {
  /// The type of slider being painted.
  final HSVColorSliderType sliderType;

  /// The current HSV color.
  final HSVColor color;

  /// Whether the gradient direction is reversed.
  final bool reverse;

  /// Creates an [HSVColorSliderPainter].
  HSVColorSliderPainter({
    required this.sliderType,
    required this.color,
    this.reverse = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final axes = _HSVAxes.of(sliderType, reverse);
    paintHSVColorField(
      canvas,
      size,
      // Sliders that do not carry the alpha channel show the color at full
      // opacity, so the transparency of [color] does not wash them out.
      color: axes.alpha == ColorFieldAxis.none
          ? HSVColor.fromAHSV(1, color.hue, color.saturation, color.value)
          : color,
      hueAxis: axes.hue,
      saturationAxis: axes.saturation,
      valueAxis: axes.value,
      alphaAxis: axes.alpha,
    );
  }

  @override
  bool shouldRepaint(covariant HSVColorSliderPainter oldDelegate) {
    if (oldDelegate.reverse != reverse ||
        oldDelegate.sliderType != sliderType) {
      return true;
    }
    // Only the channels held constant are baked into the gradient; the ones
    // that ramp across the field look the same whatever their current value.
    final axes = _HSVAxes.of(sliderType, reverse);
    const none = ColorFieldAxis.none;
    return (axes.hue == none && oldDelegate.color.hue != color.hue) ||
        (axes.saturation == none &&
            oldDelegate.color.saturation != color.saturation) ||
        (axes.value == none && oldDelegate.color.value != color.value);
  }
}
