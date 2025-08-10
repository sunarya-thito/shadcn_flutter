import 'package:flutter/services.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

import '../../../shadcn_flutter.dart';

const kSwitchDuration = Duration(milliseconds: 100);

/// A theme for [Switch] widgets.
class SwitchTheme {
  /// The color of the track when the switch is on.
  final Color? activeColor;

  /// The color of the track when the switch is off.
  final Color? inactiveColor;

  /// The color of the thumb.
  final Color? thumbColor;

  /// The gap between the switch and its leading/trailing widgets.
  final double? gap;

  /// The border radius of the track.
  final BorderRadiusGeometry? borderRadius;

  /// Creates a [SwitchTheme].
  const SwitchTheme({
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.gap,
    this.borderRadius,
  });

  /// Returns a copy of this theme with the given fields replaced.
  SwitchTheme copyWith({
    ValueGetter<Color?>? activeColor,
    ValueGetter<Color?>? inactiveColor,
    ValueGetter<Color?>? thumbColor,
    ValueGetter<double?>? gap,
    ValueGetter<BorderRadiusGeometry?>? borderRadius,
  }) {
    return SwitchTheme(
      activeColor: activeColor == null ? this.activeColor : activeColor(),
      inactiveColor:
          inactiveColor == null ? this.inactiveColor : inactiveColor(),
      thumbColor: thumbColor == null ? this.thumbColor : thumbColor(),
      gap: gap == null ? this.gap : gap(),
      borderRadius:
          borderRadius == null ? this.borderRadius : borderRadius(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SwitchTheme &&
        other.activeColor == activeColor &&
        other.inactiveColor == inactiveColor &&
        other.thumbColor == thumbColor &&
        other.gap == gap &&
        other.borderRadius == borderRadius;
  }

  @override
  int get hashCode => Object.hash(
        activeColor,
        inactiveColor,
        thumbColor,
        gap,
        borderRadius,
      );
}

class SwitchController extends ValueNotifier<bool>
    with ComponentController<bool> {
  SwitchController([super.value = false]);

  void toggle() {
    value = !value;
  }
}

class ControlledSwitch extends StatelessWidget with ControlledComponent<bool> {
  @override
  final bool initialValue;
  @override
  final ValueChanged<bool>? onChanged;
  @override
  final bool enabled;
  @override
  final SwitchController? controller;

  final Widget? leading;
  final Widget? trailing;
  final double? gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final BorderRadiusGeometry? borderRadius;

  const ControlledSwitch({
    super.key,
    this.controller,
    this.initialValue = false,
    this.onChanged,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.gap,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Switch(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          leading: leading,
          trailing: trailing,
          gap: gap,
          activeColor: activeColor,
          inactiveColor: inactiveColor,
          thumbColor: thumbColor,
          borderRadius: borderRadius,
        );
      },
    );
  }
}

class Switch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget? leading;
  final Widget? trailing;
  final bool? enabled;
  final double? gap;
  final Color? activeColor;
  final Color? inactiveColor;
  final Color? thumbColor;
  final BorderRadiusGeometry? borderRadius;

  const Switch({
    super.key,
    required this.value,
    required this.onChanged,
    this.leading,
    this.trailing,
    this.enabled = true,
    this.gap,
    this.activeColor,
    this.inactiveColor,
    this.thumbColor,
    this.borderRadius,
  });

  @override
  State<Switch> createState() => _SwitchState();
}

class _SwitchState extends State<Switch> with FormValueSupplier<bool, Switch> {
  bool _focusing = false;

  @override
  void initState() {
    super.initState();
    formValue = widget.value;
  }

  bool get _enabled => widget.enabled ?? widget.onChanged != null;

  @override
  void didUpdateWidget(covariant Switch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(bool value) {
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<SwitchTheme>(context);
    final gap = styleValue(
        widgetValue: widget.gap,
        themeValue: compTheme?.gap,
        defaultValue: 8 * scaling);
    final activeColor = styleValue(
        widgetValue: widget.activeColor,
        themeValue: compTheme?.activeColor,
        defaultValue: theme.colorScheme.primary);
    final inactiveColor = styleValue(
        widgetValue: widget.inactiveColor,
        themeValue: compTheme?.inactiveColor,
        defaultValue: theme.colorScheme.border);
    final thumbColor = styleValue(
        widgetValue: widget.thumbColor,
        themeValue: compTheme?.thumbColor,
        defaultValue: theme.colorScheme.background);
    final borderRadius = styleValue<BorderRadiusGeometry>(
        widgetValue: widget.borderRadius,
        themeValue: compTheme?.borderRadius,
        defaultValue: BorderRadius.circular(theme.radiusXl));
    return FocusOutline(
      focused: _focusing,
      borderRadius:
          optionallyResolveBorderRadius(context, borderRadius) ??
              BorderRadius.circular(theme.radiusXl),
      align: 3 * scaling,
      width: 2 * scaling,
      child: GestureDetector(
        onTap: _enabled
            ? () {
                widget.onChanged?.call(!widget.value);
              }
            : null,
        child: FocusableActionDetector(
          enabled: _enabled,
          onShowFocusHighlight: (value) {
            setState(() {
              _focusing = value;
            });
          },
          actions: {
            ActivateIntent: CallbackAction(
              onInvoke: (Intent intent) {
                widget.onChanged?.call(!widget.value);
                return true;
              },
            ),
          },
          shortcuts: const {
            SingleActivator(LogicalKeyboardKey.enter): ActivateIntent(),
            SingleActivator(LogicalKeyboardKey.space): ActivateIntent(),
          },
          mouseCursor: _enabled
              ? SystemMouseCursors.click
              : SystemMouseCursors.forbidden,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
              if (widget.leading != null) widget.leading!,
              if (widget.leading != null) SizedBox(width: gap),
              AnimatedContainer(
                duration: kSwitchDuration,
                width: (32 + 4) * scaling,
                height: (16 + 4) * scaling,
                padding: EdgeInsets.all(2 * scaling),
                decoration: BoxDecoration(
                  borderRadius:
                      optionallyResolveBorderRadius(context, borderRadius) ??
                          BorderRadius.circular(theme.radiusXl),
                  color: !_enabled
                      ? theme.colorScheme.muted
                      : widget.value
                          ? activeColor
                          : inactiveColor,
                ),
                child: Stack(
                  children: [
                    AnimatedPositioned(
                      duration: kSwitchDuration,
                      curve: Curves.easeInOut,
                      left: widget.value ? 16 * scaling : 0,
                      top: 0,
                      bottom: 0,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(theme.radiusLg),
                            color: thumbColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.trailing != null) SizedBox(width: gap),
              if (widget.trailing != null) widget.trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
