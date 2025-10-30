import '../../../shadcn_flutter.dart';

/// Theme data for customizing [Radio] widget appearance.
///
/// This class defines the visual properties that can be applied to
/// [Radio] widgets, including colors for different states and sizing.
/// These properties can be set at the theme level to provide consistent
/// styling across the application.
///
/// The theme affects the radio button's visual appearance in both
/// selected and unselected states, including border, background,
/// and active indicator colors.
class RadioTheme {
  /// Color of the radio indicator when selected.
  final Color? activeColor;

  /// Border color of the radio button.
  final Color? borderColor;

  /// Background color of the radio button.
  final Color? backgroundColor;

  /// Size of the radio button.
  final double? size;

  /// Creates a [RadioTheme].
  ///
  /// Parameters:
  /// - [activeColor] (`Color?`, optional): Selected indicator color.
  /// - [borderColor] (`Color?`, optional): Border color.
  /// - [backgroundColor] (`Color?`, optional): Background color.
  /// - [size] (`double?`, optional): Radio button size.
  const RadioTheme(
      {this.activeColor, this.borderColor, this.size, this.backgroundColor});

  /// Creates a copy of this theme with the given fields replaced.
  ///
  /// Parameters:
  /// - [activeColor] (`ValueGetter<Color?>?`, optional): New active color.
  /// - [borderColor] (`ValueGetter<Color?>?`, optional): New border color.
  /// - [backgroundColor] (`ValueGetter<Color?>?`, optional): New background color.
  /// - [size] (`ValueGetter<double?>?`, optional): New size.
  ///
  /// Returns: A new [RadioTheme] with updated properties.
  RadioTheme copyWith({
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? borderColor,
    ValueGetter<double?>? size,
    ValueGetter<Color?>? backgroundColor,
  }) {
    return RadioTheme(
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
      size: size == null ? this.size : size(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioTheme &&
        other.activeColor == activeColor &&
        other.borderColor == borderColor &&
        other.size == size &&
        other.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode =>
      Object.hash(activeColor, borderColor, size, backgroundColor);
}

/// A radio button widget that displays a circular selection indicator.
///
/// [Radio] provides a visual representation of a selectable option within
/// a radio group. It displays as a circular button with an inner dot when
/// selected and an empty circle when unselected. The widget supports focus
/// indication and customizable colors and sizing.
///
/// The radio button animates smoothly between selected and unselected states,
/// providing visual feedback to user interactions. It integrates with the
/// focus system to provide accessibility support and keyboard navigation.
///
/// Typically used within [RadioItem] or [RadioGroup] components rather than
/// standalone, as it only provides the visual representation without the
/// interaction logic.
///
/// Example:
/// ```dart
/// Radio(
///   value: isSelected,
///   focusing: hasFocus,
///   size: 20,
///   activeColor: Colors.blue,
/// );
/// ```
class Radio extends StatelessWidget {
  /// Whether this radio button is selected.
  ///
  /// When true, displays the inner selection indicator.
  /// When false, shows only the outer circle border.
  final bool value;

  /// Whether this radio button currently has focus.
  ///
  /// When true, displays a focus outline around the radio button
  /// for accessibility and keyboard navigation indication.
  final bool focusing;

  /// Size of the radio button in logical pixels.
  ///
  /// Controls both the width and height of the circular radio button.
  /// If null, uses the size from the current [RadioTheme].
  final double? size;

  /// Color of the inner selection indicator when selected.
  ///
  /// Applied to the inner dot that appears when [value] is true.
  /// If null, uses the activeColor from the current [RadioTheme].
  final Color? activeColor;

  /// Color of the outer border circle.
  ///
  /// Applied to the border of the radio button in both selected and
  /// unselected states. If null, uses the borderColor from the current [RadioTheme].
  final Color? borderColor;

  /// Background color of the radio button circle.
  ///
  /// Applied as the fill color behind the border. If null, uses the
  /// backgroundColor from the current [RadioTheme].
  final Color? backgroundColor;

  /// Creates a [Radio] with the specified selection state and styling.
  ///
  /// The [value] parameter is required and determines whether the radio
  /// appears selected. All other parameters are optional and will fall
  /// back to theme values when not specified.
  ///
  /// Parameters:
  /// - [value] (bool, required): Whether the radio button is selected
  /// - [focusing] (bool, default: false): Whether the radio has focus
  /// - [size] (double?, optional): Size of the radio button in pixels
  /// - [activeColor] (Color?, optional): Color of the selection indicator
  /// - [borderColor] (Color?, optional): Color of the outer border
  /// - [backgroundColor] (Color?, optional): Color of the background fill
  ///
  /// Example:
  /// ```dart
  /// Radio(
  ///   value: selectedValue == itemValue,
  ///   focusing: focusNode.hasFocus,
  ///   size: 18,
  /// );
  /// ```
  const Radio({
    super.key,
    required this.value,
    this.focusing = false,
    this.size,
    this.activeColor,
    this.borderColor,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<RadioTheme>(context);
    final size = styleValue<double>(
        widgetValue: this.size,
        themeValue: compTheme?.size,
        defaultValue: 16 * theme.scaling);
    final activeColor = styleValue<Color>(
        widgetValue: this.activeColor,
        themeValue: compTheme?.activeColor,
        defaultValue: theme.colorScheme.primary);
    final borderColor = styleValue<Color>(
        widgetValue: this.borderColor,
        themeValue: compTheme?.borderColor,
        defaultValue: theme.colorScheme.input);
    final backgroundColor = styleValue<Color>(
        widgetValue: this.backgroundColor,
        themeValue: compTheme?.backgroundColor,
        defaultValue: theme.colorScheme.input.scaleAlpha(0.3));
    final innerSize = value ? (size - (6 + 2) * theme.scaling) : 0.0;
    return FocusOutline(
      focused: focusing,
      shape: BoxShape.circle,
      child: AnimatedContainer(
        duration: kDefaultDuration,
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor,
          border: Border.all(
            color: borderColor,
          ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: kDefaultDuration,
            width: innerSize,
            height: innerSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: activeColor,
            ),
          ),
        ),
      ),
    );
  }
}

/// Intent for navigating to the next item in a radio group.
class NextItemIntent extends Intent {
  /// Creates a next item intent.
  const NextItemIntent();
}

/// Intent for navigating to the previous item in a radio group.
class PreviousItemIntent extends Intent {
  /// Creates a previous item intent.
  const PreviousItemIntent();
}

/// A radio button item with optional leading and trailing widgets.
///
/// Used within a [RadioGroup] to create selectable radio button options.
class RadioItem<T> extends StatefulWidget {
  /// Optional widget displayed before the radio button.
  final Widget? leading;

  /// Optional widget displayed after the radio button.
  final Widget? trailing;

  /// The value represented by this radio item.
  final T value;

  /// Whether this radio item is enabled.
  final bool enabled;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Creates a radio item.
  const RadioItem({
    super.key,
    this.leading,
    this.trailing,
    required this.value,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<RadioItem<T>> createState() => _RadioItemState<T>();
}

class _RadioItemState<T> extends State<RadioItem<T>> {
  late FocusNode _focusNode;

  bool _focusing = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant RadioItem<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final groupData = Data.maybeOf<RadioGroupData<T>>(context);
    final group = Data.maybeOf<RadioGroupState<T>>(context);
    assert(groupData != null,
        'RadioItem<$T> must be a descendant of RadioGroup<$T>');
    return GestureDetector(
      onTap: widget.enabled && groupData?.enabled == true
          ? () {
              group?._setSelected(widget.value);
            }
          : null,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        mouseCursor: widget.enabled && groupData?.enabled == true
            ? SystemMouseCursors.click
            : SystemMouseCursors.forbidden,
        onShowFocusHighlight: (value) {
          if (value && widget.enabled && groupData?.enabled == true) {
            group?._setSelected(widget.value);
          }
          if (value != _focusing) {
            setState(() {
              _focusing = value;
            });
          }
        },
        actions: {
          NextItemIntent: CallbackAction<NextItemIntent>(
            onInvoke: (intent) {
              if (group != null) {
                group._setSelected(widget.value);
              }
              return null;
            },
          ),
          PreviousItemIntent: CallbackAction<PreviousItemIntent>(
            onInvoke: (intent) {
              if (group != null) {
                group._setSelected(widget.value);
              }
              return null;
            },
          ),
        },
        child: Data<RadioGroupData<T>>.boundary(
          child: Data<_RadioItemState<T>>.boundary(
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (widget.leading != null) widget.leading!,
                  if (widget.leading != null)
                    SizedBox(width: 8 * theme.scaling),
                  Radio(
                      value: groupData?.selectedItem == widget.value,
                      focusing:
                          _focusing && groupData?.selectedItem == widget.value),
                  if (widget.trailing != null)
                    SizedBox(width: 8 * theme.scaling),
                  if (widget.trailing != null) widget.trailing!,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// A card-style radio button with custom content.
///
/// Provides a larger, card-like selection area within a [RadioGroup].
class RadioCard<T> extends StatefulWidget {
  /// The child widget displayed in the card.
  final Widget child;

  /// The value represented by this radio card.
  final T value;

  /// Whether this radio card is enabled.
  final bool enabled;

  /// Focus node for keyboard navigation.
  final FocusNode? focusNode;

  /// Creates a radio card.
  const RadioCard({
    super.key,
    required this.child,
    required this.value,
    this.enabled = true,
    this.focusNode,
  });

  @override
  State<RadioCard<T>> createState() => _RadioCardState<T>();
}

/// Theme data for the [RadioCard] widget.
class RadioCardTheme {
  /// The cursor to use when the radio card is enabled.
  final MouseCursor? enabledCursor;

  /// The cursor to use when the radio card is disabled.
  final MouseCursor? disabledCursor;

  /// The color to use when the radio card is hovered over.
  final Color? hoverColor;

  /// The default color to use.
  final Color? color;

  /// The width of the border of the radio card.
  final double? borderWidth;

  /// The width of the border of the radio card when selected.
  final double? selectedBorderWidth;

  /// The radius of the border of the radio card.
  final BorderRadiusGeometry? borderRadius;

  /// The padding of the radio card.
  final EdgeInsetsGeometry? padding;

  /// The color of the border.
  final Color? borderColor;

  /// The color of the border when selected.
  final Color? selectedBorderColor;

  /// Theme data for the [RadioCard] widget.
  const RadioCardTheme({
    this.enabledCursor,
    this.disabledCursor,
    this.hoverColor,
    this.color,
    this.borderWidth,
    this.selectedBorderWidth,
    this.borderRadius,
    this.padding,
    this.borderColor,
    this.selectedBorderColor,
  });

  @override
  String toString() {
    return 'RadioCardTheme(enabledCursor: $enabledCursor, disabledCursor: $disabledCursor, hoverColor: $hoverColor, color: $color, borderWidth: $borderWidth, selectedBorderWidth: $selectedBorderWidth, borderRadius: $borderRadius, padding: $padding, borderColor: $borderColor, selectedBorderColor: $selectedBorderColor)';
  }

  /// Creates a copy of this [RadioCardTheme] but with the given fields replaced with the new values.
  RadioCardTheme copyWith({
    ValueGetter<MouseCursor?>? enabledCursor,
    ValueGetter<MouseCursor?>? disabledCursor,
    ValueGetter<Color?>? hoverColor,
    ValueGetter<Color?>? color,
    ValueGetter<double?>? borderWidth,
    ValueGetter<double?>? selectedBorderWidth,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? borderColor,
    ValueGetter<Color?>? selectedBorderColor,
  }) {
    return RadioCardTheme(
      enabledCursor:
          enabledCursor != null ? enabledCursor() : this.enabledCursor,
      disabledCursor:
          disabledCursor != null ? disabledCursor() : this.disabledCursor,
      hoverColor: hoverColor != null ? hoverColor() : this.hoverColor,
      color: color != null ? color() : this.color,
      borderWidth: borderWidth != null ? borderWidth() : this.borderWidth,
      selectedBorderWidth: selectedBorderWidth != null
          ? selectedBorderWidth()
          : this.selectedBorderWidth,
      borderRadius: borderRadius != null ? borderRadius() : this.borderRadius,
      padding: padding != null ? padding() : this.padding,
      borderColor: borderColor != null ? borderColor() : this.borderColor,
      selectedBorderColor: selectedBorderColor != null
          ? selectedBorderColor()
          : this.selectedBorderColor,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RadioCardTheme &&
        other.enabledCursor == enabledCursor &&
        other.disabledCursor == disabledCursor &&
        other.hoverColor == hoverColor &&
        other.color == color &&
        other.borderWidth == borderWidth &&
        other.selectedBorderWidth == selectedBorderWidth &&
        other.borderRadius == borderRadius &&
        other.padding == padding &&
        other.borderColor == borderColor &&
        other.selectedBorderColor == selectedBorderColor;
  }

  @override
  int get hashCode => Object.hash(
        enabledCursor,
        disabledCursor,
        hoverColor,
        color,
        borderWidth,
        selectedBorderWidth,
        borderRadius,
        padding,
        borderColor,
        selectedBorderColor,
      );
}

class _RadioCardState<T> extends State<RadioCard<T>> {
  late FocusNode _focusNode;
  bool _focusing = false;
  bool _hovering = false;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant RadioCard<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.focusNode != widget.focusNode) {
      _focusNode.dispose();
      _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final componentTheme = ComponentTheme.maybeOf<RadioCardTheme>(context);
    final groupData = Data.maybeOf<RadioGroupData<T>>(context);
    final group = Data.maybeOf<RadioGroupState<T>>(context);
    assert(groupData != null,
        'RadioCard<$T> must be a descendant of RadioGroup<$T>');
    return GestureDetector(
      onTap: widget.enabled && groupData?.enabled == true
          ? () {
              group?._setSelected(widget.value);
            }
          : null,
      child: FocusableActionDetector(
        focusNode: _focusNode,
        actions: {
          NextItemIntent: CallbackAction<NextItemIntent>(
            onInvoke: (intent) {
              if (group != null) {
                group._setSelected(widget.value);
              }
              return null;
            },
          ),
          PreviousItemIntent: CallbackAction<PreviousItemIntent>(
            onInvoke: (intent) {
              if (group != null) {
                group._setSelected(widget.value);
              }
              return null;
            },
          ),
        },
        mouseCursor: widget.enabled && groupData?.enabled == true
            ? styleValue(
                defaultValue: SystemMouseCursors.click,
                themeValue: componentTheme?.enabledCursor)
            : styleValue(
                defaultValue: SystemMouseCursors.forbidden,
                themeValue: componentTheme?.disabledCursor),
        onShowFocusHighlight: (value) {
          if (value && widget.enabled && groupData?.enabled == true) {
            group?._setSelected(widget.value);
          }
          if (value != _focusing) {
            setState(() {
              _focusing = value;
            });
          }
        },
        onShowHoverHighlight: (value) {
          if (value != _hovering) {
            setState(() {
              _hovering = value;
            });
          }
        },
        child: Data<RadioGroupData<T>>.boundary(
          child: Data<_RadioCardState<T>>.boundary(
            child: Card(
              borderColor: groupData?.selectedItem == widget.value
                  ? styleValue(
                      defaultValue: theme.colorScheme.primary,
                      themeValue: componentTheme?.selectedBorderColor,
                    )
                  : styleValue(
                      defaultValue: theme.colorScheme.muted,
                      themeValue: componentTheme?.borderColor,
                    ),
              borderWidth: groupData?.selectedItem == widget.value
                  ? styleValue(
                      defaultValue: 2 * theme.scaling,
                      themeValue: componentTheme?.selectedBorderWidth,
                    )
                  : styleValue(
                      defaultValue: 1 * theme.scaling,
                      themeValue: componentTheme?.borderWidth,
                    ),
              borderRadius: styleValue(
                  defaultValue: theme.borderRadiusMd,
                  themeValue: componentTheme?.borderRadius),
              padding: EdgeInsets.zero,
              clipBehavior: Clip.antiAlias,
              duration: kDefaultDuration,
              fillColor: _hovering
                  ? styleValue(
                      defaultValue: theme.colorScheme.muted,
                      themeValue: componentTheme?.hoverColor,
                    )
                  : styleValue(
                      defaultValue: theme.colorScheme.background,
                      themeValue: componentTheme?.color,
                    ),
              child: Container(
                padding: styleValue(
                  defaultValue: EdgeInsets.all(16 * theme.scaling),
                  themeValue: componentTheme?.padding,
                ),
                child: AnimatedPadding(
                  duration: kDefaultDuration,
                  padding: groupData?.selectedItem == widget.value
                      ? styleValue(
                          defaultValue: EdgeInsets.zero,
                          themeValue: componentTheme?.borderWidth != null
                              ? EdgeInsets.all(componentTheme!.borderWidth!)
                              : null,
                        )
                      // to compensate for the border width
                      : styleValue(
                          defaultValue: EdgeInsets.all(1 * theme.scaling),
                          themeValue: componentTheme?.borderWidth != null &&
                                  componentTheme?.selectedBorderWidth != null
                              ? EdgeInsets.all(
                                  componentTheme!.borderWidth! -
                                      componentTheme.selectedBorderWidth!,
                                )
                              : null,
                        ),
                  child: widget.child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Controller for managing [ControlledRadioGroup] state programmatically.
///
/// Extends [ValueNotifier] to provide reactive state management for radio group
/// components. Can be used to programmatically change selection, listen to
/// state changes, and integrate with forms and other reactive systems.
///
/// Example:
/// ```dart
/// final controller = RadioGroupController<String>('option1');
///
/// // Listen to changes
/// controller.addListener(() {
///   print('Selection changed to: ${controller.value}');
/// });
///
/// // Update selection
/// controller.value = 'option2';
/// ```
class RadioGroupController<T> extends ValueNotifier<T?>
    with ComponentController<T?> {
  /// Creates a [RadioGroupController] with an optional initial value.
  ///
  /// The [value] parameter sets the initial selected option. Can be null
  /// to start with no selection.
  ///
  /// Parameters:
  /// - [value] (T?, optional): Initial selected value
  RadioGroupController([super.value]);
}

/// Reactive radio button group with automatic state management and exclusivity.
///
/// A high-level radio group widget that provides automatic state management through
/// the controlled component pattern. Manages mutual exclusion between radio options
/// and supports both controller-based and callback-based state management.
///
/// ## Features
///
/// - **Mutual exclusion**: Automatically ensures only one radio button is selected
/// - **Flexible layout**: Works with any child layout (Column, Row, Wrap, etc.)
/// - **Keyboard navigation**: Full keyboard support with arrow keys and Space
/// - **Form integration**: Automatic validation and form field registration
/// - **State synchronization**: Keeps all radio buttons in sync automatically
///
/// ## Usage Patterns
///
/// **Controller-based (recommended for complex state):**
/// ```dart
/// final controller = RadioGroupController<String>('small');
///
/// ControlledRadioGroup<String>(
///   controller: controller,
///   child: Column(
///     children: [
///       Radio<String>(value: 'small', label: Text('Small')),
///       Radio<String>(value: 'medium', label: Text('Medium')),
///       Radio<String>(value: 'large', label: Text('Large')),
///     ],
///   ),
/// )
/// ```
///
/// **Callback-based (simple state management):**
/// ```dart
/// String? selectedSize;
///
/// ControlledRadioGroup<String>(
///   initialValue: selectedSize,
///   onChanged: (size) => setState(() => selectedSize = size),
///   child: Column(
///     children: [
///       Radio<String>(value: 'small', label: Text('Small')),
///       Radio<String>(value: 'medium', label: Text('Medium')),
///       Radio<String>(value: 'large', label: Text('Large')),
///     ],
///   ),
/// )
/// ```
class ControlledRadioGroup<T> extends StatelessWidget
    with ControlledComponent<T?> {
  @override
  final T? initialValue;
  @override
  final ValueChanged<T?>? onChanged;
  @override
  final bool enabled;
  @override
  final RadioGroupController<T?>? controller;

  /// Child widget containing the radio buttons.
  ///
  /// Usually a layout widget like Column, Row, or Wrap containing multiple
  /// [Radio] widgets. The radio group will manage the selection state
  /// of all descendant radio buttons automatically.
  final Widget child;

  /// Creates a [ControlledRadioGroup].
  ///
  /// Either [controller] or [onChanged] should be provided for interactivity.
  /// The widget supports both controller-based and callback-based state management
  /// patterns with automatic mutual exclusion between radio options.
  ///
  /// Parameters:
  /// - [controller] (`RadioGroupController<T>?`, optional): external state controller
  /// - [initialValue] (T?, optional): starting selection when no controller
  /// - [onChanged] (`ValueChanged<T?>?`, optional): selection change callback
  /// - [enabled] (bool, default: true): whether radio group is interactive
  /// - [child] (Widget, required): layout containing radio buttons
  ///
  /// Example:
  /// ```dart
  /// ControlledRadioGroup<String>(
  ///   controller: controller,
  ///   child: Column(
  ///     children: [
  ///       Radio<String>(value: 'option1', label: Text('Option 1')),
  ///       Radio<String>(value: 'option2', label: Text('Option 2')),
  ///     ],
  ///   ),
  /// )
  /// ```
  const ControlledRadioGroup({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return RadioGroup(
          value: data.value,
          onChanged: data.onChanged,
          child: child,
        );
      },
    );
  }
}

/// A group of radio buttons for single-selection input.
///
/// Manages the selection state and provides context for child radio items.
class RadioGroup<T> extends StatefulWidget {
  /// The child widget containing radio items.
  final Widget child;

  /// The currently selected value.
  final T? value;

  /// Callback invoked when the selection changes.
  final ValueChanged<T>? onChanged;

  /// Whether the radio group is enabled.
  final bool? enabled;

  /// Creates a radio group.
  const RadioGroup({
    super.key,
    required this.child,
    this.value,
    this.onChanged,
    this.enabled,
  });

  @override
  RadioGroupState<T> createState() => RadioGroupState<T>();
}

/// Data class holding radio group state information.
///
/// Contains the selected item and enabled state for a radio group.
class RadioGroupData<T> {
  /// The currently selected item value.
  final T? selectedItem;

  /// Whether the radio group is enabled.
  final bool enabled;

  /// Creates radio group data.
  RadioGroupData(this.selectedItem, this.enabled);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is RadioGroupData<T> &&
        other.selectedItem == selectedItem &&
        other.enabled == enabled;
  }

  @override
  int get hashCode => Object.hash(selectedItem, enabled);
}

/// State class for [RadioGroup] with form integration.
///
/// Manages selection state and integrates with the form validation system.
class RadioGroupState<T> extends State<RadioGroup<T>>
    with FormValueSupplier<T, RadioGroup<T>> {
  /// Whether the radio group is currently enabled.
  bool get enabled => widget.enabled ?? widget.onChanged != null;
  void _setSelected(T value) {
    if (!enabled) return;
    if (widget.value != value) {
      widget.onChanged?.call(value);
    }
  }

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(covariant RadioGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(T value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      child: Data.inherit(
        data: this,
        child: Data.inherit(
          data: RadioGroupData<T>(widget.value, enabled),
          child: FocusTraversalGroup(
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
