import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text('Item 1'),
        Text('Item 2'),
        Text('Item 3'),
      ],
    ).gap(32);
  }
}
