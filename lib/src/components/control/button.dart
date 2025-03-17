import 'dart:math';

import '../../../shadcn_flutter.dart';

class ToggleController extends ValueNotifier<bool>
    with ComponentController<bool> {
  ToggleController([super.value = false]);

  void toggle() {
    value = !value;
  }
}

class ControlledToggle extends StatelessWidget with ControlledComponent<bool> {
  @override
  final bool? initialValue;
  @override
  final ValueChanged<bool>? onChanged;
  @override
  final bool enabled;
  @override
  final ToggleController? controller;

  final Widget child;
  final ButtonStyle style;

  const ControlledToggle({
    super.key,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.enabled = true,
    required this.child,
    this.style = const ButtonStyle.ghost(),
  });

  @override
  Widget build(BuildContext context) {
    return ControlledComponentAdapter(
      controller: controller,
      initialValue: initialValue,
      onChanged: onChanged,
      enabled: enabled,
      builder: (context, data) {
        return Toggle(
          value: data.value,
          onChanged: data.onChanged,
          enabled: data.enabled,
          style: style,
          child: child,
        );
      },
    );
  }
}

class Toggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget child;
  final ButtonStyle style;
  final bool? enabled;

  const Toggle({
    super.key,
    required this.value,
    this.onChanged,
    required this.child,
    this.enabled,
    this.style = const ButtonStyle.ghost(),
  });

  @override
  ToggleState createState() => ToggleState();
}

// toggle button is just ghost button
class ToggleState extends State<Toggle> with FormValueSupplier<bool, Toggle> {
  final WidgetStatesController statesController = WidgetStatesController();

  @override
  void initState() {
    super.initState();
    statesController.update(WidgetState.selected, widget.value);
    formValue = widget.value;
  }

  @override
  void didUpdateWidget(Toggle oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      statesController.update(WidgetState.selected, widget.value);
      formValue = widget.value;
    }
  }

  @override
  void didReplaceFormValue(bool value) {
    if (widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Button(
        statesController: statesController,
        enabled: widget.enabled,
        style: widget.value
            ? ButtonStyle.secondary(
                density: widget.style.density,
                shape: widget.style.shape,
                size: widget.style.size,
              )
            : widget.style.copyWith(textStyle: (context, states, value) {
                final theme = Theme.of(context);
                return value.copyWith(
                  color: states.contains(WidgetState.hovered)
                      ? theme.colorScheme.mutedForeground
                      : null,
                );
              }, iconTheme: (context, states, value) {
                final theme = Theme.of(context);
                return value.copyWith(
                  color: states.contains(WidgetState.hovered)
                      ? theme.colorScheme.mutedForeground
                      : null,
                );
              }),
        onPressed: widget.onChanged != null
            ? () {
                widget.onChanged!(!widget.value);
              }
            : null,
        child: widget.child);
  }
}

class SelectedButton extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget child;
  final AbstractButtonStyle style;
  final AbstractButtonStyle selectedStyle;
  final bool? enabled;
  final AlignmentGeometry? alignment;
  final AlignmentGeometry? marginAlignment;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;
  final bool disableHoverEffect;
  final WidgetStatesController? statesController;
  final VoidCallback? onPressed;

  const SelectedButton({
    super.key,
    required this.value,
    this.onChanged,
    required this.child,
    this.enabled,
    this.style = const ButtonStyle.ghost(),
    this.selectedStyle = const ButtonStyle.secondary(),
    this.alignment,
    this.marginAlignment,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.disableHoverEffect = false,
    this.statesController,
    this.onPressed,
  });

  @override
  SelectedButtonState createState() => SelectedButtonState();
}

// toggle button is just ghost button
class SelectedButtonState extends State<SelectedButton> {
  late WidgetStatesController statesController;
  @override
  void initState() {
    super.initState();
    statesController = widget.statesController ?? WidgetStatesController();
    statesController.update(WidgetState.selected, widget.value);
  }

  @override
  void didUpdateWidget(SelectedButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.statesController != widget.statesController) {
      statesController = widget.statesController ?? WidgetStatesController();
      statesController.update(WidgetState.selected, widget.value);
    }
    if (oldWidget.value != widget.value) {
      statesController.update(WidgetState.selected, widget.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Button(
        statesController: statesController,
        enabled: widget.enabled,
        style: widget.value ? widget.selectedStyle : widget.style,
        alignment: widget.alignment,
        marginAlignment: widget.marginAlignment,
        disableTransition: widget.disableTransition,
        onHover: widget.onHover,
        onFocus: widget.onFocus,
        enableFeedback: widget.enableFeedback,
        onTapDown: widget.onTapDown,
        onTapUp: widget.onTapUp,
        onTapCancel: widget.onTapCancel,
        onSecondaryTapDown: widget.onSecondaryTapDown,
        onSecondaryTapUp: widget.onSecondaryTapUp,
        onSecondaryTapCancel: widget.onSecondaryTapCancel,
        onTertiaryTapDown: widget.onTertiaryTapDown,
        onTertiaryTapUp: widget.onTertiaryTapUp,
        onTertiaryTapCancel: widget.onTertiaryTapCancel,
        onLongPressStart: widget.onLongPressStart,
        onLongPressUp: widget.onLongPressUp,
        onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
        onLongPressEnd: widget.onLongPressEnd,
        onSecondaryLongPress: widget.onSecondaryLongPress,
        onTertiaryLongPress: widget.onTertiaryLongPress,
        disableHoverEffect: widget.disableHoverEffect,
        onPressed: () {
          if (widget.onChanged != null) {
            widget.onChanged!(!widget.value);
          }
          if (widget.onPressed != null) {
            widget.onPressed!();
          }
        },
        child: widget.child);
  }
}

class Button extends StatefulWidget {
  final bool? enabled;
  final bool disableTransition;
  final Widget? leading;
  final Widget? trailing;
  final Widget child;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final AlignmentGeometry? alignment;
  final AbstractButtonStyle style;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;
  final bool disableHoverEffect;
  final WidgetStatesController? statesController;
  final AlignmentGeometry? marginAlignment;
  final bool disableFocusOutline;
  const Button({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    required this.style,
    this.enabled,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.primary({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.primary,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.secondary({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.secondary,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.outline({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.outline,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.ghost({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.ghost,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.link({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.link,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.text({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.text,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.destructive({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.destructive,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.fixed({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.fixed,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  const Button.card({
    super.key,
    this.statesController,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled,
    this.style = ButtonVariance.card,
    this.disableTransition = false,
    this.onFocus,
    this.onHover,
    this.disableHoverEffect = false,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.marginAlignment,
    this.disableFocusOutline = false,
  });

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState<T extends Button> extends State<T> {
  bool get _shouldEnableFeedback {
    final platform = Theme.of(context).platform;
    return isMobile(platform);
  }

  AbstractButtonStyle? _style;
  ButtonStyleOverrideData? _overrideData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var style = widget.style;
    var overrideData = Data.maybeOf<ButtonStyleOverrideData>(context);
    if (overrideData != _overrideData) {
      _overrideData = overrideData;
      if (overrideData != null) {
        style = style.copyWith(
          decoration: overrideData.decoration,
          mouseCursor: overrideData.mouseCursor,
          padding: overrideData.padding,
          textStyle: overrideData.textStyle,
          iconTheme: overrideData.iconTheme,
          margin: overrideData.margin,
        );
      }
    }
    _style = style;
  }

  @override
  void didUpdateWidget(T oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.style != oldWidget.style) {
      var style = widget.style;
      var overrideData = _overrideData;
      if (overrideData != null) {
        style = style.copyWith(
          decoration: overrideData.decoration,
          mouseCursor: overrideData.mouseCursor,
          padding: overrideData.padding,
          textStyle: overrideData.textStyle,
          iconTheme: overrideData.iconTheme,
          margin: overrideData.margin,
        );
      }
      _style = style;
    }
  }

  EdgeInsetsGeometry _resolveMargin(Set<WidgetState> states) {
    return _style!.margin(context, states);
  }

  Decoration _resolveDecoration(Set<WidgetState> states) {
    return _style!.decoration(context, states);
  }

  MouseCursor _resolveMouseCursor(Set<WidgetState> states) {
    return _style!.mouseCursor(context, states);
  }

  EdgeInsetsGeometry _resolvePadding(Set<WidgetState> states) {
    return _style!.padding(context, states);
  }

  TextStyle _resolveTextStyle(Set<WidgetState> states) {
    return _style!.textStyle(context, states);
  }

  IconThemeData _resolveIconTheme(Set<WidgetState> states) {
    return _style!.iconTheme(context, states);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    bool enableFeedback = widget.enableFeedback ?? _shouldEnableFeedback;
    return Clickable(
      disableFocusOutline: widget.disableFocusOutline,
      statesController: widget.statesController,
      focusNode: widget.focusNode,
      enabled: widget.enabled ?? widget.onPressed != null,
      marginAlignment: widget.marginAlignment,
      disableTransition: widget.disableTransition,
      onHover: widget.onHover,
      onFocus: widget.onFocus,
      disableHoverEffect: widget.disableHoverEffect,
      enableFeedback: enableFeedback,
      margin: WidgetStateProperty.resolveWith(_resolveMargin),
      decoration: WidgetStateProperty.resolveWith(_resolveDecoration),
      mouseCursor: WidgetStateProperty.resolveWith(_resolveMouseCursor),
      padding: WidgetStateProperty.resolveWith(_resolvePadding),
      textStyle: WidgetStateProperty.resolveWith(_resolveTextStyle),
      iconTheme: WidgetStateProperty.resolveWith(_resolveIconTheme),
      transform: enableFeedback
          ? WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.pressed)) {
                // scale down to 95% with alignment at center
                return Matrix4.identity()..scale(0.95);
              }
              return null;
            })
          : null,
      onPressed: widget.onPressed,
      onTapDown: widget.onTapDown,
      onTapUp: widget.onTapUp,
      onTapCancel: widget.onTapCancel,
      onSecondaryTapDown: widget.onSecondaryTapDown,
      onSecondaryTapUp: widget.onSecondaryTapUp,
      onSecondaryTapCancel: widget.onSecondaryTapCancel,
      onTertiaryTapDown: widget.onTertiaryTapDown,
      onTertiaryTapUp: widget.onTertiaryTapUp,
      onTertiaryTapCancel: widget.onTertiaryTapCancel,
      onLongPressStart: widget.onLongPressStart,
      onLongPressUp: widget.onLongPressUp,
      onLongPressMoveUpdate: widget.onLongPressMoveUpdate,
      onLongPressEnd: widget.onLongPressEnd,
      onSecondaryLongPress: widget.onSecondaryLongPress,
      onTertiaryLongPress: widget.onTertiaryLongPress,
      child: widget.leading == null && widget.trailing == null
          ? Align(
              heightFactor: 1,
              widthFactor: 1,
              alignment: widget.alignment ?? Alignment.center,
              child: widget.child,
            )
          : IntrinsicWidth(
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (widget.leading != null) widget.leading!,
                    if (widget.leading != null) Gap(8 * scaling),
                    Expanded(
                      child: Align(
                        widthFactor: 1,
                        heightFactor: 1,
                        alignment: widget.alignment ??
                            AlignmentDirectional.centerStart,
                        child: widget.child,
                      ),
                    ),
                    if (widget.trailing != null) Gap(8 * scaling),
                    if (widget.trailing != null) widget.trailing!,
                  ],
                ),
              ),
            ),
    );
  }
}

class ButtonSize {
  final double scale;
  const ButtonSize(this.scale);
  static const ButtonSize normal = ButtonSize(1);
  static const ButtonSize xSmall = ButtonSize(1 / 2);
  static const ButtonSize small = ButtonSize(3 / 4);
  static const ButtonSize large = ButtonSize(2);
  static const ButtonSize xLarge = ButtonSize(3);
}

typedef DensityModifier = EdgeInsets Function(EdgeInsets padding);

class ButtonDensity {
  final DensityModifier modifier;
  const ButtonDensity(this.modifier);
  static const ButtonDensity normal = ButtonDensity(_densityNormal);
  static const ButtonDensity comfortable = ButtonDensity(_densityComfortable);
  static const ButtonDensity icon = ButtonDensity(_densityIcon);
  static const ButtonDensity iconComfortable =
      ButtonDensity(_densityIconComfortable);
  static const ButtonDensity iconDense = ButtonDensity(_densityIconDense);
  static const ButtonDensity dense = ButtonDensity(_densityDense);
  static const ButtonDensity compact = ButtonDensity(_densityCompact);
}

EdgeInsets _densityNormal(EdgeInsets padding) {
  return padding;
}

EdgeInsets _densityDense(EdgeInsets padding) {
  return padding * 0.5;
}

EdgeInsets _densityCompact(EdgeInsets padding) {
  return EdgeInsets.zero;
}

EdgeInsets _densityIcon(EdgeInsets padding) {
  return EdgeInsets.all(
      min(padding.top, min(padding.bottom, min(padding.left, padding.right))));
}

EdgeInsets _densityIconComfortable(EdgeInsets padding) {
  return EdgeInsets.all(
      max(padding.top, max(padding.bottom, max(padding.left, padding.right))));
}

EdgeInsets _densityIconDense(EdgeInsets padding) {
  return EdgeInsets.all(
      min(padding.top, min(padding.bottom, min(padding.left, padding.right))) *
          0.5);
}

EdgeInsets _densityComfortable(EdgeInsets padding) {
  return padding * 2;
}

enum ButtonShape {
  rectangle,
  circle,
}

typedef ButtonStateProperty<T> = T Function(
    BuildContext context, Set<WidgetState> states);

abstract class AbstractButtonStyle {
  ButtonStateProperty<Decoration> get decoration;
  ButtonStateProperty<MouseCursor> get mouseCursor;
  ButtonStateProperty<EdgeInsetsGeometry> get padding;
  ButtonStateProperty<TextStyle> get textStyle;
  ButtonStateProperty<IconThemeData> get iconTheme;
  ButtonStateProperty<EdgeInsetsGeometry> get margin;
}

class ButtonStyle implements AbstractButtonStyle {
  final AbstractButtonStyle variance;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;

  const ButtonStyle({
    required this.variance,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  });

  const ButtonStyle.primary({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.primary;

  const ButtonStyle.secondary({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.secondary;

  const ButtonStyle.outline({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.outline;

  const ButtonStyle.ghost({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.ghost;

  const ButtonStyle.link({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.link;

  const ButtonStyle.text({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  const ButtonStyle.destructive({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  const ButtonStyle.fixed({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

  const ButtonStyle.menu({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.menu;

  const ButtonStyle.menubar({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.menubar;

  const ButtonStyle.muted({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.muted;

  const ButtonStyle.primaryIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.primary;

  const ButtonStyle.secondaryIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.secondary;

  const ButtonStyle.outlineIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.outline;

  const ButtonStyle.ghostIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.ghost;

  const ButtonStyle.linkIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.link;

  const ButtonStyle.textIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.text;

  const ButtonStyle.destructiveIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.destructive;

  const ButtonStyle.fixedIcon({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.fixed;

  const ButtonStyle.card({
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
  }) : variance = ButtonVariance.card;

  @override
  ButtonStateProperty<Decoration> get decoration {
    if (shape == ButtonShape.circle) {
      return _resolveCircleDecoration;
    }
    return variance.decoration;
  }

  Decoration _resolveCircleDecoration(
      BuildContext context, Set<WidgetState> states) {
    var decoration = variance.decoration(context, states);
    if (decoration is BoxDecoration) {
      return BoxDecoration(
        color: decoration.color,
        image: decoration.image,
        border: decoration.border,
        borderRadius: null,
        boxShadow: decoration.boxShadow,
        gradient: decoration.gradient,
        shape: BoxShape.circle,
        backgroundBlendMode: decoration.backgroundBlendMode,
      );
    } else if (decoration is ShapeDecoration) {
      return decoration.copyWith(
        shape: shape == ButtonShape.circle ? const CircleBorder() : null,
      );
    } else {
      throw Exception('Unsupported decoration type ${decoration.runtimeType}');
    }
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor {
    return variance.mouseCursor;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding {
    if (size == ButtonSize.normal && density == ButtonDensity.normal) {
      return variance.padding;
    }
    return _resolvePadding;
  }

  EdgeInsetsGeometry _resolvePadding(
      BuildContext context, Set<WidgetState> states) {
    return density.modifier(
        variance.padding(context, states).optionallyResolve(context) *
            size.scale);
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (size == ButtonSize.normal) {
      return variance.textStyle;
    }
    return _resolveTextStyle;
  }

  TextStyle _resolveTextStyle(BuildContext context, Set<WidgetState> states) {
    var fontSize = variance.textStyle(context, states).fontSize;
    if (fontSize == null) {
      final textStyle = DefaultTextStyle.of(context).style;
      fontSize = textStyle.fontSize ?? 14;
    }
    return variance.textStyle(context, states).copyWith(
          fontSize: fontSize * size.scale,
        );
  }

  @override
  ButtonStateProperty<IconThemeData> get iconTheme {
    if (size == ButtonSize.normal) {
      return variance.iconTheme;
    }
    return _resolveIconTheme;
  }

  IconThemeData _resolveIconTheme(
      BuildContext context, Set<WidgetState> states) {
    var iconSize = variance.iconTheme(context, states).size;
    iconSize ??= IconTheme.of(context).size ?? 24;
    return variance.iconTheme(context, states).copyWith(
          size: iconSize * size.scale,
        );
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    return variance.margin;
  }
}

abstract class ButtonTheme {
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  const ButtonTheme(
      {this.decoration,
      this.mouseCursor,
      this.padding,
      this.textStyle,
      this.iconTheme,
      this.margin});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ButtonTheme &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode => Object.hash(
      decoration, mouseCursor, padding, textStyle, iconTheme, margin);

  @override
  String toString() =>
      '$runtimeType{decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin}';
}

class ComponentThemeButtonStyle<T extends ButtonTheme>
    implements AbstractButtonStyle {
  final AbstractButtonStyle fallback;

  const ComponentThemeButtonStyle({required this.fallback});

  T? find(BuildContext context) {
    return ComponentTheme.maybeOf<T>(context);
  }

  @override
  ButtonStateProperty<Decoration> get decoration => _resolveDecoration;

  Decoration _resolveDecoration(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.decoration(context, states);
    return find(context)?.decoration?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<IconThemeData> get iconTheme => _resolveIconTheme;

  IconThemeData _resolveIconTheme(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.iconTheme(context, states);
    return find(context)?.iconTheme?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin => _resolveMargin;

  EdgeInsetsGeometry _resolveMargin(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.margin(context, states);
    return find(context)?.margin?.call(context, states, resolved) ?? resolved;
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor => _resolveMouseCursor;

  MouseCursor _resolveMouseCursor(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.mouseCursor(context, states);
    return find(context)?.mouseCursor?.call(context, states, resolved) ??
        resolved;
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding => _resolvePadding;

  EdgeInsetsGeometry _resolvePadding(
      BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.padding(context, states);
    return find(context)?.padding?.call(context, states, resolved) ?? resolved;
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle => _resolveTextStyle;

  TextStyle _resolveTextStyle(BuildContext context, Set<WidgetState> states) {
    var resolved = fallback.textStyle(context, states);
    return find(context)?.textStyle?.call(context, states, resolved) ??
        resolved;
  }
}

extension ShapeDecorationExtension on ShapeDecoration {
  ShapeDecoration copyWith({
    ShapeBorder? shape,
    Color? color,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    DecorationImage? image,
  }) {
    return ShapeDecoration(
      color: color ?? this.color,
      image: image ?? this.image,
      shape: shape ?? this.shape,
      gradient: gradient ?? this.gradient,
      shadows: shadows ?? this.shadows,
    );
  }
}

extension DecorationExtension on Decoration {
  BoxDecoration copyWithIfBoxDecoration({
    Color? color,
    DecorationImage? image,
    BoxBorder? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BoxShape? shape,
    BlendMode? backgroundBlendMode,
  }) {
    if (this is BoxDecoration) {
      var boxDecoration = this as BoxDecoration;
      return BoxDecoration(
        color: color ?? boxDecoration.color,
        image: image ?? boxDecoration.image,
        border: border ?? boxDecoration.border,
        borderRadius: borderRadius ?? boxDecoration.borderRadius,
        boxShadow: boxShadow ?? boxDecoration.boxShadow,
        gradient: gradient ?? boxDecoration.gradient,
        shape: shape ?? boxDecoration.shape,
        backgroundBlendMode:
            backgroundBlendMode ?? boxDecoration.backgroundBlendMode,
      );
    }
    return BoxDecoration(
      color: color,
      image: image,
      border: border,
      borderRadius: borderRadius,
      boxShadow: boxShadow,
      gradient: gradient,
      shape: shape ?? BoxShape.rectangle,
      backgroundBlendMode: backgroundBlendMode,
    );
  }

  ShapeDecoration copyWithIfShapeDecoration({
    ShapeBorder? shape,
    Color? color,
    Gradient? gradient,
    List<BoxShadow>? shadows,
    DecorationImage? image,
  }) {
    if (this is ShapeDecoration) {
      var shapeDecoration = this as ShapeDecoration;
      return ShapeDecoration(
        color: color ?? shapeDecoration.color,
        image: image ?? shapeDecoration.image,
        shape: shape ?? shapeDecoration.shape,
        gradient: gradient ?? shapeDecoration.gradient,
        shadows: shadows ?? shapeDecoration.shadows,
      );
    }
    return ShapeDecoration(
      color: color,
      image: image,
      shape: shape ?? const RoundedRectangleBorder(),
      gradient: gradient,
      shadows: shadows,
    );
  }
}

class PrimaryButtonTheme extends ButtonTheme {
  const PrimaryButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  PrimaryButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return PrimaryButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class SecondaryButtonTheme extends ButtonTheme {
  const SecondaryButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  SecondaryButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return SecondaryButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class OutlineButtonTheme extends ButtonTheme {
  const OutlineButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  OutlineButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return OutlineButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class GhostButtonTheme extends ButtonTheme {
  const GhostButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  GhostButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return GhostButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class LinkButtonTheme extends ButtonTheme {
  const LinkButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  LinkButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return LinkButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class TextButtonTheme extends ButtonTheme {
  const TextButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  TextButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return TextButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class DestructiveButtonTheme extends ButtonTheme {
  const DestructiveButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  DestructiveButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return DestructiveButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class FixedButtonTheme extends ButtonTheme {
  const FixedButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  FixedButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return FixedButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class MenuButtonTheme extends ButtonTheme {
  const MenuButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  MenuButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return MenuButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class MenubarButtonTheme extends ButtonTheme {
  const MenubarButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  MenubarButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return MenubarButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class MutedButtonTheme extends ButtonTheme {
  const MutedButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  MutedButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return MutedButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class CardButtonTheme extends ButtonTheme {
  const CardButtonTheme(
      {super.decoration,
      super.mouseCursor,
      super.padding,
      super.textStyle,
      super.iconTheme,
      super.margin});

  CardButtonTheme copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    return CardButtonTheme(
      decoration: decoration ?? this.decoration,
      mouseCursor: mouseCursor ?? this.mouseCursor,
      padding: padding ?? this.padding,
      textStyle: textStyle ?? this.textStyle,
      iconTheme: iconTheme ?? this.iconTheme,
      margin: margin ?? this.margin,
    );
  }
}

class ButtonVariance implements AbstractButtonStyle {
  static const AbstractButtonStyle primary =
      ComponentThemeButtonStyle<PrimaryButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonPrimaryDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonPrimaryTextStyle,
      iconTheme: _buttonPrimaryIconTheme,
      margin: _buttonZeroMargin,
    ),
  );
  static const AbstractButtonStyle secondary =
      ComponentThemeButtonStyle<SecondaryButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonSecondaryDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonSecondaryTextStyle,
      iconTheme: _buttonSecondaryIconTheme,
      margin: _buttonZeroMargin,
    ),
  );
  static const AbstractButtonStyle outline =
      ComponentThemeButtonStyle<OutlineButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonOutlineDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonOutlineTextStyle,
      iconTheme: _buttonOutlineIconTheme,
      margin: _buttonZeroMargin,
    ),
  );
  static const AbstractButtonStyle ghost =
      ComponentThemeButtonStyle<GhostButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonGhostDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonGhostTextStyle,
      iconTheme: _buttonGhostIconTheme,
      margin: _buttonZeroMargin,
    ),
  );
  static const AbstractButtonStyle link =
      ComponentThemeButtonStyle<LinkButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonLinkDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonLinkTextStyle,
      iconTheme: _buttonLinkIconTheme,
      margin: _buttonZeroMargin,
    ),
  );
  static const AbstractButtonStyle text =
      ComponentThemeButtonStyle<TextButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonTextTextStyle,
      iconTheme: _buttonTextIconTheme,
      margin: _buttonZeroMargin,
    ),
  );
  static const AbstractButtonStyle destructive =
      ComponentThemeButtonStyle<DestructiveButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonDestructiveDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonDestructiveTextStyle,
      iconTheme: _buttonDestructiveIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  static const AbstractButtonStyle fixed =
      ComponentThemeButtonStyle<FixedButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonStaticTextStyle,
      iconTheme: _buttonStaticIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  static const AbstractButtonStyle menu =
      ComponentThemeButtonStyle<MenuButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonMenuDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonMenuPadding,
      textStyle: _buttonMenuTextStyle,
      iconTheme: _buttonMenuIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  static const AbstractButtonStyle menubar =
      ComponentThemeButtonStyle<MenubarButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonMenuDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonMenubarPadding,
      textStyle: _buttonMenuTextStyle,
      iconTheme: _buttonMenuIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  static const AbstractButtonStyle muted =
      ComponentThemeButtonStyle<MutedButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonTextDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonPadding,
      textStyle: _buttonMutedTextStyle,
      iconTheme: _buttonMutedIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  static const AbstractButtonStyle card =
      ComponentThemeButtonStyle<CardButtonTheme>(
    fallback: ButtonVariance(
      decoration: _buttonCardDecoration,
      mouseCursor: _buttonMouseCursor,
      padding: _buttonCardPadding,
      textStyle: _buttonCardTextStyle,
      iconTheme: _buttonCardIconTheme,
      margin: _buttonZeroMargin,
    ),
  );

  @override
  final ButtonStateProperty<Decoration> decoration;
  @override
  final ButtonStateProperty<MouseCursor> mouseCursor;
  @override
  final ButtonStateProperty<EdgeInsetsGeometry> padding;
  @override
  final ButtonStateProperty<TextStyle> textStyle;
  @override
  final ButtonStateProperty<IconThemeData> iconTheme;
  @override
  final ButtonStateProperty<EdgeInsetsGeometry> margin;

  const ButtonVariance({
    required this.decoration,
    required this.mouseCursor,
    required this.padding,
    required this.textStyle,
    required this.iconTheme,
    required this.margin,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ButtonVariance &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode {
    return Object.hash(
        decoration, mouseCursor, padding, textStyle, iconTheme, margin);
  }

  @override
  String toString() {
    return 'ButtonVariance(decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin)';
  }
}

class ButtonStylePropertyAll<T> {
  final T value;

  const ButtonStylePropertyAll(this.value);

  T call(BuildContext context, Set<WidgetState> states, T value) {
    return this.value;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ButtonStylePropertyAll<T> && other.value == value;
  }

  @override
  int get hashCode {
    return value.hashCode;
  }

  @override
  String toString() => 'ButtonStylePropertyAll(value: $value)';
}

extension ButtonStyleExtension on AbstractButtonStyle {
  AbstractButtonStyle copyWith({
    ButtonStatePropertyDelegate<Decoration>? decoration,
    ButtonStatePropertyDelegate<MouseCursor>? mouseCursor,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding,
    ButtonStatePropertyDelegate<TextStyle>? textStyle,
    ButtonStatePropertyDelegate<IconThemeData>? iconTheme,
    ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin,
  }) {
    if (decoration == null &&
        mouseCursor == null &&
        padding == null &&
        textStyle == null &&
        iconTheme == null &&
        margin == null) {
      return this;
    }
    return _CopyWithButtonStyle(
      this,
      decoration,
      mouseCursor,
      padding,
      textStyle,
      iconTheme,
      margin,
    );
  }

  AbstractButtonStyle withBackgroundColor(
      {Color? color,
      Color? hoverColor,
      Color? focusColor,
      Color? disabledColor}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            color: states.disabled
                ? disabledColor ?? decoration.color
                : states.hovered
                    ? hoverColor ?? decoration.color
                    : states.focused
                        ? focusColor ?? decoration.color
                        : color,
          );
        }
        return decoration;
      },
    );
  }

  AbstractButtonStyle withForegroundColor(
      {Color? color,
      Color? hoverColor,
      Color? focusColor,
      Color? disabledColor}) {
    return copyWith(
      textStyle: (context, states, textStyle) {
        return textStyle.copyWith(
          color: states.disabled
              ? disabledColor ?? textStyle.color
              : states.hovered
                  ? hoverColor ?? textStyle.color
                  : states.focused
                      ? focusColor ?? textStyle.color
                      : color,
        );
      },
      iconTheme: (context, states, iconTheme) {
        return iconTheme.copyWith(
          color: states.disabled
              ? disabledColor ?? iconTheme.color
              : states.hovered
                  ? hoverColor ?? iconTheme.color
                  : states.focused
                      ? focusColor ?? iconTheme.color
                      : color,
        );
      },
    );
  }

  AbstractButtonStyle withBorder(
      {Border? border,
      Border? hoverBorder,
      Border? focusBorder,
      Border? disabledBorder}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            border: states.disabled
                ? disabledBorder ?? decoration.border
                : states.hovered
                    ? hoverBorder ?? decoration.border
                    : states.focused
                        ? focusBorder ?? decoration.border
                        : border,
          );
        }
        return decoration;
      },
    );
  }

  AbstractButtonStyle withBorderRadius(
      {BorderRadiusGeometry? borderRadius,
      BorderRadiusGeometry? hoverBorderRadius,
      BorderRadiusGeometry? focusBorderRadius,
      BorderRadiusGeometry? disabledBorderRadius}) {
    return copyWith(
      decoration: (context, states, decoration) {
        if (decoration is BoxDecoration) {
          return decoration.copyWith(
            borderRadius: states.disabled
                ? disabledBorderRadius ?? decoration.borderRadius
                : states.hovered
                    ? hoverBorderRadius ?? decoration.borderRadius
                    : states.focused
                        ? focusBorderRadius ?? decoration.borderRadius
                        : borderRadius,
          );
        }
        return decoration;
      },
    );
  }

  AbstractButtonStyle withPadding(
      {EdgeInsetsGeometry? padding,
      EdgeInsetsGeometry? hoverPadding,
      EdgeInsetsGeometry? focusPadding,
      EdgeInsetsGeometry? disabledPadding}) {
    return copyWith(
      padding: (context, states, padding) {
        return states.disabled
            ? disabledPadding ?? padding
            : states.hovered
                ? hoverPadding ?? padding
                : states.focused
                    ? focusPadding ?? padding
                    : padding;
      },
    );
  }
}

typedef ButtonStatePropertyDelegate<T> = T Function(
    BuildContext context, Set<WidgetState> states, T value);

class _CopyWithButtonStyle implements AbstractButtonStyle {
  final ButtonStatePropertyDelegate<Decoration>? _decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? _mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? _padding;
  final ButtonStatePropertyDelegate<TextStyle>? _textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? _iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? _margin;
  final AbstractButtonStyle _delegate;

  const _CopyWithButtonStyle(
    this._delegate,
    this._decoration,
    this._mouseCursor,
    this._padding,
    this._textStyle,
    this._iconTheme,
    this._margin,
  );

  @override
  ButtonStateProperty<IconThemeData> get iconTheme {
    if (_iconTheme == null) {
      return _delegate.iconTheme;
    }
    return _buildIconTheme;
  }

  IconThemeData _buildIconTheme(BuildContext context, Set<WidgetState> states) {
    return _iconTheme!(context, states, _delegate.iconTheme(context, states));
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (_textStyle == null) {
      return _delegate.textStyle;
    }
    return _buildTextStyle;
  }

  TextStyle _buildTextStyle(BuildContext context, Set<WidgetState> states) {
    return _textStyle!(context, states, _delegate.textStyle(context, states));
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding {
    if (_padding == null) {
      return _delegate.padding;
    }
    return _buildPadding;
  }

  EdgeInsetsGeometry _buildPadding(
      BuildContext context, Set<WidgetState> states) {
    return _padding!(context, states, _delegate.padding(context, states));
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor {
    if (_mouseCursor == null) {
      return _delegate.mouseCursor;
    }
    return _buildMouseCursor;
  }

  MouseCursor _buildMouseCursor(BuildContext context, Set<WidgetState> states) {
    return _mouseCursor!(
        context, states, _delegate.mouseCursor(context, states));
  }

  @override
  ButtonStateProperty<Decoration> get decoration {
    if (_decoration == null) {
      return _delegate.decoration;
    }
    return _buildDecoration;
  }

  Decoration _buildDecoration(BuildContext context, Set<WidgetState> states) {
    return _decoration!(context, states, _delegate.decoration(context, states));
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    if (_margin == null) {
      return _delegate.margin;
    }
    return _buildMargin;
  }

  EdgeInsetsGeometry _buildMargin(
      BuildContext context, Set<WidgetState> states) {
    return _margin!(context, states, _delegate.margin(context, states));
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _CopyWithButtonStyle &&
        other._delegate == _delegate &&
        other._decoration == _decoration &&
        other._mouseCursor == _mouseCursor &&
        other._padding == _padding &&
        other._textStyle == _textStyle &&
        other._iconTheme == _iconTheme &&
        other._margin == _margin;
  }

  @override
  int get hashCode {
    return Object.hash(_delegate, _decoration, _mouseCursor, _padding,
        _textStyle, _iconTheme, _margin);
  }

  @override
  String toString() {
    return '_CopyWithButtonStyle(_delegate: $_delegate, _decoration: $_decoration, _mouseCursor: $_mouseCursor, _padding: $_padding, _textStyle: $_textStyle, _iconTheme: $_iconTheme, _margin: $_margin)';
  }
}

EdgeInsets _buttonZeroMargin(BuildContext context, Set<WidgetState> states) {
  return EdgeInsets.zero;
}

MouseCursor _buttonMouseCursor(BuildContext context, Set<WidgetState> states) {
  return states.contains(WidgetState.disabled)
      ? SystemMouseCursors.basic
      : SystemMouseCursors.click;
}

EdgeInsets _buttonPadding(BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  return EdgeInsets.symmetric(
    horizontal: theme.scaling * 16,
    vertical: theme.scaling * 8,
  );
}

// CARD
TextStyle _buttonCardTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.copyWith(
    color: themeData.colorScheme.cardForeground,
  );
}

IconThemeData _buttonCardIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: themeData.colorScheme.cardForeground,
  );
}

Decoration _buttonCardDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted,
      borderRadius: BorderRadius.circular(themeData.radiusXl),
      border: Border.all(
        color: themeData.colorScheme.border,
        width: 1,
      ),
    );
  }
  if (states.contains(WidgetState.hovered) ||
      states.contains(WidgetState.selected)) {
    return BoxDecoration(
      color: themeData.colorScheme.border,
      borderRadius: BorderRadius.circular(themeData.radiusXl),
      border: Border.all(
        color: themeData.colorScheme.border,
        width: 1,
      ),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.card,
    borderRadius: BorderRadius.circular(themeData.radiusXl),
    border: Border.all(
      color: themeData.colorScheme.border,
      width: 1,
    ),
  );
}

EdgeInsets _buttonCardPadding(BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  return const EdgeInsets.all(16) * theme.scaling;
}

// MENUBUTTON
Decoration _buttonMenuDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return const BoxDecoration();
  }
  if (states.contains(WidgetState.focused) ||
      states.contains(WidgetState.hovered) ||
      states.contains(WidgetState.selected)) {
    return BoxDecoration(
      color: themeData.colorScheme.accent,
      borderRadius: BorderRadius.circular(themeData.radiusSm),
    );
  }
  return const BoxDecoration();
}

TextStyle _buttonMenuTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return themeData.typography.small.copyWith(
      color: themeData.colorScheme.accentForeground.scaleAlpha(0.5),
    );
  }
  return themeData.typography.small.copyWith(
    color: themeData.colorScheme.accentForeground,
  );
}

EdgeInsets _buttonMenuPadding(BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  final scaling = theme.scaling;
  final menuGroupData = Data.maybeOf<MenuGroupData>(context);
  if (menuGroupData != null && menuGroupData.direction == Axis.horizontal) {
    return const EdgeInsets.symmetric(horizontal: 18, vertical: 6) * scaling;
  }
  return const EdgeInsets.only(left: 8, top: 6, right: 6, bottom: 6) * scaling;
}

EdgeInsets _buttonMenubarPadding(
    BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  final scaling = theme.scaling;
  return const EdgeInsets.symmetric(horizontal: 12, vertical: 4) * scaling;
}

IconThemeData _buttonMenuIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: themeData.colorScheme.accentForeground,
  );
}

// PRIMARY
Decoration _buttonPrimaryDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.mutedForeground,
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.primary.scaleAlpha(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.primary,
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonPrimaryTextStyle(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: themeData.colorScheme.primaryForeground,
      );
}

IconThemeData _buttonPrimaryIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: themeData.colorScheme.primaryForeground,
  );
}

// SECONDARY
Decoration _buttonSecondaryDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.primaryForeground,
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.secondary.scaleAlpha(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.secondary,
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonSecondaryTextStyle(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.secondaryForeground,
      );
}

IconThemeData _buttonSecondaryIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.secondaryForeground,
  );
}

Decoration _buttonOutlineDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.border.withValues(
        alpha: 0,
      ),
      border: Border.all(
        color: themeData.colorScheme.border,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted.scaleAlpha(0.8),
      border: Border.all(
        color: themeData.colorScheme.muted.scaleAlpha(0.8),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.muted.withValues(alpha: 0),
    border: Border.all(
      color: themeData.colorScheme.muted,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonOutlineTextStyle(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.foreground,
      );
}

IconThemeData _buttonOutlineIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
  );
}

Decoration _buttonGhostDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted.withValues(alpha: 0),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted.scaleAlpha(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.muted.withValues(alpha: 0),
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonGhostTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.foreground,
      );
}

IconThemeData _buttonGhostIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
  );
}

TextStyle _buttonMutedTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: themeData.colorScheme.mutedForeground,
      );
}

IconThemeData _buttonMutedIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: themeData.colorScheme.mutedForeground,
  );
}

Decoration _buttonLinkDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return BoxDecoration(
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonLinkTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.foreground,
        decoration: states.contains(WidgetState.hovered)
            ? TextDecoration.underline
            : TextDecoration.none,
      );
}

IconThemeData _buttonLinkIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
  );
}

Decoration _buttonTextDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return BoxDecoration(
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonTextTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.hovered)
            ? themeData.colorScheme.primary
            : themeData.colorScheme.mutedForeground,
      );
}

IconThemeData _buttonTextIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.hovered)
        ? themeData.colorScheme.primary
        : themeData.colorScheme.mutedForeground,
  );
}

Decoration _buttonDestructiveDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  if (states.contains(WidgetState.disabled)) {
    return BoxDecoration(
      color: themeData.colorScheme.primaryForeground,
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.destructive.scaleAlpha(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: themeData.colorScheme.destructive,
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonDestructiveTextStyle(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return themeData.typography.small.merge(themeData.typography.medium).copyWith(
        color: states.contains(WidgetState.disabled)
            ? themeData.colorScheme.mutedForeground
            : themeData.colorScheme.destructiveForeground,
      );
}

IconThemeData _buttonDestructiveIconTheme(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return IconThemeData(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.destructiveForeground,
  );
}

// STATIC BUTTON
TextStyle _buttonStaticTextStyle(
    BuildContext context, Set<WidgetState> states) {
  final theme = Theme.of(context);
  return theme.typography.small.merge(theme.typography.medium).copyWith(
        color: theme.colorScheme.foreground,
      );
}

IconThemeData _buttonStaticIconTheme(
    BuildContext context, Set<WidgetState> states) {
  return const IconThemeData();
}

// Backward compatibility
class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const PrimaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.primary(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const SecondaryButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.secondary(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

class OutlineButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const OutlineButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.outline(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

class GhostButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const GhostButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.ghost(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

class LinkButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const LinkButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.link(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

class TextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const TextButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.text(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      child: child,
    );
  }
}

class DestructiveButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const DestructiveButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style:
          ButtonStyle.destructive(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

class TabButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const TabButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.fixed(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

class CardButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;

  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;

  const CardButton({
    super.key,
    required this.child,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle.card(size: size, density: density, shape: shape),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: child,
    );
  }
}

class IconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback? onPressed;
  final bool? enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;
  final ValueChanged<bool>? onHover;
  final ValueChanged<bool>? onFocus;
  final bool? enableFeedback;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureTapDownCallback? onSecondaryTapDown;
  final GestureTapUpCallback? onSecondaryTapUp;
  final GestureTapCancelCallback? onSecondaryTapCancel;
  final GestureTapDownCallback? onTertiaryTapDown;
  final GestureTapUpCallback? onTertiaryTapUp;
  final GestureTapCancelCallback? onTertiaryTapCancel;
  final GestureLongPressStartCallback? onLongPressStart;
  final GestureLongPressUpCallback? onLongPressUp;
  final GestureLongPressMoveUpdateCallback? onLongPressMoveUpdate;
  final GestureLongPressEndCallback? onLongPressEnd;
  final GestureLongPressUpCallback? onSecondaryLongPress;
  final GestureLongPressUpCallback? onTertiaryLongPress;
  final AbstractButtonStyle variance;

  const IconButton({
    super.key,
    required this.icon,
    required this.variance,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
  });

  const IconButton.primary({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.variance = ButtonVariance.primary,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  const IconButton.secondary({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.variance = ButtonVariance.secondary,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  const IconButton.outline({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.variance = ButtonVariance.outline,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  const IconButton.ghost({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.variance = ButtonVariance.ghost,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  const IconButton.link({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.variance = ButtonVariance.link,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  const IconButton.text({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.variance = ButtonVariance.text,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  const IconButton.destructive({
    super.key,
    required this.icon,
    this.onPressed,
    this.enabled,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.focusNode,
    this.disableTransition = false,
    this.onHover,
    this.onFocus,
    this.enableFeedback,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onSecondaryTapDown,
    this.onSecondaryTapUp,
    this.onSecondaryTapCancel,
    this.onTertiaryTapDown,
    this.onTertiaryTapUp,
    this.onTertiaryTapCancel,
    this.onLongPressStart,
    this.onLongPressUp,
    this.onLongPressMoveUpdate,
    this.onLongPressEnd,
    this.onSecondaryLongPress,
    this.onTertiaryLongPress,
    this.variance = ButtonVariance.destructive,
    this.density = ButtonDensity.icon,
    this.shape = ButtonShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      onPressed: onPressed,
      enabled: enabled,
      leading: leading,
      trailing: trailing,
      alignment: alignment,
      style: ButtonStyle(
        variance: variance,
        size: size,
        density: density,
        shape: shape,
      ),
      focusNode: focusNode,
      disableTransition: disableTransition,
      onHover: onHover,
      onFocus: onFocus,
      enableFeedback: enableFeedback,
      onTapDown: onTapDown,
      onTapUp: onTapUp,
      onTapCancel: onTapCancel,
      onSecondaryTapDown: onSecondaryTapDown,
      onSecondaryTapUp: onSecondaryTapUp,
      onSecondaryTapCancel: onSecondaryTapCancel,
      onTertiaryTapDown: onTertiaryTapDown,
      onTertiaryTapUp: onTertiaryTapUp,
      onTertiaryTapCancel: onTertiaryTapCancel,
      onLongPressStart: onLongPressStart,
      onLongPressUp: onLongPressUp,
      onLongPressMoveUpdate: onLongPressMoveUpdate,
      onLongPressEnd: onLongPressEnd,
      onSecondaryLongPress: onSecondaryLongPress,
      onTertiaryLongPress: onTertiaryLongPress,
      child: icon,
    );
  }
}

class ButtonStyleOverride extends StatelessWidget {
  final bool inherit;
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;
  final Widget child;

  const ButtonStyleOverride({
    super.key,
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
    required this.child,
  }) : inherit = false;

  const ButtonStyleOverride.inherit({
    super.key,
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
    required this.child,
  }) : inherit = true;

  @override
  Widget build(BuildContext context) {
    var decoration = this.decoration;
    var mouseCursor = this.mouseCursor;
    var padding = this.padding;
    var textStyle = this.textStyle;
    var iconTheme = this.iconTheme;
    var margin = this.margin;
    if (inherit) {
      var data = Data.maybeOf<ButtonStyleOverrideData>(context);
      if (data != null) {
        decoration = (context, state, value) {
          return data.decoration?.call(context, state,
                  decoration?.call(context, state, value) ?? value) ??
              decoration?.call(context, state, value) ??
              value;
        };
        mouseCursor = (context, state, value) {
          return data.mouseCursor?.call(context, state,
                  mouseCursor?.call(context, state, value) ?? value) ??
              mouseCursor?.call(context, state, value) ??
              value;
        };
        padding = (context, state, value) {
          return data.padding?.call(context, state,
                  padding?.call(context, state, value) ?? value) ??
              padding?.call(context, state, value) ??
              value;
        };
        textStyle = (context, state, value) {
          return data.textStyle?.call(context, state,
                  textStyle?.call(context, state, value) ?? value) ??
              textStyle?.call(context, state, value) ??
              value;
        };
        iconTheme = (context, state, value) {
          return data.iconTheme?.call(context, state,
                  iconTheme?.call(context, state, value) ?? value) ??
              iconTheme?.call(context, state, value) ??
              value;
        };
        margin = (context, state, value) {
          return data.margin?.call(context, state,
                  margin?.call(context, state, value) ?? value) ??
              margin?.call(context, state, value) ??
              value;
        };
      }
    }
    return Data.inherit(
      data: ButtonStyleOverrideData(
        decoration: decoration,
        mouseCursor: mouseCursor,
        padding: padding,
        textStyle: textStyle,
        iconTheme: iconTheme,
        margin: margin,
      ),
      child: child,
    );
  }
}

class ButtonStyleOverrideData {
  final ButtonStatePropertyDelegate<Decoration>? decoration;
  final ButtonStatePropertyDelegate<MouseCursor>? mouseCursor;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? padding;
  final ButtonStatePropertyDelegate<TextStyle>? textStyle;
  final ButtonStatePropertyDelegate<IconThemeData>? iconTheme;
  final ButtonStatePropertyDelegate<EdgeInsetsGeometry>? margin;

  const ButtonStyleOverrideData({
    this.decoration,
    this.mouseCursor,
    this.padding,
    this.textStyle,
    this.iconTheme,
    this.margin,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is ButtonStyleOverrideData &&
        other.decoration == decoration &&
        other.mouseCursor == mouseCursor &&
        other.padding == padding &&
        other.textStyle == textStyle &&
        other.iconTheme == iconTheme &&
        other.margin == margin;
  }

  @override
  int get hashCode {
    return Object.hash(
      decoration,
      mouseCursor,
      padding,
      textStyle,
      iconTheme,
      margin,
    );
  }

  @override
  String toString() {
    return 'ButtonStyleOverrideData(decoration: $decoration, mouseCursor: $mouseCursor, padding: $padding, textStyle: $textStyle, iconTheme: $iconTheme, margin: $margin)';
  }
}

class ButtonGroup extends StatelessWidget {
  final Axis direction;
  final List<Widget> children;

  const ButtonGroup({
    super.key,
    this.direction = Axis.horizontal,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> children = this.children;
    if (children.length > 1) {
      for (int i = 0; i < children.length; i++) {
        children[i] = ButtonStyleOverride(
          decoration: (context, states, value) {
            if (value is BoxDecoration) {
              BorderRadius resolvedBorderRadius;
              BorderRadiusGeometry? borderRadius = value.borderRadius;
              if (borderRadius is BorderRadius) {
                resolvedBorderRadius = borderRadius;
              } else if (borderRadius == null) {
                resolvedBorderRadius = BorderRadius.zero;
              } else {
                resolvedBorderRadius =
                    borderRadius.resolve(Directionality.of(context));
              }
              if (direction == Axis.horizontal) {
                if (i == 0) {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topRight: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  );
                } else if (i == children.length - 1) {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topLeft: Radius.zero,
                      bottomLeft: Radius.zero,
                    ),
                  );
                } else {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  );
                }
              } else {
                if (i == 0) {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  );
                } else if (i == children.length - 1) {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                    ),
                  );
                } else {
                  return value.copyWith(
                    borderRadius: resolvedBorderRadius.copyWith(
                      topLeft: Radius.zero,
                      topRight: Radius.zero,
                      bottomLeft: Radius.zero,
                      bottomRight: Radius.zero,
                    ),
                  );
                }
              }
            }
            return value;
          },
          child: children[i],
        );
      }
    }
    Widget flex = Flex(
      mainAxisSize: MainAxisSize.min,
      direction: direction,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: children,
    );
    if (direction == Axis.horizontal) {
      flex = IntrinsicHeight(child: flex);
    } else {
      flex = IntrinsicWidth(child: flex);
    }
    return flex;
  }
}
