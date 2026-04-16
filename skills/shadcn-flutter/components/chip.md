# ChipTheme

Theme for [Chip].

## Usage

### Chip Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/chip/chip_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipExample extends StatelessWidget {
  const ChipExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'chip',
      description:
          'A chip is a small, interactive element that represents an attribute, text, entity, or action.',
      displayName: 'Chip',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/chip/chip_example_1.dart',
          child: ChipExample1(),
        ),
      ],
    );
  }
}

```

### Chip Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Chips with trailing remove buttons in different styles.
///
/// Demonstrates how to compose [Chip] with a [ChipButton] trailing action,
/// and how to apply various [ButtonStyle] presets.
class ChipExample1 extends StatelessWidget {
  const ChipExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        Chip(
          // Trailing action; in real apps you might remove the chip.
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Apple'),
        ),
        Chip(
          // Primary-styled chip.
          style: const ButtonStyle.primary(),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Banana'),
        ),
        Chip(
          // Outlined chip.
          style: const ButtonStyle.outline(),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Cherry'),
        ),
        Chip(
          // Ghost chip (very subtle background).
          style: const ButtonStyle.ghost(),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Durian'),
        ),
        Chip(
          // Destructive-styled chip for warning/critical labels.
          style: const ButtonStyle.destructive(),
          trailing: ChipButton(
            onPressed: () {},
            child: const Icon(Icons.close),
          ),
          child: const Text('Elderberry'),
        ),
      ],
    );
  }
}

```

### Chip Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ChipTile extends StatelessWidget implements IComponentPage {
  const ChipTile({super.key});

  @override
  String get title => 'Chip';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'chip',
      title: 'Chip',
      scale: 1.5,
      example: Card(
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            Chip(
              child: const Text('Default'),
              onPressed: () {},
            ),
            Chip(
              leading: const Icon(LucideIcons.user),
              child: const Text('With Icon'),
              onPressed: () {},
            ),
            Chip(
              trailing: const Icon(LucideIcons.x),
              onPressed: () {},
              child: const Text('Removable'),
            ),
            const Chip(
              child: Text('Disabled'),
            ),
          ],
        ).withPadding(all: 16),
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
| `padding` | `EdgeInsetsGeometry?` | The padding inside the chip. |
| `style` | `AbstractButtonStyle?` | The default [Button] style of the chip. |
