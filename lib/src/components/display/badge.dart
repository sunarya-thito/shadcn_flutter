import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme for [PrimaryBadge], [SecondaryBadge], [OutlineBadge], and
/// [DestructiveBadge].
class BadgeTheme {
  /// Style for [PrimaryBadge].
  final AbstractButtonStyle? primaryStyle;

  /// Style for [SecondaryBadge].
  final AbstractButtonStyle? secondaryStyle;

  /// Style for [OutlineBadge].
  final AbstractButtonStyle? outlineStyle;

  /// Style for [DestructiveBadge].
  final AbstractButtonStyle? destructiveStyle;

  /// Creates a [BadgeTheme].
  const BadgeTheme({
    this.primaryStyle,
    this.secondaryStyle,
    this.outlineStyle,
    this.destructiveStyle,
  });

  /// Returns a copy of this theme with the given fields replaced.
  BadgeTheme copyWith({
    ValueGetter<AbstractButtonStyle?>? primaryStyle,
    ValueGetter<AbstractButtonStyle?>? secondaryStyle,
    ValueGetter<AbstractButtonStyle?>? outlineStyle,
    ValueGetter<AbstractButtonStyle?>? destructiveStyle,
  }) {
    return BadgeTheme(
      primaryStyle: primaryStyle == null ? this.primaryStyle : primaryStyle(),
      secondaryStyle: secondaryStyle == null
          ? this.secondaryStyle
          : secondaryStyle(),
      outlineStyle: outlineStyle == null ? this.outlineStyle : outlineStyle(),
      destructiveStyle: destructiveStyle == null
          ? this.destructiveStyle
          : destructiveStyle(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BadgeTheme &&
        other.primaryStyle == primaryStyle &&
        other.secondaryStyle == secondaryStyle &&
        other.outlineStyle == outlineStyle &&
        other.destructiveStyle == destructiveStyle;
  }

  @override
  int get hashCode =>
      Object.hash(primaryStyle, secondaryStyle, outlineStyle, destructiveStyle);
}

class PrimaryBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const PrimaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle =
        style ??
        compTheme?.primaryStyle ??
        const ButtonStyle.primary(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

class SecondaryBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const SecondaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle =
        style ??
        compTheme?.secondaryStyle ??
        const ButtonStyle.secondary(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

class OutlineBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const OutlineBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle =
        style ??
        compTheme?.outlineStyle ??
        const ButtonStyle.outline(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}

class DestructiveBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final AbstractButtonStyle? style;

  const DestructiveBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BadgeTheme>(context);
    final baseStyle =
        style ??
        compTheme?.destructiveStyle ??
        const ButtonStyle.destructive(
          size: ButtonSize.small,
          density: ButtonDensity.dense,
          shape: ButtonShape.rectangle,
        ).copyWith(
          textStyle: (context, states, value) {
            return value.copyWith(fontWeight: FontWeight.w500);
          },
        );
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed,
        enabled: true,
        style: baseStyle,
        child: child,
      ),
    );
  }
}
