import 'package:shadcn_flutter/shadcn_flutter.dart';

class Menubar extends StatelessWidget {
  final List<Widget> children;

  const Menubar({required this.children});

  @override
  Widget build(BuildContext context) {
    return MenuGroup<MenubarData>(
      dataBuilder: () {
        return MenubarData();
      },
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ).medium(),
    );
  }
}
