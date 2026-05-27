# NavigationCollapsible

A navigation item that can expand to reveal nested navigation items.

## Usage

### Collapsible Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'collapsible/collapsible_example_1.dart';

class CollapsibleExample extends StatelessWidget {
  const CollapsibleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'collapsible',
      description: 'A widget that can be expanded or collapsed.',
      displayName: 'Collapsible',
      children: [
        WidgetUsageExample(
          title: 'Collapsible Example',
          path:
              'lib/pages/docs/components/collapsible/collapsible_example_1.dart',
          child: CollapsibleExample1(),
        ),
      ],
    );
  }
}

```

### Collapsible Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Collapsible list with a trigger and multiple content sections.
///
/// The first item is a [CollapsibleTrigger] that toggles visibility of
/// subsequent [CollapsibleContent] sections.
class CollapsibleExample1 extends StatelessWidget {
  const CollapsibleExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Collapsible(
      children: [
        const CollapsibleTrigger(
          child: Text('@sunarya-thito starred 3 repositories'),
        ),
        OutlinedContainer(
          child: const Text('@sunarya-thito/shadcn_flutter')
              .small()
              .mono()
              .withPadding(horizontal: 16, vertical: 8),
        ).withPadding(top: 8),
        CollapsibleContent(
          child: OutlinedContainer(
            child: const Text('@flutter/flutter')
                .small()
                .mono()
                .withPadding(horizontal: 16, vertical: 8),
          ).withPadding(top: 8),
        ),
        CollapsibleContent(
          child: OutlinedContainer(
            child: const Text('@dart-lang/sdk')
                .small()
                .mono()
                .withPadding(horizontal: 16, vertical: 8),
          ).withPadding(top: 8),
        ),
      ],
    );
  }
}

```

### Collapsible Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class CollapsibleTile extends StatelessWidget implements IComponentPage {
  const CollapsibleTile({super.key});

  @override
  String get title => 'Collapsible';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'collapsible',
      title: 'Collapsible',
      reverse: true,
      example: Card(
        child: Collapsible(
          children: [
            const CollapsibleTrigger(
              child: Text('@sunarya-thito starred 3 repositories'),
            ),
            OutlinedContainer(
              child: const Text('@sunarya-thito/shadcn_flutter')
                  .small()
                  .mono()
                  .withPadding(horizontal: 16, vertical: 8),
            ).withPadding(top: 8),
            CollapsibleContent(
              child: OutlinedContainer(
                child: const Text('@flutter/flutter')
                    .small()
                    .mono()
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            CollapsibleContent(
              child: OutlinedContainer(
                child: const Text('@dart-lang/sdk')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            const CollapsibleTrigger(
              child: Text('@flutter starred 1 repository'),
            ).withPadding(top: 16),
            OutlinedContainer(
              child: const Text('@sunarya-thito/shadcn_flutter')
                  .small()
                  .mono()
                  .withPadding(horizontal: 16, vertical: 8),
            ).withPadding(top: 8),
            CollapsibleContent(
              child: OutlinedContainer(
                child: const Text('@flutter/flutter')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
            CollapsibleContent(
              child: OutlinedContainer(
                child: const Text('@dart-lang/sdk')
                    .withPadding(horizontal: 16, vertical: 8),
              ).withPadding(top: 8),
            ),
          ],
        ),
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
| `leading` | `Widget?` | Optional leading widget for the group header. |
| `label` | `Widget` | Label widget for the group header. |
| `children` | `List<Widget>` | The nested navigation items for this group. |
| `expanded` | `bool?` | Whether the group is expanded (controlled mode). |
| `initialExpanded` | `bool` | Initial expanded state when uncontrolled. |
| `onExpandedChanged` | `ValueChanged<bool>?` | Callback when expansion state changes. |
| `selectedStyle` | `AbstractButtonStyle?` | Custom style when the group header is selected. |
| `selected` | `bool?` | Whether the group header is currently selected. |
| `onChanged` | `ValueChanged<bool>?` | Callback when header selection changes. |
| `style` | `AbstractButtonStyle?` | Optional button style for the header. |
| `trailing` | `Widget?` | Optional custom trailing widget for the expand indicator. |
| `childIndent` | `double?` | Indentation applied to nested items. |
| `branchLine` | `BranchLine?` | Branch line style for connecting group items. |
| `spacing` | `double?` | Spacing between leading widget and label. |
| `alignment` | `AlignmentGeometry?` | Content alignment within the header button. |
| `enabled` | `bool?` | Whether the header is enabled for interaction. |
| `overflow` | `NavigationOverflow` | How to handle label overflow. |
