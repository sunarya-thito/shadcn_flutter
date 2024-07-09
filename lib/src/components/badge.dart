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
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed ?? () {},
        style: ButtonVariance.primary.copyWith(
          textStyle: (context, states, value) => textStyle ?? value,
          padding: (context, states, value) => padding ?? Button.badgePadding,
        ),
        child: child,
      ).xSmall().semiBold(),
    );
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
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed ?? () {},
        style: ButtonVariance.secondary.copyWith(
          textStyle: (context, states, value) => textStyle ?? value,
          padding: (context, states, value) => padding ?? Button.badgePadding,
        ),
        child: child,
      ).xSmall().semiBold(),
    );
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
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed ?? () {},
        style: ButtonVariance.outline.copyWith(
          textStyle: (context, states, value) => textStyle ?? value,
          padding: (context, states, value) => padding ?? Button.badgePadding,
        ),
        child: child,
      ).xSmall().semiBold(),
    );
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
    return ExcludeFocus(
      child: Button(
        leading: leading,
        trailing: trailing,
        onPressed: onPressed ?? () {},
        style: ButtonVariance.destructive.copyWith(
          textStyle: (context, states, value) => textStyle ?? value,
          padding: (context, states, value) => padding ?? Button.badgePadding,
        ),
        child: child,
      ).xSmall().semiBold(),
    );
  }
}
