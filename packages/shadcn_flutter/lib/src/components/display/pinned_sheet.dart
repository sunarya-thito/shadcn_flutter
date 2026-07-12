import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef PinnedSheetBuilder = Widget Function(BuildContext context);

abstract class SheetDragStage {
  double? resolveDragOffset(Size size, OverlayPosition position);
}

class PinnedSheet extends StatelessWidget {
  final Widget child;
  final OverlayPosition position;
  const PinnedSheet({
    super.key,
    this.position = OverlayPosition.bottom,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
