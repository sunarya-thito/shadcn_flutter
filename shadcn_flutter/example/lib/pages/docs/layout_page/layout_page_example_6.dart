import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(' Item 1 '),
          Text(' Item 2 '),
          Text(' Item 3 '),
        ],
      ).separator(VerticalDivider()),
    );
  }
}
