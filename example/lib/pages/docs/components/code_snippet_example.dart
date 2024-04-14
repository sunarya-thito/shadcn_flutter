import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'code_snippet/code_snippet_example_1.dart';

class CodeSnippetExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'code_snippet',
      description: 'A code snippet is a small piece of reusable code.',
      displayName: 'Code Snippet',
      children: [
        WidgetUsageExample(
          child: CodeSnippetExample1(),
          path:
              'lib/pages/docs/components/code_snippet/code_snippet_example_1.dart',
        ),
      ],
    );
  }
}
