import 'package:shadcn_flutter/shadcn_flutter.dart';

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
    _currentHorizontal = ((localPosition.dx - widget.padding.left) /
            (size.width - widget.padding.horizontal))
        .clamp(0, 1);
    _currentVertical = ((localPosition.dy - widget.padding.top) /
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
    widget.onChanging?.call(HSLColor.fromAHSL(
      _alpha.clamp(0, 1),
      _hue.clamp(0, 360),
      _saturation.clamp(0, 1),
      _lightness.clamp(0, 1),
    ));
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
        widget.onChanged?.call(HSLColor.fromAHSL(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _lightness.clamp(0, 1),
        ));
      },
      onPanUpdate: (details) {
        setState(() {
          _updateColor(details.localPosition, context.size!);
        });
      },
      onPanEnd: (details) {
        widget.onChanged?.call(HSLColor.fromAHSL(
          _alpha.clamp(0, 1),
          _hue.clamp(0, 360),
          _saturation.clamp(0, 1),
          _lightness.clamp(0, 1),
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
                              (_currentVertical.clamp(0, 1) * 2) - 1),
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
                              (_currentVertical.clamp(0, 1) * 2) - 1),
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
                          (_currentVertical.clamp(0, 1) * 2) - 1),
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
    // disable anti-aliasing
    var pp = Paint();
    pp.isAntiAlias = false;
    pp.style = PaintingStyle.fill;
    var canvasHeight = size.height;
    var canvasWidth = size.width;
    if (sliderType == HSLColorSliderType.hueSat) {
      // if reverse, then its sat hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for saturation
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSLColor.fromAHSL(1, i.toDouble(), j / 100, color.lightness);
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
                HSLColor.fromAHSL(1, j.toDouble(), i / 100, color.lightness);
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
    } else if (sliderType == HSLColorSliderType.hueLum) {
      // if reverse, then its lum hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for lightness
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSLColor.fromAHSL(1, i.toDouble(), color.saturation, j / 100.0);
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
        // horizontal for hue and vertical for lightness
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 360; j++) {
            final result =
                HSLColor.fromAHSL(1, j.toDouble(), color.saturation, i / 100);
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
    } else if (sliderType == HSLColorSliderType.satLum) {
      // if reverse, then its lum sat
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for lightness
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(1, color.hue, i / 100, j / 100);
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
        // horizontal for saturation and vertical for lightness
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(1, color.hue, j / 100, i / 100);
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
    } else if (sliderType == HSLColorSliderType.hueAlpha) {
      // if reverse, then its alpha hue
      if (reverse) {
        double width = canvasWidth / 360;
        double height = canvasHeight / 100;
        // vertical for hue and horizontal for alpha
        for (var i = 0; i < 360; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(
                j / 100.0, i.toDouble(), color.saturation, color.lightness);
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
            final result = HSLColor.fromAHSL(
                i / 100, j.toDouble(), color.saturation, color.lightness);
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
    } else if (sliderType == HSLColorSliderType.satAlpha) {
      // if reverse, then its alpha sat
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for saturation and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result =
                HSLColor.fromAHSL(j / 100, color.hue, i / 100, color.lightness);
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
                HSLColor.fromAHSL(i / 100, color.hue, j / 100, color.lightness);
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
    } else if (sliderType == HSLColorSliderType.lumAlpha) {
      // if reverse, then its alpha lum
      if (reverse) {
        double width = canvasWidth / 100;
        double height = canvasHeight / 100;
        // horizontal for lightness and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(
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
        // horizontal for lightness and vertical for alpha
        for (var i = 0; i < 100; i++) {
          for (var j = 0; j < 100; j++) {
            final result = HSLColor.fromAHSL(
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
    } else if (sliderType == HSLColorSliderType.hue) {
      if (reverse) {
        double width = canvasWidth / 360;
        for (var i = 0; i < 360; i++) {
          final result = HSLColor.fromAHSL(
              1, i.toDouble(), color.saturation, color.lightness.clamp(0, 1));
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
          final result = HSLColor.fromAHSL(
              1, i.toDouble(), color.saturation, color.lightness.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSLColorSliderType.sat) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSLColor.fromAHSL(
              1, color.hue, i / 100, color.lightness.clamp(0, 1));
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
          final result = HSLColor.fromAHSL(
              1, color.hue, i / 100, color.lightness.clamp(0, 1));
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSLColorSliderType.lum) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result =
              HSLColor.fromAHSL(1, color.hue, color.saturation, i / 100);
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
              HSLColor.fromAHSL(1, color.hue, color.saturation, i / 100);
          final paint = pp
            ..color = result.toColor()
            ..style = PaintingStyle.fill;
          canvas.drawRect(
            Rect.fromLTWH(0, i * height, canvasWidth, height),
            paint,
          );
        }
      }
    } else if (sliderType == HSLColorSliderType.alpha) {
      if (reverse) {
        double width = canvasWidth / 100;
        for (var i = 0; i < 100; i++) {
          final result = HSLColor.fromAHSL(i / 100, color.hue, color.saturation,
              color.lightness.clamp(0, 1));
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
          final result = HSLColor.fromAHSL(i / 100, color.hue, color.saturation,
              color.lightness.clamp(0, 1));
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
  bool shouldRepaint(covariant HSLColorSliderPainter oldDelegate) {
    if (oldDelegate.reverse != reverse ||
        oldDelegate.sliderType != sliderType) {
      return true;
    }
    if (sliderType == HSLColorSliderType.hueSat) {
      return oldDelegate.color.lightness != color.lightness;
    } else if (sliderType == HSLColorSliderType.hueLum) {
      return oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSLColorSliderType.satLum) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSLColorSliderType.alpha) {
      return oldDelegate.color.lightness != color.lightness ||
          oldDelegate.color.saturation != color.saturation ||
          oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSLColorSliderType.hue) {
      return oldDelegate.color.lightness != color.lightness ||
          oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSLColorSliderType.sat) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.lightness != color.lightness;
    } else if (sliderType == HSLColorSliderType.lum) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == HSLColorSliderType.hueAlpha) {
      return oldDelegate.color.lightness != color.lightness;
    } else if (sliderType == HSLColorSliderType.satAlpha) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == HSLColorSliderType.lumAlpha) {
      return oldDelegate.color.hue != color.hue;
    }
    return false;
  }
}
