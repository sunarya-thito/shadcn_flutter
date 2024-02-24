import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

typedef ColorPickerPopupBuilder = Widget Function(
    BuildContext context, VoidCallback showPicker);

class ColorPickerPopover extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onColorChanged;
  final bool showAlpha;
  final ColorPickerPopupBuilder builder;

  const ColorPickerPopover({
    Key? key,
    required this.color,
    required this.onColorChanged,
    this.showAlpha = true,
    required this.builder,
  }) : super(key: key);

  @override
  State<ColorPickerPopover> createState() => _ColorPickerPopoverState();
}

class _ColorPickerPopoverState extends State<ColorPickerPopover> {
  late HSVColor color;

  @override
  void initState() {
    super.initState();
    color = widget.color;
  }

  @override
  void didUpdateWidget(covariant ColorPickerPopover oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      color = widget.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Popover(
      builder: (context) {
        return widget.builder(context, () async {
          await context.showPopover();
          widget.onColorChanged(color);
        });
      },
      popoverBuilder: (context) {
        return SizedBox(
          width: 300,
          child: _ColorPickerPopup(
            color: color,
            onColorChanged: (value) {
              color = value;
              widget.onColorChanged(value);
            },
            showAlpha: widget.showAlpha,
          ),
        );
      },
      alignment: Alignment.bottomCenter,
      anchorAlignment: Alignment.topCenter,
    );
  }
}

class _ColorPickerPopup extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onColorChanged;
  final bool showAlpha;

  const _ColorPickerPopup({
    Key? key,
    required this.color,
    required this.onColorChanged,
    this.showAlpha = true,
  }) : super(key: key);

  @override
  State<_ColorPickerPopup> createState() => _ColorPickerPopupState();
}

class _ColorPickerPopupState extends State<_ColorPickerPopup> {
  late HSVColor color;
  @override
  void initState() {
    super.initState();
    color = widget.color;
  }

  @override
  void didUpdateWidget(covariant _ColorPickerPopup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      color = widget.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ColorPickerSet(
      color: color,
      onColorChanged: (value) {
        setState(() {
          color = value;
          widget.onColorChanged(value);
        });
      },
      showAlpha: widget.showAlpha,
    );
  }
}

class ColorPickerSet extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onColorChanged;
  final bool showAlpha;

  const ColorPickerSet({
    Key? key,
    required this.color,
    required this.onColorChanged,
    this.showAlpha = true,
  }) : super(key: key);

  @override
  State<ColorPickerSet> createState() => _ColorPickerSetState();
}

class _ColorPickerSetState extends State<ColorPickerSet> {
  HSVColor get color => widget.color;
  final TextEditingController _hexController = TextEditingController();
  final TextEditingController _redController = TextEditingController();
  final TextEditingController _greenController = TextEditingController();
  final TextEditingController _blueController = TextEditingController();
  final TextEditingController _alphaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.showAlpha) {
      _hexController.text = '#${color.toColor().value.toRadixString(16)}';
      Color c = color.toColor();
      _redController.text = c.red.toString();
      _greenController.text = c.green.toString();
      _blueController.text = c.blue.toString();
      _alphaController.text = c.alpha.toString();
    } else {
      _hexController.text =
          '#${color.toColor().value.toRadixString(16).substring(2)}';
      Color c = color.toColor();
      _redController.text = c.red.toString();
      _greenController.text = c.green.toString();
      _blueController.text = c.blue.toString();
    }
  }

  bool _updating = false;
  @override
  void didUpdateWidget(covariant ColorPickerSet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      _updating = true;
      if (widget.showAlpha) {
        _hexController.text = '#${color.toColor().value.toRadixString(16)}';
        Color c = color.toColor();
        _redController.text = c.red.toString();
        _greenController.text = c.green.toString();
        _blueController.text = c.blue.toString();
        _alphaController.text = c.alpha.toString();
      } else {
        _hexController.text =
            '#${color.toColor().value.toRadixString(16).substring(2)}';
        Color c = color.toColor();
        _redController.text = c.red.toString();
        _greenController.text = c.green.toString();
        _blueController.text = c.blue.toString();
      }
      _updating = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.border,
                ),
                borderRadius: BorderRadius.circular(theme.radiusLg),
              ),
              child: ColorPicker(
                color: color,
                radius: Radius.circular(theme.radiusLg),
                onColorChanged: (value) {
                  widget.onColorChanged(value);
                },
                sliderType: ColorSliderType.satVal,
                reverse: true,
              ),
            ),
          ),
          gap(16),
          SizedBox(
            height: 32,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.border,
                ),
                borderRadius: BorderRadius.circular(theme.radiusLg),
              ),
              child: ColorPicker(
                color: HSVColor.fromAHSV(1, color.hue, 1, 1),
                radius: Radius.circular(theme.radiusLg),
                onColorChanged: (value) {
                  setState(() {
                    widget.onColorChanged(HSVColor.fromAHSV(
                        color.alpha, value.hue, color.saturation, color.value));
                  });
                },
                sliderType: ColorSliderType.hue,
                reverse: true,
              ),
            ),
          ),
          if (widget.showAlpha) gap(16),
          // alpha
          if (widget.showAlpha)
            SizedBox(
              height: 32,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.border,
                  ),
                  borderRadius: BorderRadius.circular(theme.radiusLg),
                ),
                child: ColorPicker(
                  color: color,
                  onColorChanged: (value) {
                    widget.onColorChanged(value);
                  },
                  sliderType: ColorSliderType.alpha,
                  radius: Radius.circular(theme.radiusLg),
                  reverse: true,
                ),
              ),
            ),
          gap(16),
          TextField(
            controller: _hexController,
            onEditingComplete: () {
              var hex = _hexController.text;
              if (hex.startsWith('#')) {
                hex = hex.substring(1);
              }
              if (hex.length == 6) {
                widget.onColorChanged(
                    HSVColor.fromColor(Color(int.parse('FF$hex', radix: 16))));
              } else if (hex.length == 8) {
                widget.onColorChanged(
                    HSVColor.fromColor(Color(int.parse(hex, radix: 16))));
              } else {
                widget.onColorChanged(color);
                if (widget.showAlpha) {
                  _hexController.text =
                      '#${color.toColor().value.toRadixString(16)}';
                } else {
                  _hexController.text =
                      '#${color.toColor().value.toRadixString(16).substring(2)}';
                }
              }
            },
          ),
          gap(16),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Red'),
                  gap(4),
                  TextField(
                    controller: _redController,
                    onEditingComplete: () {
                      widget.onColorChanged(HSVColor.fromColor(Color.fromRGBO(
                        (int.tryParse(_redController.text) ??
                                color.toColor().red)
                            .clamp(0, 255),
                        color.toColor().green,
                        color.toColor().blue,
                        color.alpha,
                      )));
                    },
                  ),
                ],
              )),
              gap(16),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Green'),
                  gap(4),
                  TextField(
                    controller: _greenController,
                    onEditingComplete: () {
                      var cc = color.toColor();
                      widget.onColorChanged(HSVColor.fromColor(Color.fromRGBO(
                        cc.red,
                        (int.tryParse(_greenController.text) ?? cc.green)
                            .clamp(0, 255),
                        cc.blue,
                        color.alpha,
                      )));
                    },
                  ),
                ],
              )),
              gap(16),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Blue'),
                  gap(4),
                  TextField(
                    controller: _blueController,
                    onEditingComplete: () {
                      var cc = color.toColor();
                      widget.onColorChanged(HSVColor.fromColor(Color.fromRGBO(
                        cc.red,
                        cc.green,
                        // int.tryParse(_blueController.text) ?? 0,
                        (int.tryParse(_blueController.text) ?? cc.blue)
                            .clamp(0, 255),
                        color.alpha,
                      )));
                    },
                  ),
                ],
              )),
              if (widget.showAlpha) ...[
                gap(16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Alpha'),
                    gap(4),
                    TextField(
                      onEditingComplete: () {
                        widget.onColorChanged(HSVColor.fromAHSV(
                          ((int.tryParse(_alphaController.text) ??
                                      color.toColor().alpha) /
                                  255)
                              .clamp(0, 1),
                          color.hue,
                          color.saturation,
                          color.value,
                        ));
                      },
                      controller: _alphaController,
                    ),
                  ],
                )),
              ],
            ],
          )
        ],
      ),
    );
  }
}

enum ColorSliderType {
  hue,
  hueSat,
  hueVal,
  hueAlpha,
  sat,
  satVal,
  satAlpha,
  val,
  valAlpha,
  alpha;
}

class ColorPicker extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor>? onColorChanged;
  final ValueChanged<HSVColor>? onColorEnd;
  final ColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;

  const ColorPicker({
    Key? key,
    required this.color,
    this.onColorChanged,
    this.onColorEnd,
    required this.sliderType,
    this.reverse = false,
    this.radius = const Radius.circular(0),
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  static const double cursorRadius = 15;
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
    HSVColor hsv = widget.color;
    _hue = hsv.hue;
    _saturation = hsv.saturation;
    _value = hsv.value;
    _alpha = hsv.alpha;
  }

  void _updateColor(Offset localPosition, Size size) {
    // _currentHorizontal = (localPosition.dx / size.width).clamp(0, 1);
    // _currentVertical = (localPosition.dy / size.height).clamp(0, 1);
    // must consider padding
    _currentHorizontal = ((localPosition.dx - widget.padding.left) /
            (size.width - widget.padding.horizontal))
        .clamp(0, 1);
    _currentVertical = ((localPosition.dy - widget.padding.top) /
            (size.height - widget.padding.vertical))
        .clamp(0, 1);
    if (widget.reverse) {
      if (widget.sliderType == ColorSliderType.hueSat) {
        _hue = _currentHorizontal * 360;
        _saturation = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.hueVal) {
        _hue = _currentHorizontal * 360;
        _value = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.hueAlpha) {
        _hue = _currentHorizontal * 360;
        _alpha = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.satVal) {
        _saturation = _currentHorizontal;
        _value = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.satAlpha) {
        _saturation = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.valAlpha) {
        _value = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.hue) {
        _hue = _currentHorizontal * 360;
      } else if (widget.sliderType == ColorSliderType.sat) {
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == ColorSliderType.val) {
        _value = _currentHorizontal;
      } else if (widget.sliderType == ColorSliderType.alpha) {
        _alpha = _currentHorizontal;
      }
    } else {
      if (widget.sliderType == ColorSliderType.hueSat) {
        _hue = _currentVertical * 360;
        _saturation = _currentHorizontal;
      } else if (widget.sliderType == ColorSliderType.hueVal) {
        _hue = _currentVertical * 360;
        _value = _currentHorizontal;
      } else if (widget.sliderType == ColorSliderType.hueAlpha) {
        _hue = _currentVertical * 360;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == ColorSliderType.satVal) {
        _saturation = _currentVertical;
        _value = _currentHorizontal;
      } else if (widget.sliderType == ColorSliderType.satAlpha) {
        _saturation = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == ColorSliderType.valAlpha) {
        _value = _currentVertical;
        _alpha = _currentHorizontal;
      } else if (widget.sliderType == ColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == ColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.val) {
        _value = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.alpha) {
        _alpha = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.valAlpha) {
        _value = _currentHorizontal;
        _alpha = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.hue) {
        _hue = _currentVertical * 360;
      } else if (widget.sliderType == ColorSliderType.sat) {
        _saturation = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.val) {
        _value = _currentVertical;
      } else if (widget.sliderType == ColorSliderType.alpha) {
        _alpha = _currentVertical;
      }
    }
    widget.onColorChanged?.call(HSVColor.fromAHSV(
      _alpha.clamp(0, 1),
      _hue.clamp(0, 360),
      _saturation.clamp(0, 1),
      _value.clamp(0, 1),
    ));
  }

  @override
  void didUpdateWidget(covariant ColorPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      HSVColor hsv = widget.color;
      _hue = hsv.hue;
      _saturation = hsv.saturation;
      _value = hsv.value;
      _alpha = hsv.alpha;
      _currentHorizontal = horizontal;
      _currentVertical = vertical;
    }
  }

  bool get isSingleChannel {
    return widget.sliderType == ColorSliderType.hue ||
        widget.sliderType == ColorSliderType.sat ||
        widget.sliderType == ColorSliderType.val ||
        widget.sliderType == ColorSliderType.alpha;
  }

  @override
  Widget build(BuildContext context) {
    double radDiv = isSingleChannel ? 4 : 2;
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTapDown: (details) {
          _updateColor(details.localPosition, constraints.biggest);
          widget.onColorEnd?.call(HSVColor.fromAHSV(
            _alpha.clamp(0, 1),
            _hue.clamp(0, 360),
            _saturation.clamp(0, 1),
            _value.clamp(0, 1),
          ));
        },
        onPanUpdate: (details) {
          setState(() {
            _updateColor(details.localPosition, constraints.biggest);
          });
        },
        onPanEnd: (details) {
          widget.onColorEnd?.call(HSVColor.fromAHSV(
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
                    painter: CheckboardPainter(),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: RepaintBoundary(
                child: ClipRRect(
                  borderRadius: BorderRadius.all(widget.radius),
                  child: CustomPaint(
                    painter: ColorPickerPainter(
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
              // left: -(cursorRadius / 2),
              // top: -(cursorRadius / 2),
              // bottom: -(cursorRadius / 2),
              // right: -(cursorRadius / 2),
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
                                  width: 2,
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
                                  width: 2,
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
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
          ],
        ),
      );
    });
  }

  double get vertical {
    HSVColor hsv = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == ColorSliderType.hueSat) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.hueVal) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.hueAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == ColorSliderType.satVal) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.satAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == ColorSliderType.valAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == ColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.alpha) {
        return hsv.alpha;
      }
    } else {
      if (widget.sliderType == ColorSliderType.hueSat) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.hueVal) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.hueAlpha) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.satVal) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.satAlpha) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.valAlpha) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.alpha) {
        return hsv.alpha;
      }
    }
    return 0;
  }

  double get horizontal {
    HSVColor hsv = widget.color;
    if (widget.reverse) {
      if (widget.sliderType == ColorSliderType.hueSat) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.hueVal) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.hueAlpha) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.satVal) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.satAlpha) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.valAlpha) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.alpha) {
        return hsv.alpha;
      }
    } else {
      if (widget.sliderType == ColorSliderType.hueSat) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.hueVal) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.hueAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == ColorSliderType.satVal) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.satAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == ColorSliderType.valAlpha) {
        return hsv.alpha;
      } else if (widget.sliderType == ColorSliderType.hue) {
        return hsv.hue / 360;
      } else if (widget.sliderType == ColorSliderType.sat) {
        return hsv.saturation;
      } else if (widget.sliderType == ColorSliderType.val) {
        return hsv.value;
      } else if (widget.sliderType == ColorSliderType.alpha) {
        return hsv.alpha;
      }
    }
    return 0;
  }
}

class ColorPickerPainter extends CustomPainter {
  final ColorSliderType sliderType;
  final HSVColor color;
  final bool reverse;

  ColorPickerPainter({
    required this.sliderType,
    required this.color,
    this.reverse = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // disable anti-aliasing
    var pp = Paint();
    pp.isAntiAlias = false;
    var canvasHeight = size.height + 1;
    var canvasWidth = size.width + 1;
    if (sliderType == ColorSliderType.hueSat) {
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
    } else if (sliderType == ColorSliderType.hueVal) {
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
    } else if (sliderType == ColorSliderType.satVal) {
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
    } else if (sliderType == ColorSliderType.hueAlpha) {
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
    } else if (sliderType == ColorSliderType.satAlpha) {
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
    } else if (sliderType == ColorSliderType.valAlpha) {
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
    } else if (sliderType == ColorSliderType.hue) {
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
    } else if (sliderType == ColorSliderType.sat) {
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
    } else if (sliderType == ColorSliderType.val) {
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
    } else if (sliderType == ColorSliderType.alpha) {
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
  bool shouldRepaint(covariant ColorPickerPainter oldDelegate) {
    if (oldDelegate.reverse != reverse ||
        oldDelegate.sliderType != sliderType) {
      return true;
    }
    if (sliderType == ColorSliderType.hueSat) {
      return oldDelegate.color.value != color.value;
    } else if (sliderType == ColorSliderType.hueVal) {
      return oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == ColorSliderType.satVal) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == ColorSliderType.alpha) {
      return oldDelegate.color.value != color.value ||
          oldDelegate.color.saturation != color.saturation ||
          oldDelegate.color.hue != color.hue;
    } else if (sliderType == ColorSliderType.hue) {
      return oldDelegate.color.saturation != color.saturation ||
          oldDelegate.color.value != color.value;
    } else if (sliderType == ColorSliderType.sat) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.value != color.value;
    } else if (sliderType == ColorSliderType.val) {
      return oldDelegate.color.hue != color.hue ||
          oldDelegate.color.saturation != color.saturation;
    } else if (sliderType == ColorSliderType.hueAlpha) {
      return oldDelegate.color.value != color.value;
    } else if (sliderType == ColorSliderType.satAlpha) {
      return oldDelegate.color.hue != color.hue;
    } else if (sliderType == ColorSliderType.valAlpha) {
      return oldDelegate.color.hue != color.hue;
    }
    return false;
  }
}

class CheckboardPainter extends CustomPainter {
  static const Color checkboardPrimary = Color(0xFFE0E0E0);
  static const Color checkboardSecondary = Color(0xFFB0B0B0);
  static const double checkboardSize = 8.0;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = checkboardPrimary;
    canvas.drawRect(Offset.zero & size, paint);
    paint.color = checkboardSecondary;
    for (var i = 0.0; i < size.width; i += checkboardSize) {
      for (var j = 0.0; j < size.height; j += checkboardSize) {
        if ((i / checkboardSize).floor() % 2 == 0) {
          if ((j / checkboardSize).floor() % 2 == 0) {
            canvas.drawRect(
              Rect.fromLTWH(i, j, checkboardSize, checkboardSize),
              paint,
            );
          }
        } else {
          if ((j / checkboardSize).floor() % 2 != 0) {
            canvas.drawRect(
              Rect.fromLTWH(i, j, checkboardSize, checkboardSize),
              paint,
            );
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CheckboardPainter oldDelegate) => false;
}
