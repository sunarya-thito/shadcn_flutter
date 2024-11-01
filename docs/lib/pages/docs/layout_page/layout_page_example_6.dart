import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample6 extends StatefulWidget {
  const LayoutPageExample6({super.key});

  @override
  State<LayoutPageExample6> createState() => _LayoutPageExample6State();
}

class _LayoutPageExample6State extends State<LayoutPageExample6> {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(' Item 1 '),
          Text(' Item 2 '),
          Text(' Item 3 '),
        ],
      ).separator(const VerticalDivider()),
    );
  }
}
