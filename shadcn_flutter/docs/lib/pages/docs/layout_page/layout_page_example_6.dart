import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample6 extends StatelessWidget {
  const LayoutPageExample6({super.key});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(' Item 1 '),
          Text(' Item 2 '),
          Text(' Item 3 '),
        ],
      ).separator(const VerticalDivider()),
    );
  }
}
