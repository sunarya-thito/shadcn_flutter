import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'code_snippet/code_snippet_example_1.dart';

class CodeSnippetExample extends StatelessWidget {
  const CodeSnippetExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'code_snippet',
      description: 'A code snippet is a small piece of reusable code.',
      displayName: 'Code Snippet',
      children: [
        WidgetUsageExample(
          title: 'Code Snippet Example',
          path:
              'lib/pages/docs/components/code_snippet/code_snippet_example_1.dart',
          child: CodeSnippetExample1(),
        ),
      ],
    );
  }
}
