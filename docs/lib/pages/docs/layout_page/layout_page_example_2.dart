import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample2 extends StatelessWidget {
  const LayoutPageExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Container(
        color: Colors.green,
        child: Container(
          color: Colors.blue,
          height: 20,
        ).withMargin(all: 16),
      ).withMargin(top: 24, bottom: 12, horizontal: 16),
    );
  }
}
