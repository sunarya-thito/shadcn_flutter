import 'package:shadcn_flutter/shadcn_flutter.dart';

class TextAreaExample3 extends StatelessWidget {
  const TextAreaExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      expandableWidth: true,
      expandableHeight: true,
      initialWidth: 500,
      initialHeight: 300,
    );
  }
}
