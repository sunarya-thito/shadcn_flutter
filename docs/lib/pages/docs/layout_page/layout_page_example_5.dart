import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample5 extends StatelessWidget {
  const LayoutPageExample5({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          Text('Item 2'),
          Text('Item 3'),
        ],
      ).separator(const Divider()),
    );
  }
}
