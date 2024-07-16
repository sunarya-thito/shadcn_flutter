import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenuButton extends StatelessWidget {
  final Widget child;
  final List<Widget> subMenu;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final Widget? leading;
  final bool enabled;
}
