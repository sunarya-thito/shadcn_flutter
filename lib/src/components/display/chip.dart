import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme for [Chip].
class ChipTheme {
  /// The padding inside the chip.
  final EdgeInsetsGeometry? padding;

  /// The default [Button] style of the chip.
  final AbstractButtonStyle? style;

  /// Creates a [ChipTheme].
  const ChipTheme({this.padding, this.style});

  /// Creates a copy of this theme with the given values replaced.
  ChipTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<AbstractButtonStyle?>? style,
  }) {
    return ChipTheme(
      padding: padding == null ? this.padding : padding(),
      style: style == null ? this.style : style(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ChipTheme &&
        other.padding == padding &&
        other.style == style;
  }

  @override
  int get hashCode => Object.hash(padding, style);
}

class ChipButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const ChipButton({
    super.key,
    required this.child,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ChipTheme>(context);
    final padding = styleValue(
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.zero,
    );
    final style = compTheme?.style ??
        ButtonVariance(
          decoration: (context, states) {
            return const BoxDecoration();
          },
          mouseCursor: (context, states) {
            if (states.contains(WidgetState.disabled)) {
              return SystemMouseCursors.basic;
            }
            return SystemMouseCursors.click;
          },
          padding: (context, states) {
            return padding;
          },
          textStyle: (context, states) {
            return const TextStyle();
          },
          iconTheme: (context, states) {
            return theme.iconTheme.xSmall;
          },
          margin: (context, states) {
            return EdgeInsets.zero;
          },
        );
    return Button(
      style: style,
      onPressed: onPressed,
      child: child,
    );
  }
}

class Chip extends StatelessWidget {
  final Widget child;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;
  final AbstractButtonStyle? style;

  const Chip({
    super.key,
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<ChipTheme>(context);
    final baseStyle = style ?? compTheme?.style ?? ButtonVariance.secondary;
    return Button(
      style: baseStyle.copyWith(
        mouseCursor: (context, states, value) {
          return onPressed != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic;
        },
        padding: (context, states, value) {
          final widgetPadding = style?.padding?.call(context, states);
          return styleValue(
            widgetValue: widgetPadding,
            themeValue: compTheme?.padding,
            defaultValue: EdgeInsets.symmetric(
              horizontal: theme.scaling * 8,
              vertical: theme.scaling * 4,
            ),
          );
        },
      ),
      onPressed: onPressed ?? () {},
      leading: leading,
      trailing: trailing,
      child: child,
    );
  }
}
