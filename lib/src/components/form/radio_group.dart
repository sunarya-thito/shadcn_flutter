import 'package:flutter/services.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

import '../../../shadcn_flutter.dart';

/// Theme data for [Radio].
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

class Radio extends StatelessWidget {
  final bool value;
  final bool focusing;
  final double? size;
  final Color? activeColor;
  final Color? borderColor;
  final Color? backgroundColor;

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

class NextItemIntent extends Intent {
  const NextItemIntent();
}

class PreviousItemIntent extends Intent {
  const PreviousItemIntent();
}

class RadioItem<T> extends StatefulWidget {
  final Widget? leading;
  final Widget? trailing;
  final T value;
  final bool enabled;
  final FocusNode? focusNode;

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

class RadioCard<T> extends StatefulWidget {
  final Widget child;
  final T value;
  final bool enabled;
  final FocusNode? focusNode;

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

class RadioGroupController<T> extends ValueNotifier<T?>
    with ComponentController<T?> {
  RadioGroupController([super.value]);
}

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

  final Widget child;

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

class RadioGroup<T> extends StatefulWidget {
  final Widget child;
  final T? value;
  final ValueChanged<T>? onChanged;
  final bool? enabled;
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

class RadioGroupData<T> {
  final T? selectedItem;
  final bool enabled;

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
