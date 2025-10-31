import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Defines the color representation mode for color pickers.
///
/// Specifies which color model and input controls to display in the color picker
/// interface. Each mode provides different controls optimized for that color space.
enum ColorPickerMode {
  /// RGB (Red, Green, Blue) color mode.
  rgb,

  /// HSL (Hue, Saturation, Lightness) color mode.
  hsl,

  /// HSV (Hue, Saturation, Value) color mode.
  hsv,

  /// Hexadecimal color code mode.
  hex,
}

/// Defines available slider types for HSV color pickers.
///
/// Each slider type controls different aspects of the HSV color model,
/// allowing fine-tuned control over hue, saturation, value, and alpha channels.
enum HSVColorSliderType {
  /// Hue slider only.
  hue,

  /// Combined hue and saturation slider.
  hueSat,

  /// Combined hue and value slider.
  hueVal,

  /// Combined hue and alpha slider.
  hueAlpha,

  /// Saturation slider only.
  sat,

  /// Combined saturation and value slider.
  satVal,

  /// Combined saturation and alpha slider.
  satAlpha,

  /// Value (brightness) slider only.
  val,

  /// Combined value and alpha slider.
  valAlpha,

  /// Alpha (opacity) slider only.
  alpha;
}

/// Defines available slider types for HSL color pickers.
///
/// Each slider type controls different aspects of the HSL color model,
/// allowing fine-tuned control over hue, saturation, luminance, and alpha channels.
enum HSLColorSliderType {
  /// Hue slider only.
  hue,

  /// Combined hue and saturation slider.
  hueSat,

  /// Combined hue and luminance slider.
  hueLum,

  /// Combined hue and alpha slider.
  hueAlpha,

  /// Saturation slider only.
  sat,

  /// Combined saturation and luminance slider.
  satLum,

  /// Combined saturation and alpha slider.
  satAlpha,

  /// Luminance (lightness) slider only.
  lum,

  /// Combined luminance and alpha slider.
  lumAlpha,

  /// Alpha (opacity) slider only.
  alpha;
}

/// Theme configuration for [ColorPicker] widget styling and layout.
///
/// Defines visual and layout properties for color picker components including
/// spacing, orientation, and feature availability. Applied globally through
/// [ComponentTheme] or per-instance.
class ColorPickerTheme {
  /// Spacing between major color picker sections.
  final double? spacing;

  /// Spacing between individual controls within sections.
  final double? controlSpacing;

  /// Layout orientation (horizontal or vertical).
  final Axis? orientation;

  /// Whether to enable the eye dropper feature.
  final bool? enableEyeDropper;

  /// The size of color sliders.
  final double? sliderSize;

  /// Creates a [ColorPickerTheme].
  const ColorPickerTheme({
    this.spacing,
    this.controlSpacing,
    this.orientation,
    this.enableEyeDropper,
    this.sliderSize,
  });

  /// Creates a copy of this theme with specified properties overridden.
  ColorPickerTheme copyWith({
    ValueGetter<double?>? spacing,
    ValueGetter<double?>? controlSpacing,
    ValueGetter<Axis?>? orientation,
    ValueGetter<bool?>? enableEyeDropper,
    ValueGetter<double?>? sliderSize,
  }) {
    return ColorPickerTheme(
      spacing: spacing == null ? this.spacing : spacing(),
      controlSpacing:
          controlSpacing == null ? this.controlSpacing : controlSpacing(),
      orientation: orientation == null ? this.orientation : orientation(),
      enableEyeDropper:
          enableEyeDropper == null ? this.enableEyeDropper : enableEyeDropper(),
      sliderSize: sliderSize == null ? this.sliderSize : sliderSize(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ColorPickerTheme &&
        other.spacing == spacing &&
        other.controlSpacing == controlSpacing &&
        other.orientation == orientation &&
        other.sliderSize == sliderSize &&
        other.enableEyeDropper == enableEyeDropper;
  }

  @override
  int get hashCode => Object.hash(
      spacing, controlSpacing, orientation, enableEyeDropper, sliderSize);
}

/// A comprehensive color picker widget with multiple color mode support.
///
/// [ColorPicker] provides an interactive interface for selecting colors using
/// various color representation models (RGB, HSL, HSV, HEX). It supports alpha
/// channel control, eye dropper functionality, and customizable layout.
///
/// Features:
/// - Multiple color modes (RGB, HSL, HSV, HEX)
/// - Optional alpha/opacity control
/// - Screen color sampling with eye dropper
/// - Flexible layout orientation
/// - Real-time color updates
/// - Mode switching during use
///
/// Example:
/// ```dart
/// ColorPicker(
///   value: ColorDerivative.fromColor(Colors.blue),
///   onChanged: (color) {
///     print('Selected: ${color.toColor()}');
///   },
///   showAlpha: true,
///   initialMode: ColorPickerMode.hsv,
///   enableEyeDropper: true,
/// )
/// ```
class ColorPicker extends StatefulWidget {
  /// The current color value.
  final ColorDerivative value;

  /// Called when the color is finalized.
  final ValueChanged<ColorDerivative>? onChanged;

  /// Called continuously while the color is being changed.
  final ValueChanged<ColorDerivative>? onChanging;

  /// Whether to show alpha (opacity) controls.
  final bool showAlpha;

  /// The initial color picker mode.
  final ColorPickerMode initialMode;

  /// Called when the color picker mode changes.
  final ValueChanged<ColorPickerMode>? onModeChanged;

  /// Called when the eye dropper button is pressed.
  final VoidCallback? onEyeDropperRequested;

  /// Whether to enable the eye dropper feature.
  final bool? enableEyeDropper;

  /// Layout orientation of the color picker.
  final Axis? orientation;

  /// Spacing between major sections.
  final double? spacing;

  /// Spacing between individual controls.
  final double? controlSpacing;

  /// Size of the color sliders.
  final double? sliderSize;

  /// Creates a [ColorPicker] widget.
  const ColorPicker({
    super.key,
    required this.value,
    this.onChanged,
    this.onChanging,
    this.showAlpha = false,
    this.initialMode = ColorPickerMode.rgb,
    this.onModeChanged,
    this.enableEyeDropper,
    this.onEyeDropperRequested,
    this.orientation,
    this.spacing,
    this.controlSpacing,
    this.sliderSize,
  });

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late ColorPickerMode _mode;

  ColorDerivative? _changingValue;

  @override
  void initState() {
    super.initState();
    _mode = widget.initialMode;
  }

  ColorDerivative get _effectiveValue {
    return _changingValue ?? widget.value;
  }

  void _onChanging(ColorDerivative value) {
    setState(() {
      _changingValue = value;
      widget.onChanging?.call(value);
    });
  }

  void _onChanged(ColorDerivative value) {
    setState(() {
      _changingValue = null;
      widget.onChanged?.call(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final componentTheme = ComponentTheme.maybeOf<ColorPickerTheme>(context);
    final direction = styleValue(
        defaultValue: Axis.vertical,
        themeValue: componentTheme?.orientation,
        widgetValue: widget.orientation);
    final spacing = styleValue(
        defaultValue: 12.0,
        themeValue: componentTheme?.spacing,
        widgetValue: widget.spacing);
    final controlSpacing = styleValue(
      defaultValue: 8.0,
      themeValue: componentTheme?.controlSpacing,
      widgetValue: widget.controlSpacing,
    );
    final orientation = styleValue(
        defaultValue: Axis.vertical,
        themeValue: componentTheme?.orientation,
        widgetValue: widget.orientation);

    var colorControls = ColorControls(
      value: _effectiveValue,
      onChanged: _onChanged,
      onChanging: _onChanging,
      showAlpha: widget.showAlpha,
      mode: _mode,
      onModeChanged: (mode) {
        setState(() {
          _mode = mode;
        });
        widget.onModeChanged?.call(mode);
      },
      controlSpacing: styleValue(
        defaultValue: 8.0,
        themeValue: componentTheme?.controlSpacing,
        widgetValue: widget.controlSpacing,
      ),
    );
    var content = Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: spacing,
      children: [
        Flexible(
          child: AspectRatio(
            aspectRatio: 1.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: 250.0 * theme.scaling,
                minWidth: 250.0 * theme.scaling,
              ),
              child: buildSlider(context),
            ),
          ),
        ),
        if (direction == Axis.horizontal)
          ...buildSliders(context)
        else
          IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: controlSpacing,
              children: [
                if (direction == Axis.vertical) ...buildSliders(context),
                colorControls,
              ],
            ),
          ),
      ],
    );
    if (orientation == Axis.horizontal) {
      return IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: spacing,
          children: [
            IntrinsicHeight(child: content),
            colorControls,
          ],
        ),
      );
    }
    return IntrinsicWidth(child: content);
  }

  List<Widget> buildSliders(BuildContext context) {
    final componentTheme = ComponentTheme.maybeOf<ColorPickerTheme>(context);
    final sliderSize = styleValue(
      defaultValue: 24.0,
      themeValue: componentTheme?.sliderSize,
      widgetValue: widget.sliderSize,
    );
    final orientation = styleValue(
        defaultValue: Axis.vertical,
        themeValue: componentTheme?.orientation,
        widgetValue: widget.orientation);
    return [
      SizedBox(
        height: orientation == Axis.vertical ? sliderSize : null,
        width: orientation == Axis.horizontal ? sliderSize : null,
        child: HSVColorSlider(
          reverse: orientation == Axis.vertical,
          radius: Theme.of(context).radiusSmRadius,
          value:
              _effectiveValue.toHSVColor().withSaturation(1.0).withValue(1.0),
          onChanging: (hsvColor) {
            final hue = hsvColor.hue;
            _onChanging(
              _effectiveValue.changeToHSVHue(hue),
            );
          },
          onChanged: (hsvColor) {
            final hue = hsvColor.hue;
            _onChanged(
              _effectiveValue.changeToHSVHue(hue),
            );
          },
          sliderType: HSVColorSliderType.hue,
        ),
      ),
      if (widget.showAlpha)
        SizedBox(
          height: orientation == Axis.vertical ? sliderSize : null,
          width: orientation == Axis.horizontal ? sliderSize : null,
          child: HSVColorSlider(
            reverse: orientation == Axis.vertical,
            radius: Theme.of(context).radiusSmRadius,
            value: _effectiveValue.toHSVColor(),
            onChanging: (hsvColor) {
              final alpha = hsvColor.alpha;
              _onChanging(
                _effectiveValue.changeToOpacity(alpha),
              );
            },
            onChanged: (hsvColor) {
              final alpha = hsvColor.alpha;
              _onChanged(
                _effectiveValue.changeToOpacity(alpha),
              );
            },
            sliderType: HSVColorSliderType.alpha,
          ),
        ),
    ];
  }

  Widget buildSlider(BuildContext context) {
    return switch (widget.initialMode) {
      ColorPickerMode.hsl => buildHSLSlider(context),
      _ => buildHSVSlider(context),
    };
  }

  Widget buildHSVSlider(BuildContext context) {
    return HSVColorSlider(
      value: _effectiveValue.toHSVColor(),
      sliderType: HSVColorSliderType.satVal,
      radius: Theme.of(context).radiusSmRadius,
      onChanging: (hsvColor) {
        final sat = hsvColor.saturation;
        final val = hsvColor.value;
        _onChanging(
          _effectiveValue.changeToHSVSaturation(sat).changeToHSVValue(val),
        );
      },
      onChanged: (hsvColor) {
        final sat = hsvColor.saturation;
        final val = hsvColor.value;
        _onChanged(
          _effectiveValue.changeToHSVSaturation(sat).changeToHSVValue(val),
        );
      },
    );
  }

  Widget buildHSLSlider(BuildContext context) {
    return HSLColorSlider(
      color: _effectiveValue.toHSLColor(),
      sliderType: HSLColorSliderType.satLum,
      radius: Theme.of(context).radiusSmRadius,
      onChanging: (hslColor) {
        final sat = hslColor.saturation;
        final light = hslColor.lightness;
        _onChanging(
          _effectiveValue
              .changeToHSLSaturation(sat)
              .changeToHSLLightness(light),
        );
      },
      onChanged: (hslColor) {
        final sat = hslColor.saturation;
        final light = hslColor.lightness;
        _onChanged(
          _effectiveValue
              .changeToHSLSaturation(sat)
              .changeToHSLLightness(light),
        );
      },
    );
  }
}

/// Widget providing color input controls with multiple color space modes.
///
/// Displays inputs for editing colors in RGB, HSL, HSV, or HEX formats
/// with optional alpha channel and eye dropper tool support.
class ColorControls extends StatelessWidget {
  /// The current color value.
  final ColorDerivative value;

  /// Callback invoked when the color is changed.
  final ValueChanged<ColorDerivative>? onChanged;

  /// Callback invoked while the color is being changed (live updates).
  final ValueChanged<ColorDerivative>? onChanging;

  /// Callback invoked when the color picker mode changes.
  final ValueChanged<ColorPickerMode>? onModeChanged;

  /// Whether to show alpha channel controls.
  final bool showAlpha;

  /// The current color picker mode (RGB, HSL, HSV, or HEX).
  final ColorPickerMode mode;

  /// Spacing between control elements.
  final double? controlSpacing;

  /// Whether to enable the eye dropper tool.
  final bool? enableEyeDropper;

  /// Callback invoked when the eye dropper tool is requested.
  final VoidCallback? onEyeDropperRequested;

  /// Creates color controls.
  const ColorControls({
    super.key,
    required this.value,
    this.onChanged,
    this.onChanging,
    this.onModeChanged,
    this.showAlpha = false,
    this.mode = ColorPickerMode.rgb,
    this.enableEyeDropper,
    this.onEyeDropperRequested,
    this.controlSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = ComponentTheme.maybeOf<ColorPickerTheme>(context);
    final locale = ShadcnLocalizations.of(context);
    final enableEyeDropper = styleValue(
        defaultValue: true,
        themeValue: theme?.enableEyeDropper,
        widgetValue: this.enableEyeDropper);
    final controlSpacing = styleValue(
      defaultValue: 8.0,
      themeValue: theme?.controlSpacing,
      widgetValue: this.controlSpacing,
    );
    String pickerModeToLabel(ColorPickerMode mode) {
      switch (mode) {
        case ColorPickerMode.rgb:
          return locale.colorPickerTabRGB;
        case ColorPickerMode.hsl:
          return locale.colorPickerTabHSL;
        case ColorPickerMode.hsv:
          return locale.colorPickerTabHSV;
        case ColorPickerMode.hex:
          return locale.colorPickerTabHEX;
      }
    }

    return IntrinsicHeight(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: controlSpacing,
        children: [
          if (enableEyeDropper)
            IconButton.outline(
              icon: const Icon(Icons.colorize),
              onPressed: onEyeDropperRequested ??
                  () async {
                    final result = await pickColorFromScreen(context);
                    if (result != null) {
                      onChanged?.call(ColorDerivative.fromColor(result));
                      if (context.mounted) {
                        ColorHistoryStorage.of(context).addHistory(result);
                      }
                    }
                  },
            ),
          Flexible(
            child: ButtonGroup.horizontal(
              expands: true,
              children: [
                Flexible(
                  child: Select<ColorPickerMode>(
                    value: mode,
                    itemBuilder: (context, value) {
                      return Text(pickerModeToLabel(value));
                    },
                    onChanged: (mode) {
                      if (mode != null) {
                        onModeChanged?.call(mode);
                      }
                    },
                    popup: SelectPopup.noVirtualization(
                      items: SelectItemList(children: [
                        for (var mode in ColorPickerMode.values)
                          SelectItemButton(
                              value: mode,
                              child: Text(pickerModeToLabel(mode))),
                      ]),
                    ).call,
                  ),
                ),
                ...buildInputs(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the input widgets based on the current color picker mode.
  List<Widget> buildInputs(BuildContext context) {
    return switch (mode) {
      ColorPickerMode.rgb => buildRGBInputs(context),
      ColorPickerMode.hsl => buildHSLInputs(context),
      ColorPickerMode.hsv => buildHSVInputs(context),
      ColorPickerMode.hex => buildHEXInputs(context),
    };
  }

  void Function(String value) _onInputChanged(
      void Function(double val) changer) {
    return (String value) {
      final parsed = double.tryParse(value);
      if (parsed != null) {
        changer(parsed);
      }
    };
  }

  /// Builds RGB color input widgets.
  List<Widget> buildRGBInputs(BuildContext context) {
    final locale = ShadcnLocalizations.of(context);
    return [
      // _ColorValueInput ensures that when the value changes from outside,
      // the input reflects the latest value unless focused, and only emits
      // onChanged while focused to avoid feedback loops.
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorRed),
          keyboardType: TextInputType.number,
          value: value.red.toInt().toString(),
          onChanged: _onInputChanged((val) {
            final r = val.clamp(0.0, 255.0);
            onChanged?.call(value.changeToColorRed(r));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 255),
          ],
        ),
      ),
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorGreen),
          keyboardType: TextInputType.number,
          value: value.green.toInt().toString(),
          onChanged: _onInputChanged((val) {
            final g = val.clamp(0.0, 255.0);
            onChanged?.call(value.changeToColorGreen(g));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 255),
          ],
        ),
      ),
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorBlue),
          keyboardType: TextInputType.number,
          value: value.blue.toInt().toString(),
          onChanged: _onInputChanged((val) {
            final b = val.clamp(0.0, 255.0);
            onChanged?.call(value.changeToColorBlue(b));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 255),
          ],
        ),
      ),
      if (showAlpha)
        SizedBox(
          width: 64,
          child: _ColorValueInput(
            placeholder: Text(locale.colorAlpha),
            keyboardType: TextInputType.number,
            value: (value.opacity * 255).toInt().toString(),
            onChanged: _onInputChanged((val) {
              final a = val.clamp(0.0, 255.0) / 255.0;
              onChanged?.call(value.changeToOpacity(a));
            }),
            inputFormatters: [
              TextInputFormatters.integerOnly(min: 0, max: 255),
            ],
          ),
        ),
    ];
  }

  /// Builds HSL color input widgets.
  List<Widget> buildHSLInputs(BuildContext context) {
    final locale = ShadcnLocalizations.of(context);
    return [
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorHue),
          keyboardType: TextInputType.number,
          value: value.hslHue.toInt().toString(),
          onChanged: _onInputChanged((val) {
            final h = val.clamp(0.0, 360.0);
            onChanged?.call(value.changeToHSLHue(h));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 360),
          ],
        ),
      ),
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorSaturation),
          keyboardType: TextInputType.number,
          value: (value.hslSat * 100).toInt().toString(),
          onChanged: _onInputChanged((val) {
            final s = (val.clamp(0.0, 100.0)) / 100.0;
            onChanged?.call(value.changeToHSLSaturation(s));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 100),
          ],
        ),
      ),
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorLightness),
          keyboardType: TextInputType.number,
          value: (value.hslVal * 100).toInt().toString(),
          onChanged: _onInputChanged((val) {
            final l = (val.clamp(0.0, 100.0)) / 100.0;
            onChanged?.call(value.changeToHSLLightness(l));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 100),
          ],
        ),
      ),
      if (showAlpha)
        SizedBox(
          width: 64,
          child: _ColorValueInput(
            placeholder: Text(locale.colorAlpha),
            keyboardType: TextInputType.number,
            value: (value.opacity * 100).toInt().toString(),
            onChanged: _onInputChanged((val) {
              final a = (val.clamp(0.0, 100.0)) / 100.0;
              onChanged?.call(value.changeToOpacity(a));
            }),
            inputFormatters: [
              TextInputFormatters.integerOnly(min: 0, max: 100),
            ],
          ),
        ),
    ];
  }

  /// Builds HSV color input widgets.
  List<Widget> buildHSVInputs(BuildContext context) {
    final locale = ShadcnLocalizations.of(context);
    return [
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorHue),
          keyboardType: TextInputType.number,
          value: value.hsvHue.toInt().toString(),
          onChanged: _onInputChanged((val) {
            final h = val.clamp(0.0, 360.0);
            onChanged?.call(value.changeToHSVHue(h));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 360),
          ],
        ),
      ),
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorSaturation),
          keyboardType: TextInputType.number,
          value: (value.hsvSat * 100).toInt().toString(),
          onChanged: _onInputChanged((val) {
            final s = (val.clamp(0.0, 100.0)) / 100.0;
            onChanged?.call(value.changeToHSVSaturation(s));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 100),
          ],
        ),
      ),
      SizedBox(
        width: 64,
        child: _ColorValueInput(
          placeholder: Text(locale.colorValue),
          keyboardType: TextInputType.number,
          value: (value.hsvVal * 100).toInt().toString(),
          onChanged: _onInputChanged((val) {
            final v = (val.clamp(0.0, 100.0)) / 100.0;
            onChanged?.call(value.changeToHSVValue(v));
          }),
          inputFormatters: [
            TextInputFormatters.integerOnly(min: 0, max: 100),
          ],
        ),
      ),
      if (showAlpha)
        SizedBox(
          width: 64,
          child: _ColorValueInput(
            placeholder: Text(locale.colorAlpha),
            keyboardType: TextInputType.number,
            value: (value.opacity * 100).toInt().toString(),
            onChanged: _onInputChanged((val) {
              final a = (val.clamp(0.0, 100.0)) / 100.0;
              onChanged?.call(value.changeToOpacity(a));
            }),
            inputFormatters: [
              TextInputFormatters.integerOnly(min: 0, max: 100),
            ],
          ),
        ),
    ];
  }

  String _toHex() {
    int r = value.red.toInt();
    int g = value.green.toInt();
    int b = value.blue.toInt();
    return '#${r.toRadixString(16).padLeft(2, '0')}${g.toRadixString(16).padLeft(2, '0')}${b.toRadixString(16).padLeft(2, '0')}';
  }

  /// Builds HEX color input widgets.
  List<Widget> buildHEXInputs(BuildContext context) {
    final locale = ShadcnLocalizations.of(context);
    return [
      SizedBox(
        width: 100,
        child: _ColorValueInput(
          placeholder: Text(locale.colorPickerTabHEX),
          keyboardType: TextInputType.text,
          value: _toHex(),
          onChanged: (val) {
            var hex = val.trim();
            if (hex.startsWith('#')) {
              hex = hex.substring(1);
            }
            if (hex.length == 6) {
              final r = int.parse(hex.substring(0, 2), radix: 16);
              final g = int.parse(hex.substring(2, 4), radix: 16);
              final b = int.parse(hex.substring(4, 6), radix: 16);
              onChanged?.call(
                value
                    .changeToColorRed(r.toDouble())
                    .changeToColorGreen(g.toDouble())
                    .changeToColorBlue(b.toDouble()),
              );
            }
          },
          inputFormatters: [
            TextInputFormatters.hex(hashPrefix: true),
          ],
        ),
      ),
      if (showAlpha)
        SizedBox(
          width: 64,
          child: _ColorValueInput(
            placeholder: Text(locale.colorAlpha),
            keyboardType: TextInputType.number,
            value: (value.opacity * 100).toInt().toString(),
            onChanged: _onInputChanged((val) {
              final a = (val.clamp(0.0, 100.0)) / 100.0;
              onChanged?.call(value.changeToOpacity(a));
            }),
            inputFormatters: [
              TextInputFormatters.integerOnly(min: 0, max: 100),
            ],
          ),
        ),
    ];
  }
}

// Removed _FocusBuilder in favor of _ColorValueInput which internally
// handles focus state and onChanged gating.

class _ColorValueInput extends StatefulWidget {
  final String value;
  final Widget? placeholder;
  final ValueChanged<String>? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  const _ColorValueInput({
    required this.value,
    this.placeholder,
    this.onChanged,
    this.inputFormatters,
    this.keyboardType,
  });

  @override
  State<_ColorValueInput> createState() => _ColorValueInputState();
}

class _ColorValueInputState extends State<_ColorValueInput> {
  late TextEditingController _controller;
  bool _focused = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant _ColorValueInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value && !_focused) {
      _controller.text = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focused) {
        setState(() {
          _focused = focused;
        });
      },
      child: TextField(
        placeholder: widget.placeholder,
        keyboardType: widget.keyboardType,
        controller: _controller,
        onChanged: widget.onChanged != null
            ? (val) {
                if (_focused) {
                  widget.onChanged!(val);
                }
              }
            : null,
        inputFormatters: widget.inputFormatters,
      ),
    );
  }
}
