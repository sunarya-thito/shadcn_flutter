import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

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
  final Color? activeColor;
  final Color? borderColor;
  final Color? backgroundColor;
  final double? size;

  const RadioTheme(
      {this.activeColor, this.borderColor, this.size, this.backgroundColor});

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

/// Intent for navigating to the next item in a radio group using keyboard.
/// 
/// NextItemIntent is used by the keyboard navigation system to move focus
/// to the next selectable item in a radio group. Typically triggered by
/// arrow key presses in the forward direction.
/// 
/// This intent integrates with Flutter's Actions and Shortcuts system
/// to provide accessible keyboard navigation for radio groups.
class NextItemIntent extends Intent {
  /// Creates a [NextItemIntent] for forward navigation.
  const NextItemIntent();
}

/// Intent for navigating to the previous item in a radio group using keyboard.
/// 
/// PreviousItemIntent is used by the keyboard navigation system to move focus
/// to the previous selectable item in a radio group. Typically triggered by
/// arrow key presses in the backward direction.
/// 
/// This intent integrates with Flutter's Actions and Shortcuts system
/// to provide accessible keyboard navigation for radio groups.
class PreviousItemIntent extends Intent {
  /// Creates a [PreviousItemIntent] for backward navigation.
  const PreviousItemIntent();
}

/// An interactive radio button item with optional leading and trailing content.
/// 
/// RadioItem combines a radio button with additional content like labels,
/// icons, or custom widgets. It provides a complete interactive component
/// for radio group selections with built-in focus management and keyboard
/// navigation support.
/// 
/// The item automatically integrates with parent [RadioGroup] components
/// to provide selection state management and change notifications. It handles
/// user interactions, focus states, and accessibility features.
/// 
/// Type parameter [T] represents the type of value this radio item represents.
/// 
/// Example:
/// ```dart
/// RadioItem<String>(
///   value: 'option1',
///   leading: Icon(Icons.radio_button_checked),
///   trailing: Text('Option 1 Description'),
/// )
/// ```
class RadioItem<T> extends StatefulWidget {
  /// Optional widget displayed before the radio button.
  /// 
  /// Typically used for icons, labels, or other visual indicators
  /// that help identify the option. Positioned to the left of the
  /// radio button in LTR layouts.
  final Widget? leading;
  
  /// Optional widget displayed after the radio button.
  /// 
  /// Often used for additional description text, secondary icons,
  /// or action buttons related to this option. Positioned to the
  /// right of the radio button in LTR layouts.
  final Widget? trailing;
  
  /// The value this radio item represents.
  /// 
  /// This value is used to identify the item within the radio group
  /// and is passed to the group's onChanged callback when selected.
  /// Must be unique within the radio group.
  final T value;
  
  /// Whether this radio item accepts user interaction.
  /// 
  /// When false, the item appears dimmed and does not respond to
  /// taps or keyboard navigation. When true, the item is fully interactive.
  final bool enabled;
  
  /// Focus node for keyboard navigation and accessibility.
  /// 
  /// If null, a focus node is created automatically. Providing a custom
  /// focus node allows for external focus management and coordination
  /// with other focusable elements.
  final FocusNode? focusNode;

  /// Creates a [RadioItem] with the specified value and optional content.
  /// 
  /// The [value] parameter is required and must be unique within the
  /// radio group. All other parameters are optional and provide
  /// additional customization options.
  /// 
  /// Parameters:
  /// - [value] (T, required): The value this item represents
  /// - [leading] (Widget?, optional): Content displayed before the radio button
  /// - [trailing] (Widget?, optional): Content displayed after the radio button
  /// - [enabled] (bool, default: true): Whether the item is interactive
  /// - [focusNode] (FocusNode?, optional): Custom focus node for navigation
  /// 
  /// Example:
  /// ```dart
  /// RadioItem<int>(
  ///   value: 1,
  ///   leading: Text('Choice 1'),
  ///   trailing: Icon(Icons.star),
  ///   enabled: true,
  /// );
  /// ```
  const RadioItem({
    super.key,
    this.leading,
    this.trailing,
    required this.value,
    this.enabled = true,
    this.focusNode,
  });

  @override
  /// Creates the mutable state for this radio item.
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

/// A card-style radio button that displays custom content with selection styling.
/// 
/// RadioCard provides a larger, more prominent alternative to standard radio buttons
/// by displaying custom content within a selectable card container. The card changes
/// its appearance based on selection state, hover state, and focus, providing clear
/// visual feedback for user interactions.
/// 
/// Unlike [RadioItem] which includes a circular radio button, RadioCard styles
/// the entire container to indicate selection state through border changes,
/// background colors, and other visual cues. This makes it ideal for displaying
/// rich content like images, descriptions, or complex layouts.
/// 
/// The card automatically integrates with parent [RadioGroup] components for
/// selection state management and supports keyboard navigation and accessibility.
/// 
/// Type parameter [T] represents the type of value this radio card represents.
/// 
/// Example:
/// ```dart
/// RadioCard<String>(
///   value: 'premium',
///   child: Column(
///     children: [
///       Icon(Icons.star, size: 48),
///       Text('Premium Plan'),
///       Text('$29.99/month'),
///     ],
///   ),
/// )
/// ```
class RadioCard<T> extends StatefulWidget {
  /// The content to display within the radio card.
  /// 
  /// This can be any widget, from simple text to complex layouts with
  /// images, icons, and multiple text elements. The child content is
  /// displayed within the card's styled container.
  final Widget child;
  
  /// The value this radio card represents.
  /// 
  /// This value is used to identify the card within the radio group
  /// and is passed to the group's onChanged callback when selected.
  /// Must be unique within the radio group.
  final T value;
  
  /// Whether this radio card accepts user interaction.
  /// 
  /// When false, the card appears dimmed and does not respond to
  /// taps or keyboard navigation. When true, the card is fully interactive.
  final bool enabled;
  
  /// Focus node for keyboard navigation and accessibility.
  /// 
  /// If null, a focus node is created automatically. Providing a custom
  /// focus node allows for external focus management and coordination
  /// with other focusable elements.
  final FocusNode? focusNode;

  /// Creates a [RadioCard] with the specified content and value.
  /// 
  /// The [child] and [value] parameters are required. The child can be
  /// any widget and will be displayed within the card's styled container.
  /// 
  /// Parameters:
  /// - [child] (Widget, required): Content to display within the card
  /// - [value] (T, required): The value this card represents
  /// - [enabled] (bool, default: true): Whether the card is interactive
  /// - [focusNode] (FocusNode?, optional): Custom focus node for navigation
  /// 
  /// Example:
  /// ```dart
  /// RadioCard<PlanType>(
  ///   value: PlanType.basic,
  ///   child: ListTile(
  ///     title: Text('Basic Plan'),
  ///     subtitle: Text('Perfect for individuals'),
  ///     leading: Icon(Icons.person),
  ///   ),
  /// );
  /// ```
  const RadioCard({
    super.key,
    required this.child,
    required this.value,
    this.enabled = true,
    this.focusNode,
  });

  @override
  /// Creates the mutable state for this radio card.
  State<RadioCard<T>> createState() => _RadioCardState<T>();
}

/// Theme configuration for [RadioCard] widget styling and behavior.
/// 
/// RadioCardTheme provides comprehensive styling options for radio card components
/// including visual states (normal, selected, hovered), border styling, colors,
/// and interaction cursors. Applied globally through [ComponentTheme] or per-instance.
/// 
/// The theme supports different visual treatments for different interaction states,
/// allowing for rich visual feedback that guides user interaction and clearly
/// indicates selection states.
/// 
/// Example:
/// ```dart
/// ComponentTheme<RadioCardTheme>(
///   data: RadioCardTheme(
///     borderRadius: BorderRadius.circular(12),
///     padding: EdgeInsets.all(16),
///     borderColor: Colors.grey.shade300,
///     selectedBorderColor: Colors.blue,
///     selectedBorderWidth: 2,
///   ),
///   child: MyRadioCardWidget(),
/// );
/// ```
class RadioCardTheme {
  /// Mouse cursor displayed when the radio card is enabled and interactive.
  /// 
  /// Typically [SystemMouseCursors.click] to indicate the card is clickable.
  /// When null, uses framework default cursor behavior.
  final MouseCursor? enabledCursor;

  /// Mouse cursor displayed when the radio card is disabled.
  /// 
  /// Usually [SystemMouseCursors.forbidden] to indicate the card cannot
  /// be interacted with. When null, uses framework default cursor behavior.
  final MouseCursor? disabledCursor;

  /// Background color applied when the card is hovered over.
  /// 
  /// Provides visual feedback during mouse hover interactions. Creates
  /// a subtle highlight effect to indicate interactivity. When null,
  /// uses theme default hover color.
  final Color? hoverColor;

  /// Default background color for the radio card.
  /// 
  /// Applied when the card is in its normal, non-hovered, non-selected state.
  /// Forms the base color from which other states derive their styling.
  /// When null, uses theme default card background color.
  final Color? color;

  /// Width of the card border in its normal state.
  /// 
  /// Controls the thickness of the border around the card when not selected.
  /// Typically a thin border (1-2 pixels) for subtle definition. When null,
  /// uses framework default border width.
  final double? borderWidth;

  /// Width of the card border when selected.
  /// 
  /// Usually thicker than [borderWidth] to emphasize the selected state.
  /// Common values are 2-3 pixels for clear visual distinction. When null,
  /// falls back to [borderWidth] or framework default.
  final double? selectedBorderWidth;

  /// Corner radius for the card's border.
  /// 
  /// Controls the roundness of the card corners. Can be uniform radius
  /// or different values for each corner. When null, uses framework
  /// default border radius (typically rectangular).
  final BorderRadiusGeometry? borderRadius;

  /// Internal padding applied to the card's content.
  /// 
  /// Controls spacing between the card's border and its child content.
  /// Affects how much whitespace surrounds the child widget. When null,
  /// uses framework default card padding.
  final EdgeInsetsGeometry? padding;

  /// Border color for the card in its normal state.
  /// 
  /// Applied to the card border when not selected. Usually a subtle
  /// color that provides definition without being prominent. When null,
  /// uses theme default border color.
  final Color? borderColor;

  /// Border color for the card when selected.
  /// 
  /// Applied to the card border when it represents the selected value.
  /// Usually a prominent color (like primary theme color) that clearly
  /// indicates selection. When null, falls back to [borderColor].
  final Color? selectedBorderColor;

  /// Creates a [RadioCardTheme] with the specified styling options.
  /// 
  /// All parameters are optional and will fall back to framework defaults
  /// when not specified. This allows for partial customization while
  /// maintaining consistent theming for unspecified properties.
  /// 
  /// Example:
  /// ```dart
  /// RadioCardTheme(
  ///   selectedBorderColor: Colors.blue,
  ///   selectedBorderWidth: 2,
  ///   borderRadius: BorderRadius.circular(8),
  ///   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  /// );
  /// ```
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

  /// Creates a copy of this theme with the specified properties replaced.
  /// 
  /// Uses [ValueGetter] functions to provide new values, allowing for
  /// conditional or computed theme modifications. Properties not specified
  /// retain their current values.
  /// 
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   selectedBorderColor: () => Colors.red,
  ///   borderWidth: () => 2.0,
  /// );
  /// ```
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
  /// - [controller] (RadioGroupController<T>?, optional): external state controller
  /// - [initialValue] (T?, optional): starting selection when no controller
  /// - [onChanged] (ValueChanged<T?>?, optional): selection change callback
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

/// A radio button group that manages mutual exclusion between radio options.
/// 
/// RadioGroup provides a lower-level container for radio button components
/// that automatically manages selection state and mutual exclusion. It serves
/// as the foundation for radio group functionality, providing state coordination
/// between child radio items.
/// 
/// Unlike higher-level components, RadioGroup requires manual state management
/// through the [value] and [onChanged] parameters. This provides flexibility
/// for complex scenarios but requires more setup than convenience components.
/// 
/// The group automatically provides context data to child radio components
/// ([RadioItem], [RadioCard], etc.) to coordinate selection state and enable
/// proper visual feedback and interaction handling.
/// 
/// Type parameter [T] represents the type of values used to identify radio options.
/// 
/// Example:
/// ```dart
/// String? selectedOption = 'option1';
/// 
/// RadioGroup<String>(
///   value: selectedOption,
///   onChanged: (value) => setState(() => selectedOption = value),
///   child: Column(
///     children: [
///       RadioItem(value: 'option1', leading: Text('Option 1')),
///       RadioItem(value: 'option2', leading: Text('Option 2')),
///       RadioItem(value: 'option3', leading: Text('Option 3')),
///     ],
///   ),
/// )
/// ```
class RadioGroup<T> extends StatefulWidget {
  /// The child widget containing the radio options.
  /// 
  /// Typically a layout widget (Column, Row, Wrap) containing multiple
  /// radio components ([RadioItem], [RadioCard], etc.). All radio
  /// components within this child will be coordinated by this group.
  final Widget child;
  
  /// The currently selected radio option value.
  /// 
  /// When a radio option with this value is present in the child tree,
  /// it will be displayed as selected. Can be null if no option is selected.
  final T? value;
  
  /// Callback invoked when the selected radio option changes.
  /// 
  /// Called with the value of the newly selected radio option. If null,
  /// the radio group is considered read-only and selections cannot be changed.
  final ValueChanged<T>? onChanged;
  
  /// Whether the radio group accepts user interaction.
  /// 
  /// When false, all radio options in the group are disabled and cannot
  /// be selected. When null, the enabled state is determined by whether
  /// [onChanged] is provided.
  final bool? enabled;

  /// Creates a [RadioGroup] with the specified child and state management.
  /// 
  /// The [child] parameter is required and should contain radio components
  /// that will be coordinated by this group. State management is handled
  /// through the [value] and [onChanged] parameters.
  /// 
  /// Parameters:
  /// - [child] (Widget, required): Container with radio options
  /// - [value] (T?, optional): Currently selected value
  /// - [onChanged] (ValueChanged<T>?, optional): Selection change callback
  /// - [enabled] (bool?, optional): Whether the group accepts interaction
  const RadioGroup({
    super.key,
    required this.child,
    this.value,
    this.onChanged,
    this.enabled,
  });

  @override
  /// Creates the mutable state for this radio group.
  RadioGroupState<T> createState() => RadioGroupState<T>();
}

/// Data object that carries radio group state information through the widget tree.
/// 
/// RadioGroupData is used internally by the radio group system to provide
/// context information to child radio components. It carries the currently
/// selected item and the enabled state down the widget tree so that individual
/// radio components can display the appropriate visual state.
/// 
/// This class is primarily for internal use and should not be created directly
/// in application code. It's automatically managed by [RadioGroup] components.
/// 
/// Type parameter [T] represents the type of values used to identify radio options.
class RadioGroupData<T> {
  /// The currently selected radio option value.
  /// 
  /// Radio components use this to determine if they should display
  /// as selected. Can be null if no option is currently selected.
  final T? selectedItem;
  
  /// Whether the radio group is enabled for user interaction.
  /// 
  /// When false, radio components should display in a disabled state
  /// and not respond to user interactions.
  final bool enabled;

  /// Creates radio group data with the specified state.
  /// 
  /// Parameters:
  /// - [selectedItem] (T?): Currently selected value
  /// - [enabled] (bool): Whether the group is interactive
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

class RadioGroupState<T> extends State<RadioGroup<T>>
    with FormValueSupplier<T, RadioGroup<T>> {
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
