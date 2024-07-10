import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Item 1'),
        Text('Item 2'),
        Text('Item 3'),
      ],
    ).separator(Divider());
  }
}
