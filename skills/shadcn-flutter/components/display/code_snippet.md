# CodeSnippet

A syntax-highlighted code display widget with copy functionality.

## Usage

### Code Snippet Example
```dart
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

```

### Code Snippet Example 1
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

### Code Snippet Tile
```dart
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

```



## Features
- **Syntax Highlighting**: Automatic language detection and coloring
- **Copy to Clipboard**: Built-in copy button with toast confirmation
- **Custom Actions**: Support for additional action buttons
- **Responsive Design**: Horizontal and vertical scrolling for long code
- **Theme Integration**: Automatic light/dark theme adaptation
- **Loading States**: Smooth loading indicators during initialization

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `constraints` | `BoxConstraints?` | Optional constraints for the code display area.  Type: `BoxConstraints?`. Controls the maximum/minimum size of the scrollable code container. Useful for limiting height in layouts. |
| `code` | `Widget` | The code widget to display (typically Text or RichText with syntax highlighting). |
| `actions` | `List<Widget>` | Additional action widgets displayed in the top-right corner.  Type: `List<Widget>`. Custom action buttons shown alongside the default copy button. Useful for share, edit, or other operations. |
