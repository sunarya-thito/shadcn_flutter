import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme configuration for [ColorInput] widget styling and behavior.
///
/// Defines the visual properties and default behaviors for color input components
/// including popover presentation, picker modes, and interaction features. Applied
/// globally through [ComponentTheme] or per-instance for customization.
///
/// Supports comprehensive customization of color picker appearance, positioning,
/// and functionality to match application design requirements.
class ColorInputTheme {
  /// Whether to display alpha (transparency) controls by default.
  ///
  /// When true, color pickers include alpha/opacity sliders and inputs.
  /// When false, only RGB/HSV controls are shown. Individual components
  /// can override this theme setting.
  final bool? showAlpha;

  /// Alignment point on the popover for anchor attachment.
  ///
  /// Determines where the color picker popover positions itself relative
  /// to the anchor widget. When null, uses framework default alignment.
  final AlignmentGeometry? popoverAlignment;

  /// Alignment point on the anchor widget for popover positioning.
  ///
  /// Specifies which part of the trigger widget the popover should align to.
  /// When null, uses framework default anchor alignment.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Internal padding applied to the color picker popover content.
  ///
  /// Controls spacing around the color picker interface within the popover
  /// container. When null, uses framework default padding.
  final EdgeInsetsGeometry? popoverPadding;

  /// Default interaction mode for color input triggers.
  ///
  /// Determines whether color selection opens a popover or modal dialog.
  /// When null, uses framework default prompt mode behavior.
  final PromptMode? mode;

  /// Default color picker interface type.
  ///
  /// Specifies whether to use HSV, HSL, or other color picker implementations.
  /// When null, uses framework default picker mode.
  final ColorPickerMode? pickerMode;

  /// Whether to enable screen color sampling functionality.
  ///
  /// When true, color pickers include tools to sample colors directly from
  /// the screen. Platform support varies. When null, uses framework default.
  final bool? enableEyeDropper;

  /// Whether to display color value labels in picker interfaces.
  ///
  /// When true, shows numeric color values (hex, RGB, HSV, etc.) alongside
  /// visual color pickers. When null, uses framework default label visibility.
  final bool? showLabel;

  /// The orientation of the color input layout.
  final Axis? orientation;

  /// Creates a [ColorInputTheme].
  ///
  /// All parameters are optional and fall back to framework defaults when null.
  /// The theme can be applied globally or to specific color input instances.
  const ColorInputTheme({
    this.showAlpha,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.mode,
    this.pickerMode,
    this.enableEyeDropper,
    this.showLabel,
    this.orientation,
  });

  /// Creates a copy of this theme with specified properties overridden.
  ///
  /// Each parameter function is called only if provided, allowing selective
  /// overrides while preserving existing values for unspecified properties.
  ColorInputTheme copyWith({
    ValueGetter<bool?>? showAlpha,
    ValueGetter<AlignmentGeometry?>? popoverAlignment,
    ValueGetter<AlignmentGeometry?>? popoverAnchorAlignment,
    ValueGetter<EdgeInsetsGeometry?>? popoverPadding,
    ValueGetter<PromptMode?>? mode,
    ValueGetter<ColorPickerMode?>? pickerMode,
    ValueGetter<bool?>? enableEyeDropper,
    ValueGetter<bool?>? showLabel,
    ValueGetter<Axis?>? orientation,
  }) {
    return ColorInputTheme(
      showAlpha: showAlpha == null ? this.showAlpha : showAlpha(),
      popoverAlignment:
          popoverAlignment == null ? this.popoverAlignment : popoverAlignment(),
      popoverAnchorAlignment: popoverAnchorAlignment == null
          ? this.popoverAnchorAlignment
          : popoverAnchorAlignment(),
      popoverPadding:
          popoverPadding == null ? this.popoverPadding : popoverPadding(),
      mode: mode == null ? this.mode : mode(),
      pickerMode: pickerMode == null ? this.pickerMode : pickerMode(),
      enableEyeDropper:
          enableEyeDropper == null ? this.enableEyeDropper : enableEyeDropper(),
      orientation: orientation == null ? this.orientation : orientation(),
      showLabel: showLabel == null ? this.showLabel : showLabel(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ColorInputTheme &&
        other.showAlpha == showAlpha &&
        other.popoverAlignment == popoverAlignment &&
        other.popoverAnchorAlignment == popoverAnchorAlignment &&
        other.popoverPadding == popoverPadding &&
        other.mode == mode &&
        other.pickerMode == pickerMode &&
        other.enableEyeDropper == enableEyeDropper &&
        other.orientation == orientation &&
        other.showLabel == showLabel;
  }

  @override
  int get hashCode => Object.hash(
      showAlpha,
      popoverAlignment,
      popoverAnchorAlignment,
      popoverPadding,
      mode,
      pickerMode,
      enableEyeDropper,
      orientation,
      showLabel);
}

/// A color input widget that allows users to select and edit colors.
///
/// [ColorInput] provides a comprehensive color selection interface with support
/// for multiple color spaces (HSV, HSL), alpha channel control, and eye dropper
/// functionality. The widget can be displayed in a popover or modal dialog.
///
/// The color picker supports:
/// - Multiple color representation modes (HSV, HSL)
/// - Optional alpha/opacity control
/// - Screen color sampling with eye dropper
/// - Customizable layout orientation
/// - Flexible positioning via popovers or dialogs
///
/// Example:
/// ```dart
/// ColorInput(
///   value: ColorDerivative.fromColor(Colors.blue),
///   onChanged: (color) {
///     print('Selected color: ${color.toColor()}');
///   },
///   showAlpha: true,
///   enableEyeDropper: true,
/// )
/// ```
class ColorInput extends StatefulWidget {
  /// The current color value.
  final ColorDerivative value;

  /// Called when the color is being changed (while dragging sliders, etc.).
  final ValueChanged<ColorDerivative>? onChanging;

  /// Called when the color change is complete (after releasing sliders, etc.).
  final ValueChanged<ColorDerivative>? onChanged;

  /// Whether to show alpha (opacity) controls.
  final bool? showAlpha;

  /// The initial color picker mode (HSV, HSL, etc.).
  final ColorPickerMode? initialMode;

  /// Whether to enable the eye dropper (screen color sampling) feature.
  final bool? enableEyeDropper;

  /// The alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// The alignment point on the anchor widget for popover positioning.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Internal padding for the popover content.
  final EdgeInsetsGeometry? popoverPadding;

  /// Widget displayed when no color is selected.
  final Widget? placeholder;

  /// The mode for presenting the color picker (popover or modal).
  final PromptMode? promptMode;

  /// Title widget for the dialog when using modal mode.
  final Widget? dialogTitle;

  /// Whether to show color value labels.
  final bool? showLabel;

  /// Whether the color input is enabled.
  final bool? enabled;

  /// The layout orientation of the color input.
  final Axis? orientation;

  /// Creates a [ColorInput] widget.
  const ColorInput({
    super.key,
    required this.value,
    this.onChanging,
    this.onChanged,
    this.showAlpha,
    this.initialMode,
    this.enableEyeDropper = true,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.placeholder,
    this.promptMode,
    this.dialogTitle,
    this.showLabel,
    this.orientation,
    this.enabled,
  });

  @override
  State<ColorInput> createState() => _ColorInputState();
}

class _ColorInputState extends State<ColorInput>
    with FormValueSupplier<ColorDerivative, ColorInput> {
  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant ColorInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = ShadcnLocalizations.of(context);
    final theme = Theme.of(context);
    final componentTheme = ComponentTheme.maybeOf<ColorInputTheme>(context);
    final showAlpha = styleValue(
        defaultValue: true,
        themeValue: componentTheme?.showAlpha,
        widgetValue: widget.showAlpha);
    final showLabel = styleValue(
        defaultValue: false,
        themeValue: componentTheme?.showLabel,
        widgetValue: widget.showLabel);
    final popoverAlignment = styleValue(
        themeValue: componentTheme?.popoverAlignment,
        widgetValue: widget.popoverAlignment,
        defaultValue: Alignment.topCenter);
    final popoverAnchorAlignment = styleValue(
        themeValue: componentTheme?.popoverAnchorAlignment,
        widgetValue: widget.popoverAnchorAlignment,
        defaultValue: Alignment.bottomCenter);
    final popoverPadding = styleValue(
        themeValue: componentTheme?.popoverPadding,
        widgetValue: widget.popoverPadding,
        defaultValue: null);
    final promptMode = styleValue(
        themeValue: componentTheme?.mode,
        widgetValue: widget.promptMode,
        defaultValue: PromptMode.popover);
    final enableEyeDropper = styleValue(
        defaultValue: true,
        themeValue: componentTheme?.enableEyeDropper,
        widgetValue: widget.enableEyeDropper);
    final initialMode = styleValue(
        themeValue: componentTheme?.pickerMode,
        widgetValue: widget.initialMode,
        defaultValue: ColorPickerMode.rgb);
    final orientation = styleValue(
        defaultValue: null,
        themeValue: componentTheme?.orientation,
        widgetValue: widget.orientation);
    return ObjectFormField(
      value: widget.value,
      placeholder: widget.placeholder ?? Text(locale.placeholderColorPicker),
      onChanged: (color) {
        if (color != null) {
          widget.onChanged?.call(color);
        }
      },
      dialogTitle: widget.dialogTitle,
      popoverAlignment: popoverAlignment,
      popoverAnchorAlignment: popoverAnchorAlignment,
      popoverPadding: popoverPadding,
      mode: promptMode,
      enabled: widget.enabled,
      builder: (context, value) {
        if (!showLabel) {
          return Container(
            decoration: BoxDecoration(
              color: value.toColor(),
              borderRadius: BorderRadius.circular(theme.radiusSm),
              border: Border.all(color: theme.colorScheme.border),
            ),
          );
        }
        return IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(child: Text(colorToHex(value.toColor(), showAlpha))),
              Gap(8 * theme.scaling),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: value.toColor(),
                    borderRadius: BorderRadius.circular(theme.radiusSm),
                    border: Border.all(color: theme.colorScheme.border),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      dialogActions: (innerContext, handler) {
        return [
          if (enableEyeDropper)
            IconButton.outline(
              icon: Icon(LucideIcons.pipette, size: 16 * theme.scaling),
              onPressed: () async {
                await handler.close();
                if (!context.mounted) return;
                final result = await pickColorFromScreen(context);
                if (result != null && context.mounted) {
                  ColorHistoryStorage.of(context).addHistory(result);
                }
                handler.prompt(
                    result != null ? ColorDerivative.fromColor(result) : null);
              },
            ),
        ];
      },
      editorBuilder: (context, handler) {
        return ColorPicker(
          value: handler.value!,
          enableEyeDropper: enableEyeDropper,
          onChanging: (color) {
            widget.onChanging?.call(color);
          },
          onChanged: (color) {
            handler.value = color;
          },
          initialMode: initialMode,
          onEyeDropperRequested: () async {
            await handler.close();
            if (!context.mounted) return;
            final result = await pickColorFromScreen(context);
            if (result != null && context.mounted) {
              ColorHistoryStorage.of(context).addHistory(result);
            }
            handler.prompt(
                result != null ? ColorDerivative.fromColor(result) : null);
          },
          orientation: orientation,
          showAlpha: showAlpha,
        );
      },
    );
  }

  @override
  void didReplaceFormValue(ColorDerivative value) {
    widget.onChanged?.call(value);
  }
}

/// Reactive controller for managing color input state with color operations.
///
/// Extends [ValueNotifier] to provide state management for color input widgets
/// using [ColorDerivative] values that support multiple color space representations.
/// Enables programmatic color changes while maintaining color space fidelity.
///
/// The controller manages [ColorDerivative] objects which preserve original
/// color space information (HSV, HSL, RGB) for accurate color manipulations
/// and prevents precision loss during color space conversions.
///
/// Example:
/// ```dart
/// final controller = ColorInputController(
///   ColorDerivative.fromColor(Colors.blue),
/// );
///
/// // React to changes
/// controller.addListener(() {
///   print('Color changed to: ${controller.value.color}');
/// });
///
/// // Programmatic control
/// controller.value = ColorDerivative.fromHSV(HSVColor.fromColor(Colors.red));
/// ```
class ColorInputController extends ValueNotifier<ColorDerivative>
    with ComponentController<ColorDerivative> {
  /// Creates a [ColorInputController] with the specified initial color.
  ///
  /// The [value] parameter provides the initial color as a [ColorDerivative].
  /// The controller notifies listeners when the color changes through any
  /// method calls or direct value assignment.
  ///
  /// Example:
  /// ```dart
  /// final controller = ColorInputController(
  ///   ColorDerivative.fromColor(Colors.green),
  /// );
  /// ```
  ColorInputController(super.value);

  /// Sets the color to a new [Color] value.
  ///
  /// Converts the color to a [ColorDerivative] preserving RGB color space
  /// information. Notifies listeners of the change.
  void setColor(Color color) {
    value = ColorDerivative.fromColor(color);
  }

  /// Sets the color to a new HSV color value.
  ///
  /// Uses [ColorDerivative.fromHSV] to preserve HSV color space information
  /// for accurate hue, saturation, and value manipulations.
  void setHSVColor(HSVColor hsvColor) {
    value = ColorDerivative.fromHSV(hsvColor);
  }

  /// Sets the color to a new HSL color value.
  ///
  /// Uses [ColorDerivative.fromHSL] to preserve HSL color space information
  /// for accurate hue, saturation, and lightness manipulations.
  void setHSLColor(HSLColor hslColor) {
    value = ColorDerivative.fromHSL(hslColor);
  }

  /// Gets the current color as a standard [Color] object.
  Color get color => value.toColor();

  /// Gets the current color as an HSV color representation.
  HSVColor get hsvColor => value.toHSVColor();

  /// Gets the current color as an HSL color representation.
  HSLColor get hslColor => value.toHSLColor();
}

/// A controlled color input widget integrating with form state management.
///
/// Implements [ControlledComponent] to provide automatic form integration,
/// validation, and state management for color selection.
class ControlledColorInput extends StatelessWidget
    with ControlledComponent<ColorDerivative> {
  @override
  final ColorDerivative initialValue;

  @override
  final ValueChanged<ColorDerivative>? onChanged;

  @override
  final bool enabled;

  @override
  final ColorInputController? controller;

  /// Whether to show alpha channel controls.
  final bool? showAlpha;

  /// Alignment of the popover relative to the anchor.
  final AlignmentGeometry? popoverAlignment;

  /// Anchor alignment for the popover.
  final AlignmentGeometry? popoverAnchorAlignment;

  /// Padding inside the popover.
  final EdgeInsetsGeometry? popoverPadding;

  /// Placeholder widget when no color is selected.
  final Widget? placeholder;

  /// The prompt display mode for the color picker.
  final PromptMode? promptMode;

  /// Title widget for the dialog mode.
  final Widget? dialogTitle;

  /// Whether to show color labels.
  final bool? showLabel;

  /// Orientation of color controls.
  final Axis? orientation;

  /// Whether to enable the eye dropper tool.
  final bool? enableEyeDropper;

  /// The initial color picker mode to display.
  final ColorPickerMode? initialMode;

  /// Callback invoked while the color is being changed (live updates).
  final ValueChanged<ColorDerivative>? onChanging;

  /// Creates a controlled color input.
  const ControlledColorInput({
    super.key,
    required this.initialValue,
    this.onChanged,
    this.enabled = true,
    this.controller,
    this.showAlpha,
    this.popoverAlignment,
    this.popoverAnchorAlignment,
    this.popoverPadding,
    this.placeholder,
    this.promptMode,
    this.dialogTitle,
    this.showLabel,
    this.orientation,
    this.enableEyeDropper,
    this.initialMode,
    this.onChanging,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter<ColorDerivative>(
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      controller: controller,
      builder: (context, data) {
        return ColorInput(
          value: data.value,
          onChanged: data.onChanged,
          enableEyeDropper: enableEyeDropper,
          initialMode: initialMode,
          onChanging: onChanging,
          showAlpha: showAlpha,
          popoverAlignment: popoverAlignment,
          popoverAnchorAlignment: popoverAnchorAlignment,
          popoverPadding: popoverPadding,
          placeholder: placeholder,
          promptMode: promptMode,
          dialogTitle: dialogTitle,
          showLabel: showLabel,
          orientation: orientation,
          enabled: data.enabled,
        );
      },
    );
  }
}
