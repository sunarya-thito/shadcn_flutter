import 'package:shadcn_flutter/shadcn_flutter.dart';

class TextAreaExample1 extends StatelessWidget {
  const TextAreaExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      expandableHeight: true,
      initialHeight: 300,
    );
  }
}
