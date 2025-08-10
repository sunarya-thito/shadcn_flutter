import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/code_snippet/code_snippet_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CodeSnippetTile extends StatelessWidget implements IComponentPage {
  const CodeSnippetTile({super.key});

  @override
  String get title => 'Code Snippet';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'code_snippet',
      title: 'Code Snippet',
      scale: 1.5,
      reverse: true,
      reverseVertical: true,
      example: CodeSnippetExample1(),
    );
  }
}
