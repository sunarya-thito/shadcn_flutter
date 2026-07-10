import 'package:shadcn_flutter/shadcn_flutter.dart';

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
    _currentHorizontal = ((localPosition.dx - widget.padding.left) /
            (size.width - widget.padding.horizontal))
        .clamp(0, 1);
    _currentVertical = ((localPosition.dy - widget.padding.top) /
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
    widget.onChanging?.call(HSVColor.fromAHSV(
      _alpha.clamp(0, 1),
      _hue.clamp(0, 360),
      _saturation.clamp(0, 1),
      _value.clamp(0, 1),
    ));
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
        widget.onChanged?.call(HSVColor.fromAHSV(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _value.clamp(0, 1),
        ));
      },
      onPanUpdate: (details) {
        setState(() {
          _updateColor(details.localPosition, context.size!);
        });
      },
      onPanEnd: (details) {
        widget.onChanged?.call(HSVColor.fromAHSV(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _value.clamp(0, 1),
        ));
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(
            child: RepaintBoundary(
              child: ClipRRect(
                borderRadius: BorderRadius.all(widget.radius),
                child: CustomPaint(
                  painter: AlphaPainter(),
                ),
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
                              (_currentVertical.clamp(0, 1) * 2) - 1),
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
                              (_currentVertical.clamp(0, 1) * 2) - 1),
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
                          (_currentVertical.clamp(0, 1) * 2) - 1),
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
    // disable anti-aliasing
    var pp = Paint();
    pp.isAntiAlias = false;
    pp.style = PaintingStyle.fill;
    var canvasHeight = size.height;
    var canvasWidth = size.width;
    if (sliderType == HSVColorSliderType.hueSat) {
      // if reverse, then its sat hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for saturation
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSVColor.fromAHSV(1, i.toDouble(), j / 100, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for saturation
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result =
                HSVColor.fromAHSV(1, j.toDouble(), i / 100, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.hueVal) {
      // if reverse, then its val hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for value
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSVColor.fromAHSV(1, i.toDouble(), color.saturation, j / 100.0);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for value
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result =
                HSVColor.fromAHSV(1, j.toDouble(), color.saturation, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.satVal) {
      // if reverse, then its val sat
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for value
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(1, color.hue, i / 100, j / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for value
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(1, color.hue, j / 100, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.hueAlpha) {
      // if reverse, then its alpha hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for alpha
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(
                j / 100.0, i.toDouble(), color.saturation, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 360;
        // horizontal for hue and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result = HSVColor.fromAHSV(
                i / 100, j.toDouble(), color.saturation, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.satAlpha) {
      // if reverse, then its alpha sat
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSVColor.fromAHSV(j / 100, color.hue, i / 100, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSVColor.fromAHSV(i / 100, color.hue, j / 100, color.value);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.valAlpha) {
      // if reverse, then its alpha val
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for value and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(
                j / 100, color.hue, color.saturation, i / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      } else {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for value and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSVColor.fromAHSV(
                i / 100, color.hue, color.saturation, j / 100);
            final paint = pp
              ..color = result.toColor()
              ..style = PaintingStyle.fill;
            canvas.drawRect(
              Rect.fromLTWH(i * width, j * height, width, height),
              paint,
            );
          }
        }
      }
    } else if (sliderType == HSVColorSliderType.hue) {
      if (reverse) {
        double width = canvasWidth / 360;
        for (var i = 0; i < 360; i++) {
          final result = HSVColor.fromAHSV(
              1, i.toDouble(), color.saturation, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 360;
        for (var i = 0; i < 360; i++) {
          final result = HSVColor.fromAHSV(
              1, i.toDouble(), color.saturation, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSVColorSliderType.sat) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSVColor.fromAHSV(1, color.hue, i / 100, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSVColor.fromAHSV(1, color.hue, i / 100, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSVColorSliderType.val) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSVColor.fromAHSV(1, color.hue, color.saturation, i / 100);
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSVColor.fromAHSV(1, color.hue, color.saturation, i / 100);
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSVColorSliderType.alpha) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSVColor.fromAHSV(
              i / 100, color.hue, color.saturation, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(i * width, 0, width, canvasHeight),
            paint,
          );
        }
      } else {
        double height = canvasHeight / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSVColor.fromAHSV(
              i / 100, color.hue, color.saturation, color.value.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant HSVColorSliderPainter oldDelegate) {
    if (oldDelegate.reverse != reverse ||
        oldDelegate.sliderType != sliderType) {
      return true;
    }
    if (sliderType == HSVColorSliderType.hueSat) {
      return oldDelegate.color.value != color.value;
    } else if (sliderType == HSVColorSliderType.hueVal) {
      return oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSVColorSliderType.satVal) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSVColorSliderType.alpha) {
      return oldDelegate.color.value != color.value ||
          oldDelegate.color.saturation != color.saturation ||
          oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSVColorSliderType.hue) {
      return oldDelegate.color.saturation != color.saturation ||
          oldDelegate.color.value != color.value;
    } else if (sliderType == HSVColorSliderType.sat) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.value != color.value;
    } else if (sliderType == HSVColorSliderType.val) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSVColorSliderType.hueAlpha) {
      return oldDelegate.color.value != color.value;
    } else if (sliderType == HSVColorSliderType.satAlpha) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSVColorSliderType.valAlpha) {
      return oldDelegate.color.hue != color.hue;
    }
    return false;
  }
}
