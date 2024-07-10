import 'package:shadcn_flutter/shadcn_flutter.dart';

class TextAreaExample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextArea(
      initialValue: 'Hello, World!',
      expandableWidth: true,
      initialWidth: 500,
    );
  }
}
