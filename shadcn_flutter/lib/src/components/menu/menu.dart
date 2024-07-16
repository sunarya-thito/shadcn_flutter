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
    final menuBarData = Data.maybeOf<MenubarData>(context);
    final menuData = Data.maybeOf<MenuData>(context);
    assert(menuData != null || menuBarData != null,
        'MenuButton must be a descendant of Menubar or Menu');
    print('menuData: $menuData menuBarData: $menuBarData');
    return Button(
      style: menuBarData == null ? ButtonVariance.menu : ButtonVariance.menubar,
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

class MenubarData extends MenuData {}

class MenuData {}

class MenuGroup<T extends MenuData> extends StatelessWidget {
  final Widget child;
  final T Function() dataBuilder;

  const MenuGroup({required this.child, required this.dataBuilder});

  @override
  Widget build(BuildContext context) {
    return Data<T>(
      data: dataBuilder(),
      child: child,
    );
  }
}
