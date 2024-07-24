import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipButton extends StatelessWidget {
  final Widget child;
  final VoidCallback? onPressed;

  const ChipButton({
    Key? key,
    required this.child,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      style: ButtonVariance(
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
          return EdgeInsets.zero;
        },
        textStyle: (context, states) {
          return const TextStyle();
        },
        iconTheme: (context, states) {
          return const IconThemeData(size: 12);
        },
        margin: (context, states) {
          return EdgeInsets.zero;
        },
      ),
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

  const Chip({
    Key? key,
    required this.child,
    this.leading,
    this.trailing,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Button(
      style: ButtonVariance.secondary.copyWith(
        mouseCursor: (context, states, value) {
          return onPressed != null
              ? SystemMouseCursors.click
              : SystemMouseCursors.basic;
        },
        padding: (context, states, value) {
          return const EdgeInsets.symmetric(horizontal: 8, vertical: 4);
        },
      ),
      onPressed: onPressed ?? () {},
      leading: leading,
      trailing: trailing,
      child: child,
    );
  }
}
