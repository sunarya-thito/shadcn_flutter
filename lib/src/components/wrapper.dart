import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef WrapperBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

class Wrapper extends StatefulWidget {
  final Widget child;
  final WrapperBuilder? builder;
  final bool wrap;
  final bool maintainStructure;

  const Wrapper({
    super.key,
    required this.child,
    this.builder,
    this.wrap = true,
    this.maintainStructure = false,
  });

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Widget wrappedChild = widget.child;
    if (widget.maintainStructure) {
      wrappedChild = KeyedSubtree(
        key: _key,
        child: wrappedChild,
      );
    }
    if (widget.wrap && widget.builder != null) {
      wrappedChild = widget.builder!(context, wrappedChild);
    }
    return wrappedChild;
  }
}
