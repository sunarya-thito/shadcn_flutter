# CodeSnippetTheme

Theme configuration for [CodeSnippet] components.

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
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `backgroundColor` | `Color?` | Background color of the code snippet container.  Type: `Color?`. Used as the background color for the code display area. If null, uses the theme's default muted background color. |
| `borderColor` | `Color?` | Border color of the code snippet container.  Type: `Color?`. Color used for the container border outline. If null, uses the theme's default border color. |
| `borderWidth` | `double?` | Border width of the code snippet container in logical pixels.  Type: `double?`. Thickness of the border around the code container. If null, uses the theme's default border width. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius for the code snippet container corners.  Type: `BorderRadiusGeometry?`. Controls corner rounding of the container. If null, uses the theme's default radius for code components. |
| `padding` | `EdgeInsetsGeometry?` | Padding for the code content area.  Type: `EdgeInsetsGeometry?`. Internal spacing around the code text. If null, uses default padding appropriate for code display. |
