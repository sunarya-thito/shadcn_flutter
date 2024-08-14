import '../../../shadcn_flutter.dart';

String colorToHex(Color color, [bool showAlpha = true]) {
  if (showAlpha) {
    return '#${color.value.toRadixString(16)}';
  } else {
    return '#${color.value.toRadixString(16).substring(2)}';
  }
}

class HSVColorPicker extends StatelessWidget {
  final HSVColor color;
  final ValueChanged<HSVColor>? onChanged;
  final bool showAlpha;
  final Alignment? popoverAlignment;
  final Alignment? popoverAnchorAlignment;
  final EdgeInsets? popoverPadding;
  final Widget? placeholder;
  final PromptMode mode;
  final Widget? dialogTitle;

  const HSVColorPicker({
    Key? key,
    required this.color,
    this.onChanged,
    this.showAlpha = true,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.placeholder,
    this.mode = PromptMode.dialog,
    this.dialogTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    final theme = Theme.of(context);
    return ObjectFormField(
      dialogTitle: dialogTitle,
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      popoverPadding: popoverPadding,
      value: color,
      mode: mode,
      placeholder: placeholder ?? Text(localizations.placeholderColorPicker),
      onChanged: (value) {
        onChanged?.call(value!);
      },
      builder: (context, value) {
        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(child: Text(colorToHex(value.toColor(), showAlpha))),
              Gap(theme.scaling * 8),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: value.toColor(),
                    border: Border.all(
                      color: theme.colorScheme.border,
                    ),
                    borderRadius: theme.borderRadiusSm,
                  ),
                ),
              ),
            ],
          ),
        );
      },
      editorBuilder: (context, value, onChanged) {
        return HSVColorPickerSet(
          color: value ?? const HSVColor.fromAHSV(1, 0, 1, 1),
          onColorChanged: (value) {
            onChanged(value);
          },
          showAlpha: showAlpha,
        );
      },
    );
  }
}

Future<HSVColor> showHSVColorPicker({
  required BuildContext context,
  required HSVColor color,
  Alignment alignment = Alignment.topCenter,
  bool showAlpha = true,
  Offset? offset,
  ValueChanged<HSVColor>? onColorChanged,
}) {
  return showPopover(
    context: context,
    alignment: alignment,
    modal: false,
    offset: offset,
    builder: (context) {
      return _HSVColorPickerPopup(
        color: color,
        onColorChanged: (value) {
          color = value;
          onColorChanged?.call(value);
        },
        showAlpha: showAlpha,
      );
    },
  ).then(
    (value) {
      return color;
    },
  );
}

Future<HSLColor> showHSLColorPicker({
  required BuildContext context,
  required HSLColor color,
  Alignment alignment = Alignment.topCenter,
  bool showAlpha = true,
  Offset? offset,
  ValueChanged<HSLColor>? onColorChanged,
}) {
  final theme = Theme.of(context);
  return showPopover(
    context: context,
    alignment: alignment,
    modal: false,
    offset: offset,
    builder: (context) {
      return SizedBox(
        width: 300 * theme.scaling,
        child: _HSLColorPickerPopup(
          color: color,
          onColorChanged: (value) {
            color = value;
            onColorChanged?.call(value);
          },
          showAlpha: showAlpha,
        ),
      );
    },
  ).then(
    (value) {
      return color;
    },
  );
}

class _HSVColorPickerPopup extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onColorChanged;
  final bool showAlpha;

  const _HSVColorPickerPopup({
    Key? key,
    required this.color,
    required this.onColorChanged,
    this.showAlpha = true,
  }) : super(key: key);

  @override
  State<_HSVColorPickerPopup> createState() => _HSVColorPickerPopupState();
}

class _HSVColorPickerPopupState extends State<_HSVColorPickerPopup> {
  late HSVColor color;
  @override
  void initState() {
    super.initState();
    color = widget.color;
  }

  @override
  void didUpdateWidget(covariant _HSVColorPickerPopup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      color = widget.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: HSVColorPickerSet(
        color: color,
        onColorChanged: (value) {
          setState(() {
            color = value;
            widget.onColorChanged(value);
          });
        },
        showAlpha: widget.showAlpha,
      ),
    );
  }
}

class _HSLColorPickerPopup extends StatefulWidget {
  final HSLColor color;
  final ValueChanged<HSLColor> onColorChanged;
  final bool showAlpha;

  const _HSLColorPickerPopup({
    Key? key,
    required this.color,
    required this.onColorChanged,
    this.showAlpha = true,
  }) : super(key: key);

  @override
  State<_HSLColorPickerPopup> createState() => _HSLColorPickerPopupState();
}

class _HSLColorPickerPopupState extends State<_HSLColorPickerPopup> {
  late HSLColor color;
  @override
  void initState() {
    super.initState();
    color = widget.color;
  }

  @override
  void didUpdateWidget(covariant _HSLColorPickerPopup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
      color = widget.color;
    }
  }

  @override
  Widget build(BuildContext context) {
    return HSLColorPickerSet(
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

class HSVColorPickerSet extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor> onColorChanged;
  final bool showAlpha;

  const HSVColorPickerSet({
    Key? key,
    required this.color,
    required this.onColorChanged,
    this.showAlpha = true,
  }) : super(key: key);

  @override
  State<HSVColorPickerSet> createState() => _HSVColorPickerSetState();
}

class _HSVColorPickerSetState extends State<HSVColorPickerSet> {
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

  @override
  void didUpdateWidget(covariant HSVColorPickerSet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = ShadcnLocalizations.of(context);
    return IntrinsicHeight(
      child: Row(
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
              clipBehavior: Clip.antiAlias,
              child: HSVColorPickerArea(
                color: color,
                onColorChanged: (value) {
                  widget.onColorChanged(value);
                },
                sliderType: HSVColorSliderType.satVal,
                reverse: true,
              ),
            ),
          ),
          Gap(theme.scaling * 16),
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: theme.scaling * 32,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.border,
                      ),
                      borderRadius: BorderRadius.circular(theme.radiusLg),
                    ),
                    child: HSVColorPickerArea(
                      color: HSVColor.fromAHSV(1, color.hue, 1, 1),
                      radius: Radius.circular(theme.radiusLg),
                      onColorChanged: (value) {
                        setState(() {
                          widget.onColorChanged(HSVColor.fromAHSV(color.alpha,
                              value.hue, color.saturation, color.value));
                        });
                      },
                      sliderType: HSVColorSliderType.hue,
                      reverse: true,
                    ),
                  ),
                ),
                if (widget.showAlpha) Gap(theme.scaling * 16),
                // alpha
                if (widget.showAlpha)
                  SizedBox(
                    height: 32 * theme.scaling,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: theme.colorScheme.border,
                        ),
                        borderRadius: BorderRadius.circular(theme.radiusLg),
                      ),
                      child: HSVColorPickerArea(
                        color: color,
                        onColorChanged: (value) {
                          widget.onColorChanged(value);
                        },
                        sliderType: HSVColorSliderType.alpha,
                        radius: Radius.circular(theme.radiusLg),
                        reverse: true,
                      ),
                    ),
                  ),
                Gap(theme.scaling * 16),
                TextField(
                  controller: _hexController,
                  onEditingComplete: () {
                    var hex = _hexController.text;
                    if (hex.startsWith('#')) {
                      hex = hex.substring(1);
                    }
                    if (hex.length == 6) {
                      widget.onColorChanged(HSVColor.fromColor(
                          Color(int.parse('FF$hex', radix: 16))));
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
                Gap(theme.scaling * 16),
                Row(
                  children: [
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(localizations.colorRed),
                        Gap(theme.scaling * 4),
                        TextField(
                          controller: _redController,
                          onEditingComplete: () {
                            widget.onColorChanged(
                                HSVColor.fromColor(Color.fromRGBO(
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
                    Gap(theme.scaling * 16),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(localizations.colorGreen),
                        Gap(theme.scaling * 4),
                        TextField(
                          controller: _greenController,
                          onEditingComplete: () {
                            var cc = color.toColor();
                            widget.onColorChanged(
                                HSVColor.fromColor(Color.fromRGBO(
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
                    Gap(theme.scaling * 16),
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(localizations.colorBlue),
                        Gap(theme.scaling * 4),
                        TextField(
                          controller: _blueController,
                          onEditingComplete: () {
                            var cc = color.toColor();
                            widget.onColorChanged(
                                HSVColor.fromColor(Color.fromRGBO(
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
                      Gap(theme.scaling * 16),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(localizations.colorAlpha),
                          Gap(theme.scaling * 4),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HSLColorPickerSet extends StatefulWidget {
  final HSLColor color;
  final ValueChanged<HSLColor> onColorChanged;
  final bool showAlpha;

  const HSLColorPickerSet({
    Key? key,
    required this.color,
    required this.onColorChanged,
    this.showAlpha = true,
  }) : super(key: key);

  @override
  State<HSLColorPickerSet> createState() => _HSLColorPickerSetState();
}

class _HSLColorPickerSetState extends State<HSLColorPickerSet> {
  HSLColor get color => widget.color;
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

  @override
  void didUpdateWidget(covariant HSLColorPickerSet oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.color != widget.color) {
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
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = ShadcnLocalizations.of(context);
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
              clipBehavior: Clip.antiAlias,
              child: HSLColorPickerArea(
                color: color,
                onColorChanged: (value) {
                  widget.onColorChanged(value);
                },
                sliderType: HSLColorSliderType.satLum,
                reverse: true,
              ),
            ),
          ),
          Gap(theme.scaling * 16),
          SizedBox(
            height: theme.scaling * 32,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.border,
                ),
                borderRadius: BorderRadius.circular(theme.radiusLg),
              ),
              child: HSLColorPickerArea(
                color: HSLColor.fromAHSL(1, color.hue, 1, 0.5),
                radius: Radius.circular(theme.radiusLg),
                onColorChanged: (value) {
                  setState(() {
                    widget.onColorChanged(HSLColor.fromAHSL(color.alpha,
                        value.hue, color.saturation, color.lightness));
                  });
                },
                sliderType: HSLColorSliderType.hue,
                reverse: true,
              ),
            ),
          ),
          if (widget.showAlpha) Gap(theme.scaling * 16),
          // alpha
          if (widget.showAlpha)
            SizedBox(
              height: theme.scaling * 32,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: theme.colorScheme.border,
                  ),
                  borderRadius: BorderRadius.circular(theme.radiusLg),
                ),
                child: HSLColorPickerArea(
                  color: color,
                  onColorChanged: (value) {
                    widget.onColorChanged(value);
                  },
                  sliderType: HSLColorSliderType.alpha,
                  radius: Radius.circular(theme.radiusLg),
                  reverse: true,
                ),
              ),
            ),
          Gap(theme.scaling * 16),
          TextField(
            controller: _hexController,
            onEditingComplete: () {
              var hex = _hexController.text;
              if (hex.startsWith('#')) {
                hex = hex.substring(1);
              }
              if (hex.length == 6) {
                widget.onColorChanged(
                    HSLColor.fromColor(Color(int.parse('FF$hex', radix: 16))));
              } else if (hex.length == 8) {
                widget.onColorChanged(
                    HSLColor.fromColor(Color(int.parse(hex, radix: 16))));
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
          Gap(theme.scaling * 16),
          Row(
            children: [
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(localizations.colorRed),
                  Gap(theme.scaling * 4),
                  TextField(
                    controller: _redController,
                    onEditingComplete: () {
                      widget.onColorChanged(HSLColor.fromColor(Color.fromRGBO(
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
              Gap(theme.scaling * 16),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(localizations.colorGreen),
                  Gap(theme.scaling * 4),
                  TextField(
                    controller: _greenController,
                    onEditingComplete: () {
                      var cc = color.toColor();
                      widget.onColorChanged(HSLColor.fromColor(Color.fromRGBO(
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
              Gap(theme.scaling * 16),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(localizations.colorBlue),
                  Gap(theme.scaling * 4),
                  TextField(
                    controller: _blueController,
                    onEditingComplete: () {
                      var cc = color.toColor();
                      widget.onColorChanged(HSLColor.fromColor(Color.fromRGBO(
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
                Gap(theme.scaling * 16),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(localizations.colorAlpha),
                    Gap(theme.scaling * 4),
                    TextField(
                      onEditingComplete: () {
                        widget.onColorChanged(HSLColor.fromAHSL(
                          ((int.tryParse(_alphaController.text) ??
                                      color.toColor().alpha) /
                                  255)
                              .clamp(0, 1),
                          color.hue,
                          color.saturation,
                          color.lightness,
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

enum HSVColorSliderType {
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

enum HSLColorSliderType {
  hue,
  hueSat,
  hueLum,
  hueAlpha,
  sat,
  satLum,
  satAlpha,
  lum,
  lumAlpha,
  alpha;
}

class HSVColorPickerArea extends StatefulWidget {
  final HSVColor color;
  final ValueChanged<HSVColor>? onColorChanged;
  final ValueChanged<HSVColor>? onColorEnd;
  final HSVColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;

  const HSVColorPickerArea({
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
  State<HSVColorPickerArea> createState() => _HSVColorPickerAreaState();
}

class _HSVColorPickerAreaState extends State<HSVColorPickerArea> {
  // static const double cursorRadius = 15;
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
    widget.onColorChanged?.call(HSVColor.fromAHSV(
      _alpha.clamp(0, 1),
      _hue.clamp(0, 360),
      _saturation.clamp(0, 1),
      _value.clamp(0, 1),
    ));
  }

  @override
  void didUpdateWidget(covariant HSVColorPickerArea oldWidget) {
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
        widget.onColorEnd?.call(HSVColor.fromAHSV(
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
                  painter: HSVColorPickerPainter(
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
    HSVColor hsv = widget.color;
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
    HSVColor hsv = widget.color;
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

class HSLColorPickerArea extends StatefulWidget {
  final HSLColor color;
  final ValueChanged<HSLColor>? onColorChanged;
  final ValueChanged<HSLColor>? onColorEnd;
  final HSLColorSliderType sliderType;
  final bool reverse;
  final Radius radius;
  final EdgeInsets padding;

  const HSLColorPickerArea({
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
  State<HSLColorPickerArea> createState() => _HSLColorPickerAreaState();
}

class _HSLColorPickerAreaState extends State<HSLColorPickerArea> {
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
    widget.onColorChanged?.call(HSLColor.fromAHSL(
      _alpha.clamp(0, 1),
      _hue.clamp(0, 360),
      _saturation.clamp(0, 1),
      _lightness.clamp(0, 1),
    ));
  }

  @override
  void didUpdateWidget(covariant HSLColorPickerArea oldWidget) {
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
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onTapDown: (details) {
          _updateColor(details.localPosition, constraints.biggest);
          widget.onColorEnd?.call(HSLColor.fromAHSL(
            _alpha.clamp(0, 1),
            _hue.clamp(0, 360),
            _saturation.clamp(0, 1),
            _lightness.clamp(0, 1),
          ));
        },
        onPanUpdate: (details) {
          setState(() {
            _updateColor(details.localPosition, constraints.biggest);
          });
        },
        onPanEnd: (details) {
          widget.onColorEnd?.call(HSLColor.fromAHSL(
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
                    painter: HSLColorPickerPainter(
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
    });
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

class HSVColorPickerPainter extends CustomPainter {
  final HSVColorSliderType sliderType;
  final HSVColor color;
  final bool reverse;

  HSVColorPickerPainter({
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
  bool shouldRepaint(covariant HSVColorPickerPainter oldDelegate) {
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

class HSLColorPickerPainter extends CustomPainter {
  final HSLColorSliderType sliderType;
  final HSLColor color;
  final bool reverse;

  HSLColorPickerPainter({
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
  bool shouldRepaint(covariant HSLColorPickerPainter oldDelegate) {
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
