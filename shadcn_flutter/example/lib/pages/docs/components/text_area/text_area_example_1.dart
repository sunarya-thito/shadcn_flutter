import 'package:shadcn_flutter/shadcn_flutter.dart';

class TextAreaExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextArea(
      initialValue: 'Hello, World!',
      expandableHeight: true,
      initialHeight: 300,
    );
  }
}
