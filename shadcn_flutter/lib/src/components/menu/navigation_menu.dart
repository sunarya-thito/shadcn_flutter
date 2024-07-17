import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationItem extends StatelessWidget {
  final VoidCallback? onPressed;
  final NavigationContent? content;
  final Widget child;

  const NavigationItem({this.onPressed, this.content, required this.child});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class NavigationContent extends StatelessWidget {
  final Widget child;

  const NavigationContent({required this.child});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class NavigationContentList extends StatelessWidget {
  final Widget? primary;
  final List<Widget> children;

  const NavigationContentList({this.primary, required this.children});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class NavigationContentItem extends StatelessWidget {
  final Widget? icon;
  final Widget title;
  final Widget content;

  const NavigationContentItem(
      {this.icon, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}

class NavigationMenu extends StatelessWidget {
  final List<Widget> children;

  const NavigationMenu({required this.children});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
