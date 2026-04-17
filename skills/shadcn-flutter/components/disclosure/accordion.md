# Accordion

A container widget that displays a list of collapsible items with only one item expanded at a time.

## Usage

### Accordion Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/accordion/accordion_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AccordionExample extends StatelessWidget {
  const AccordionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'accordion',
      description: 'An accordion is a vertically stacked list of items. '
          'Each item can be "expanded" or "collapsed" to reveal the content associated with that item.',
      displayName: 'Accordion',
      children: [
        WidgetUsageExample(
          title: 'Accordion Example',
          path: 'lib/pages/docs/components/accordion/accordion_example_1.dart',
          child: AccordionExample1(),
        )
      ],
    );
  }
}

```

### Accordion Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A minimal Accordion demo.
///
/// This example shows how to create a vertically stacked set of
/// expandable/collapsible items using [Accordion] and [AccordionItem].
///
/// Key points:
/// - [Accordion] manages the expansion state of its [items].
/// - Each [AccordionItem] defines a [trigger] (the clickable header)
///   and a [content] (the body shown when expanded).
/// - All text and layout here are simple to keep focus on the API usage.
class AccordionExample1 extends StatelessWidget {
  const AccordionExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // The Accordion itself simply receives a list of items.
    // Note: Using `const` here keeps the widget tree immutable since
    // the items are static in this example.
    return const Accordion(
      items: [
        // Item 1: Demonstrates a basic trigger and a longer content body.
        AccordionItem(
          trigger: AccordionTrigger(child: Text('Lorem ipsum dolor sit amet')),
          content: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        ),
        // Item 2: Another entry with its own header and body.
        AccordionItem(
          trigger: AccordionTrigger(
              child: Text(
                  'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua')),
          content: Text(
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        ),
        // Item 3: A third example to show multiple items expand independently.
        AccordionItem(
          trigger: AccordionTrigger(
              child: Text(
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat')),
          content: Text(
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        ),
      ],
    );
  }
}

```

### Accordion Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class AccordionTile extends StatelessWidget implements IComponentPage {
  const AccordionTile({super.key});

  @override
  String get title => 'Accordion';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'accordion',
      title: 'Accordion',
      example: SizedBox(
        width: 280,
        child: Card(
          child: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Accordion 1')),
                content: Text('Content 1'),
              ),
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Accordion 2')),
                content: Text('Content 2'),
              ),
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Accordion 3')),
                content: Text('Content 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```



## Features
- **Single Expansion**: Only one accordion item can be expanded at a time
- **Visual Separation**: Automatic dividers between accordion items
- **Smooth Animation**: Configurable expand/collapse animations
- **Accessibility**: Full keyboard navigation and screen reader support
- **Theming**: Comprehensive theming via [AccordionTheme]

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `items` | `List<Widget>` | The list of accordion items to display.  Each item should be an [AccordionItem] widget containing a trigger and content. The accordion automatically adds visual dividers between items and manages the expansion state to ensure only one item can be expanded at a time. |
