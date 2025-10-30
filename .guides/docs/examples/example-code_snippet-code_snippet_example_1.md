---
title: "Example: components/code_snippet/code_snippet_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// CodeSnippet for showing read-only command or code blocks.
///
/// `mode` controls syntax highlighting; here we show a shell command.
class CodeSnippetExample1 extends StatelessWidget {
  const CodeSnippetExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const CodeSnippet(
      code: Text('flutter pub get'),
    );
  }
}

```
