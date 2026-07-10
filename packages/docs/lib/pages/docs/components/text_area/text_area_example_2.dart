import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a TextArea that can expand horizontally as space permits.

class TextAreaExample2 extends StatelessWidget {
  const TextAreaExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      // Allow the field to expand horizontally if space permits.
      expandableWidth: true,
      // Start wider to demonstrate horizontal growth.
      initialWidth: 500,
    );
  }
}
