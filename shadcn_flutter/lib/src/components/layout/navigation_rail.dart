import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationRail extends StatelessWidget {
  final Color? backgroundColor;
  final bool extended;
  final List<Widget> leading;
  final List<Widget> trailing;
  final int? index;
  final ValueChanged<int>? onChanged;
  final List<Widget> children;
  final AlignmentGeometry alignment;

  const NavigationRail({
    Key? key,
    this.backgroundColor,
    this.extended = false,
    this.leading = const <Widget>[],
    this.trailing = const <Widget>[],
    this.index,
    this.onChanged,
    required this.children,
    this.alignment = AlignmentDirectional.topCenter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

enum NavigationLabelType {
  none,
  selected,
  all,
}

class NavigationControlData {
  final int index;
  final int? selectedIndex;
  final int count;
  final NavigationLabelType parentLabelType;

  NavigationControlData({
    required this.index,
    required this.selectedIndex,
    required this.count,
    required this.parentLabelType,
  });
}

class NavigationButton extends StatelessWidget {
  final Widget child;
  final Widget? label;

  const NavigationButton({
    Key? key,
    required this.child,
    this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
