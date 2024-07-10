// WIP
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizablePanel extends StatelessWidget {
  final List<Widget> children;
  final AxisDirection direction;
  final WidgetBuilder? dividerBuilder;
  final double dividerSize;

  const ResizablePanel({
    Key? key,
    required this.children,
    this.direction = AxisDirection.down,
    this.dividerBuilder,
    this.dividerSize = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
