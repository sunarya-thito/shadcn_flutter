import 'dart:math';

import '../../shadcn_flutter.dart';

class Toggle extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Widget child;
  final ButtonStyle style;

  const Toggle({
    Key? key,
    required this.value,
    this.onChanged,
    required this.child,
    this.style = const ButtonStyle.ghost(),
  }) : super(key: key);

  @override
  _ToggleState createState() => _ToggleState();
}

// toggle button is just ghost button
class _ToggleState extends State<Toggle> {
  @override
  Widget build(BuildContext context) {
    return Button(
        child: widget.child,
        style: widget.value
            ? ButtonStyle.secondary(
                density: widget.style.density,
                shape: widget.style.shape,
                size: widget.style.size,
              )
            : widget.style.copyWith(
                textStyle: (context, states, value) {
                  final theme = Theme.of(context);
                  return value.copyWith(
                    color: states.contains(WidgetState.hovered)
                        ? theme.colorScheme.mutedForeground
                        : null,
                  );
                },
              ),
        onPressed: () {
          if (widget.onChanged != null) {
            widget.onChanged!(!widget.value);
          }
        });
  }
}

class Button extends StatefulWidget {
  static const EdgeInsets normalPadding = EdgeInsets.symmetric(
    horizontal: 16,
    vertical: 8,
  );
  static const EdgeInsets badgePadding = EdgeInsets.symmetric(
    horizontal: 10,
    vertical: 2,
  );
  final bool enabled;
  final bool disableTransition;
  final Widget? leading;
  final Widget? trailing;
  final Widget child;
  final VoidCallback? onPressed;
  final FocusNode? focusNode;
  final AlignmentGeometry? alignment;
  final AbstractButtonStyle style;
  const Button({
    Key? key,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    required this.style,
    this.enabled = true,
    this.disableTransition = false,
  }) : super(key: key);

  const Button.primary({
    super.key,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled = true,
    this.style = ButtonVariance.primary,
    this.disableTransition = false,
  });

  const Button.secondary({
    super.key,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled = true,
    this.style = ButtonVariance.secondary,
    this.disableTransition = false,
  });

  const Button.outline({
    super.key,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled = true,
    this.style = ButtonVariance.outline,
    this.disableTransition = false,
  });

  const Button.ghost({
    super.key,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled = true,
    this.style = ButtonVariance.ghost,
    this.disableTransition = false,
  });

  const Button.link({
    super.key,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled = true,
    this.style = ButtonVariance.link,
    this.disableTransition = false,
  });

  const Button.text({
    super.key,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled = true,
    this.style = ButtonVariance.text,
    this.disableTransition = false,
  });

  const Button.destructive({
    super.key,
    this.leading,
    this.trailing,
    required this.child,
    this.onPressed,
    this.focusNode,
    this.alignment,
    this.enabled = true,
    this.style = ButtonVariance.destructive,
    this.disableTransition = false,
  });

  @override
  ButtonState createState() => ButtonState();
}

class ButtonState<T extends Button> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Clickable(
      enabled: widget.enabled && widget.onPressed != null,
      disableTransition: widget.disableTransition,
      decoration: WidgetStateProperty.resolveWith((states) {
        return widget.style.decoration(context, states);
      }),
      mouseCursor: WidgetStateProperty.resolveWith((states) {
        return widget.style.mouseCursor(context, states);
      }),
      padding: WidgetStateProperty.resolveWith((states) {
        return widget.style.padding(context, states);
      }),
      textStyle: WidgetStateProperty.resolveWith((states) {
        return widget.style.textStyle(context, states);
      }),
      iconTheme: WidgetStateProperty.resolveWith((states) {
        return widget.style.iconTheme(context, states);
      }),
      onPressed: widget.onPressed,
      child: BasicLayout(
        trailing: widget.trailing,
        leading: widget.leading,
        contentSpacing: 8,
        content: UnderlineInterceptor(child: widget.child),
        trailingAlignment: Alignment.center,
        leadingAlignment: Alignment.center,
        contentAlignment: widget.alignment ?? Alignment.centerLeft,
      ),
    );
  }
}

enum ButtonSize {
  normal(1),
  xSmall(1 / 2),
  small(3 / 4),
  large(2),
  xLarge(3);

  final double scale;

  const ButtonSize(this.scale);
}

typedef DensityModifier = EdgeInsets Function(EdgeInsets padding);

enum ButtonDensity {
  normal(_densityNormal),
  comfortable(_densityComfortable),
  icon(_densityIcon),
  iconComfortable(_densityIconComfortable),
  dense(_densityDense),
  compact(_densityCompact);

  final DensityModifier modifier;

  const ButtonDensity(this.modifier);
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
  final ButtonVariance variance;
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

  @override
  ButtonStateProperty<Decoration> get decoration {
    if (shape == ButtonShape.circle) {
      return (context, states) {
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
          throw Exception(
              'Unsupported decoration type ${decoration.runtimeType}');
        }
      };
    }
    return variance.decoration;
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
    return (context, states) {
      return density.modifier(variance.padding(context, states) * size.scale);
    };
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (size == ButtonSize.normal) {
      return variance.textStyle;
    }
    return (context, states) {
      var fontSize = variance.textStyle(context, states).fontSize;
      if (fontSize == null) {
        final textStyle = DefaultTextStyle.of(context).style;
        fontSize = textStyle.fontSize ?? 14;
      }
      return variance.textStyle(context, states).copyWith(
            fontSize: fontSize * size.scale,
          );
    };
  }

  @override
  ButtonStateProperty<IconThemeData> get iconTheme {
    if (size == ButtonSize.normal) {
      return variance.iconTheme;
    }
    return (context, states) {
      var iconSize = variance.iconTheme(context, states).size;
      iconSize ??= IconTheme.of(context).size ?? 24;
      return variance.iconTheme(context, states).copyWith(
            size: iconSize * size.scale,
          );
    };
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    return (context, states) {
      return EdgeInsets.zero;
    };
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

class ButtonVariance implements AbstractButtonStyle {
  static const ButtonVariance primary = ButtonVariance(
    decoration: _buttonPrimaryDecoration,
    mouseCursor: _buttonMouseCursor,
    padding: _buttonPadding,
    textStyle: _buttonPrimaryTextStyle,
    iconTheme: _buttonPrimaryIconTheme,
    margin: _buttonZeroMargin,
  );
  static const ButtonVariance secondary = ButtonVariance(
    decoration: _buttonSecondaryDecoration,
    mouseCursor: _buttonMouseCursor,
    padding: _buttonPadding,
    textStyle: _buttonSecondaryTextStyle,
    iconTheme: _buttonSecondaryIconTheme,
    margin: _buttonZeroMargin,
  );
  static const ButtonVariance outline = ButtonVariance(
    decoration: _buttonOutlineDecoration,
    mouseCursor: _buttonMouseCursor,
    padding: _buttonPadding,
    textStyle: _buttonOutlineTextStyle,
    iconTheme: _buttonOutlineIconTheme,
    margin: _buttonZeroMargin,
  );
  static const ButtonVariance ghost = ButtonVariance(
    decoration: _buttonGhostDecoration,
    mouseCursor: _buttonMouseCursor,
    padding: _buttonPadding,
    textStyle: _buttonGhostTextStyle,
    iconTheme: _buttonGhostIconTheme,
    margin: _buttonZeroMargin,
  );
  static const ButtonVariance link = ButtonVariance(
    decoration: _buttonLinkDecoration,
    mouseCursor: _buttonMouseCursor,
    padding: _buttonPadding,
    textStyle: _buttonLinkTextStyle,
    iconTheme: _buttonLinkIconTheme,
    margin: _buttonZeroMargin,
  );
  static const ButtonVariance text = ButtonVariance(
    decoration: _buttonTextDecoration,
    mouseCursor: _buttonMouseCursor,
    padding: _buttonPadding,
    textStyle: _buttonTextTextStyle,
    iconTheme: _buttonTextIconTheme,
    margin: _buttonZeroMargin,
  );
  static const ButtonVariance destructive = ButtonVariance(
    decoration: _buttonDestructiveDecoration,
    mouseCursor: _buttonMouseCursor,
    padding: _buttonPadding,
    textStyle: _buttonDestructiveTextStyle,
    iconTheme: _buttonDestructiveIconTheme,
    margin: _buttonZeroMargin,
  );
  static const ButtonVariance fixed = ButtonVariance(
    decoration: _buttonTextDecoration,
    mouseCursor: _buttonMouseCursor,
    padding: _buttonPadding,
    textStyle: _buttonStaticTextStyle,
    iconTheme: _buttonStaticIconTheme,
    margin: _buttonZeroMargin,
  );

  final ButtonStateProperty<Decoration> decoration;
  final ButtonStateProperty<MouseCursor> mouseCursor;
  final ButtonStateProperty<EdgeInsets> padding;
  final ButtonStateProperty<TextStyle> textStyle;
  final ButtonStateProperty<IconThemeData> iconTheme;
  final ButtonStateProperty<EdgeInsets> margin;

  const ButtonVariance({
    required this.decoration,
    required this.mouseCursor,
    required this.padding,
    required this.textStyle,
    required this.iconTheme,
    required this.margin,
  });
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
    return (context, states) {
      return _iconTheme!(context, states, _delegate.iconTheme(context, states));
    };
  }

  @override
  ButtonStateProperty<TextStyle> get textStyle {
    if (_textStyle == null) {
      return _delegate.textStyle;
    }
    return (context, states) {
      return _textStyle!(context, states, _delegate.textStyle(context, states));
    };
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get padding {
    if (_padding == null) {
      return _delegate.padding;
    }
    return (context, states) {
      return _padding!(context, states, _delegate.padding(context, states));
    };
  }

  @override
  ButtonStateProperty<MouseCursor> get mouseCursor {
    if (_mouseCursor == null) {
      return _delegate.mouseCursor;
    }
    return (context, states) {
      return _mouseCursor!(
          context, states, _delegate.mouseCursor(context, states));
    };
  }

  @override
  ButtonStateProperty<Decoration> get decoration {
    if (_decoration == null) {
      return _delegate.decoration;
    }
    return (context, states) {
      return _decoration!(
          context, states, _delegate.decoration(context, states));
    };
  }

  @override
  ButtonStateProperty<EdgeInsetsGeometry> get margin {
    if (_margin == null) {
      return _delegate.margin;
    }
    return (context, states) {
      return _margin!(context, states, _delegate.margin(context, states));
    };
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
  return Button.normalPadding;
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
  return TextStyle(
    color: themeData.colorScheme.accentForeground,
  );
}

EdgeInsets _buttonMenuPadding(BuildContext context, Set<WidgetState> states) {
  return const EdgeInsets.symmetric(horizontal: 8, vertical: 6);
}

EdgeInsets _buttonMenubarPadding(
    BuildContext context, Set<WidgetState> states) {
  return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
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
      color: themeData.colorScheme.primary.withOpacity(0.8),
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
  return TextStyle(
    color: themeData.colorScheme.primaryForeground,
    fontWeight: FontWeight.w500,
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
      color: themeData.colorScheme.secondary.withOpacity(0.8),
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
  return TextStyle(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.secondaryForeground,
    fontWeight: FontWeight.w500,
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
      color: Colors.transparent,
      border: Border.all(
        color: themeData.colorScheme.muted,
        width: 1,
      ),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted.withOpacity(0.8),
      border: Border.all(
        color: themeData.colorScheme.muted.withOpacity(0.8),
        width: 1,
      ),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: Colors.transparent,
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
  return TextStyle(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
    fontWeight: FontWeight.w500,
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
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  if (states.contains(WidgetState.hovered)) {
    return BoxDecoration(
      color: themeData.colorScheme.muted.withOpacity(0.8),
      borderRadius: BorderRadius.circular(themeData.radiusMd),
    );
  }
  return BoxDecoration(
    color: Colors.transparent,
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonGhostTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return TextStyle(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
    fontWeight: FontWeight.w500,
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

Decoration _buttonLinkDecoration(
    BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return BoxDecoration(
    borderRadius: BorderRadius.circular(themeData.radiusMd),
  );
}

TextStyle _buttonLinkTextStyle(BuildContext context, Set<WidgetState> states) {
  var themeData = Theme.of(context);
  return TextStyle(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.foreground,
    decoration: states.contains(WidgetState.hovered)
        ? TextDecoration.underline
        : TextDecoration.none,
    fontWeight: FontWeight.w500,
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
  return TextStyle(
    color: states.contains(WidgetState.hovered)
        ? themeData.colorScheme.primary
        : themeData.colorScheme.mutedForeground,
    fontWeight: FontWeight.w500,
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
      color: themeData.colorScheme.destructive.withOpacity(0.8),
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
  return TextStyle(
    color: states.contains(WidgetState.disabled)
        ? themeData.colorScheme.mutedForeground
        : themeData.colorScheme.destructiveForeground,
    fontWeight: FontWeight.w500,
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
  return const TextStyle();
}

IconThemeData _buttonStaticIconTheme(
    BuildContext context, Set<WidgetState> states) {
  return const IconThemeData();
}

// Backward compatibility
class PrimaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;

  const PrimaryButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
  }) : super(key: key);

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
      child: child,
      disableTransition: disableTransition,
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;

  const SecondaryButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
  }) : super(key: key);

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
      child: child,
    );
  }
}

class OutlineButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;

  const OutlineButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
  }) : super(key: key);

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
      child: child,
    );
  }
}

class GhostButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;

  const GhostButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
  }) : super(key: key);

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
      child: child,
      disableTransition: disableTransition,
    );
  }
}

class LinkButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;

  const LinkButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
  }) : super(key: key);

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
      child: child,
    );
  }
}

class TextButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;

  const TextButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
  }) : super(key: key);

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
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;

  const DestructiveButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
  }) : super(key: key);

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
      child: child,
    );
  }
}

class TabButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final bool enabled;
  final Widget? leading;
  final Widget? trailing;
  final AlignmentGeometry? alignment;
  final ButtonSize size;
  final ButtonDensity density;
  final ButtonShape shape;
  final FocusNode? focusNode;
  final bool disableTransition;

  const TabButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.enabled = true,
    this.leading,
    this.trailing,
    this.alignment,
    this.size = ButtonSize.normal,
    this.density = ButtonDensity.normal,
    this.shape = ButtonShape.rectangle,
    this.focusNode,
    this.disableTransition = false,
  }) : super(key: key);

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
      child: child,
    );
  }
}
