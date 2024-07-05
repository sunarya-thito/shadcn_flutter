import 'package:shadcn_flutter/shadcn_flutter.dart';

class PrimaryBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const PrimaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed ?? () {},
      padding: padding ?? Button.badgePadding,
      textStyle: textStyle ?? Button.badgeTextStyle,
      child: child,
    ).xSmall().semiBold();
  }
}

class SecondaryBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const SecondaryBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed ?? () {},
      padding: padding ?? Button.badgePadding,
      textStyle: textStyle ?? Button.badgeTextStyle,
      child: child,
    ).xSmall().semiBold();
  }
}

class OutlineBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const OutlineBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed ?? () {},
      padding: padding ?? Button.badgePadding,
      textStyle: textStyle ?? Button.badgeTextStyle,
      child: child,
    ).xSmall().semiBold();
  }
}

class DestructiveBadge extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const DestructiveBadge({
    super.key,
    required this.child,
    this.onPressed,
    this.leading,
    this.trailing,
    this.padding,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return DestructiveButton(
      leading: leading,
      trailing: trailing,
      onPressed: onPressed ?? () {},
      padding: padding ?? Button.badgePadding,
      textStyle: textStyle ?? Button.badgeTextStyle,
      child: child,
    ).xSmall().semiBold();
  }
}
