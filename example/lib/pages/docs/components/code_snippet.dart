import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CodeSnippetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'code_snippet',
      description: 'A code snippet is a small piece of reusable code.',
      displayName: 'Code Snippet',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return CodeSnippet(
              code: 'flutter pub get',
              mode: 'shell',
            );
          },
          code: '''
CodeSnippet(
  code: 'flutter pub get',
  mode: 'shell',
)''',
        ),
      ],
    );
  }
}
