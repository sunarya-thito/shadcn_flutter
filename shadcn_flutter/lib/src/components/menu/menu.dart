import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenuButton extends StatelessWidget {
  final Widget child;
  final List<Widget>? subMenu;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final Widget? leading;
  final bool enabled;

  MenuButton({
    required this.child,
    this.subMenu,
    this.onPressed,
    this.trailing,
    this.leading,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      style: ButtonVariance.ghost,
      trailing: trailing,
      leading: leading,
      disableTransition: true,
      enabled: enabled,
      onPressed: () {
        onPressed?.call();
      },
      child: child,
    );
  }
}
