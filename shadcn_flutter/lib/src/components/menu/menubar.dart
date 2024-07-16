import 'package:shadcn_flutter/shadcn_flutter.dart';

class Menubar extends StatefulWidget {
  final FocusNode? focusScopeNode;
  final List<Widget> children;
  final Offset? popoverOffset;

  const Menubar({
    this.focusScopeNode,
    this.popoverOffset,
    required this.children,
  });

  @override
  State<Menubar> createState() => _MenubarState();
}

class _MenubarState extends State<Menubar> {
  late FocusNode _focusScopeNode;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = widget.focusScopeNode ?? FocusNode();
  }

  @override
  void didUpdateWidget(covariant Menubar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusScopeNode != oldWidget.focusScopeNode) {
      _focusScopeNode = widget.focusScopeNode ?? FocusNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MenuGroup<MenubarData>(
      anchorAlignment: Alignment.bottomLeft,
      popoverAlignment: Alignment.topLeft,
      popoverOffset: widget.popoverOffset ?? const Offset(0, -8),
      children: widget.children,
      dataBuilder: () {
        return MenubarData();
      },
      builder: (context, children) {
        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ).medium();
      },
    );
  }
}
