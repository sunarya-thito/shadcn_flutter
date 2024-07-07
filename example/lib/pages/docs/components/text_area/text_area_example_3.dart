import 'package:shadcn_flutter/shadcn_flutter.dart';

class TextAreaExample3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextArea(
      initialValue: 'Hello, World!',
      expandableWidth: true,
      expandableHeight: true,
      initialWidth: 500,
      initialHeight: 300,
    );
  }
}
