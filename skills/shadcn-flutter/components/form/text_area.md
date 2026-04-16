# TextArea

A multi-line text input widget with resizable dimensions and comprehensive styling.

## Usage

### Text Area Example
```dart
import 'package:docs/pages/docs/components/text_area/text_area_example_1.dart';
import 'package:docs/pages/docs/components/text_area/text_area_example_2.dart';
import 'package:docs/pages/docs/components/text_area/text_area_example_3.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class TextAreaExample extends StatelessWidget {
  const TextAreaExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'text_area',
      description:
          'TextArea is a component that allows users to enter multiple lines of text.',
      displayName: 'TextArea',
      children: [
        WidgetUsageExample(
          title: 'Resizable Height Example',
          path: 'lib/pages/docs/components/text_area/text_area_example_1.dart',
          child: TextAreaExample1(),
        ),
        WidgetUsageExample(
          title: 'Resizable Width Example',
          path: 'lib/pages/docs/components/text_area/text_area_example_2.dart',
          child: TextAreaExample2(),
        ),
        WidgetUsageExample(
          title: 'Resizable Width and Height Example',
          path: 'lib/pages/docs/components/text_area/text_area_example_3.dart',
          child: TextAreaExample3(),
        ),
      ],
    );
  }
}

```

### Text Area Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a TextArea that expands vertically with its content.

class TextAreaExample1 extends StatelessWidget {
  const TextAreaExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      // Let the text area grow vertically with content up to constraints.
      expandableHeight: true,
      // Start with a taller initial height to show multiple lines.
      initialHeight: 300,
    );
  }
}

```

### Text Area Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a TextArea that can expand horizontally as space permits.

class TextAreaExample2 extends StatelessWidget {
  const TextAreaExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      // Allow the field to expand horizontally if space permits.
      expandableWidth: true,
      // Start wider to demonstrate horizontal growth.
      initialWidth: 500,
    );
  }
}

```

### Text Area Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a TextArea that expands both horizontally and vertically.

class TextAreaExample3 extends StatelessWidget {
  const TextAreaExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextArea(
      initialValue: 'Hello, World!',
      // Enable both horizontal and vertical growth based on content.
      expandableWidth: true,
      expandableHeight: true,
      // Larger starting dimensions to make the behavior obvious.
      initialWidth: 500,
      initialHeight: 300,
    );
  }
}

```

### Text Area Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../text_area/text_area_example_3.dart';

class TextAreaTile extends StatelessWidget implements IComponentPage {
  const TextAreaTile({super.key});

  @override
  String get title => 'Text Area';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      title: 'Text Area',
      name: 'text_area',
      scale: 1.2,
      example: Column(
        children: [
          Card(child: TextAreaExample3()),
          Card(child: TextAreaExample3()),
        ],
      ),
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
| `expandableHeight` | `bool` | Whether the text area can be resized vertically by the user.  When true, displays a resize handle that allows users to adjust the height of the text area within the specified min/max constraints. |
| `expandableWidth` | `bool` | Whether the text area can be resized horizontally by the user.  When true, displays a resize handle that allows users to adjust the width of the text area within the specified min/max constraints. |
| `initialHeight` | `double` | Initial height of the text area in logical pixels.  Sets the starting height when the text area is first displayed. If [expandableHeight] is true, users can resize from this initial value. |
| `initialWidth` | `double` | Initial width of the text area in logical pixels.  Sets the starting width when the text area is first displayed. If [expandableWidth] is true, users can resize from this initial value. |
| `onHeightChanged` | `ValueChanged<double>?` | Callback invoked when the text area height changes.  Called when the user resizes the text area vertically. The callback receives the new height value in logical pixels. |
| `onWidthChanged` | `ValueChanged<double>?` | Callback invoked when the text area width changes.  Called when the user resizes the text area horizontally. The callback receives the new width value in logical pixels. |
| `minWidth` | `double` | Minimum allowed width in logical pixels.  Prevents the text area from being resized below this width value. Only applies when [expandableWidth] is true. |
| `minHeight` | `double` | Minimum allowed height in logical pixels.  Prevents the text area from being resized below this height value. Only applies when [expandableHeight] is true. |
| `maxWidth` | `double` | Maximum allowed width in logical pixels.  Prevents the text area from being resized above this width value. Only applies when [expandableWidth] is true. |
| `maxHeight` | `double` | Maximum allowed height in logical pixels.  Prevents the text area from being resized above this height value. Only applies when [expandableHeight] is true. |
