import 'package:shadcn_flutter/shadcn_flutter.dart';

class CodeSnippetExample1 extends StatelessWidget {
  const CodeSnippetExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const CodeSnippet(
      code: 'flutter pub get',
      mode: 'shell',
    );
  }
}
