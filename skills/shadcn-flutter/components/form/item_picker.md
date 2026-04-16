# ItemPicker

A widget for selecting items from a collection using various presentation modes.

## Usage

### Item Picker Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_1.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_2.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_3.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_4.dart';
import 'package:docs/pages/docs/components/item_picker/item_picker_example_5.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ItemPickerExample extends StatelessWidget {
  const ItemPickerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'item_picker',
      description:
          'Item picker is a widget that allows you to pick an item from a list of items.',
      displayName: 'Item Picker',
      children: [
        WidgetUsageExample(
          title: 'Item Picker Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_1.dart',
          child: ItemPickerExample1(),
        ),
        WidgetUsageExample(
          title: 'Dialog Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_2.dart',
          child: ItemPickerExample2(),
        ),
        WidgetUsageExample(
          title: 'Fixed List Item Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_3.dart',
          child: ItemPickerExample3(),
        ),
        WidgetUsageExample(
          title: 'List Layout Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_4.dart',
          child: ItemPickerExample4(),
        ),
        WidgetUsageExample(
          title: 'Form Example',
          path:
              'lib/pages/docs/components/item_picker/item_picker_example_5.dart',
          child: ItemPickerExample5(),
        ),
      ],
    );
  }
}

```

### Item Picker Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ItemPickerExample1 extends StatelessWidget {
  const ItemPickerExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        // Show a popover item picker (non-dialog) with a virtual list of 1000 items.
        showItemPicker<int>(
          context,
          title: const Text('Pick an item'),
          items: ItemBuilder(
            itemCount: 1000,
            itemBuilder: (index) {
              return index;
            },
          ),
          builder: (context, item) {
            return ItemPickerOption(
                value: item, child: Text(item.toString()).large);
          },
        ).then(
          (value) {
            if (value != null && context.mounted) {
              // Feedback via toast when a selection is made.
              showToast(
                context: context,
                builder: (context, overlay) {
                  return SurfaceCard(
                    child: Text('You picked $value!'),
                  );
                },
              );
            } else if (context.mounted) {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return const SurfaceCard(
                    child: Text('You picked nothing!'),
                  );
                },
              );
            }
          },
        );
      },
      child: const Text('Show Item Picker'),
    );
  }
}

```

### Item Picker Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ItemPickerExample2 extends StatelessWidget {
  const ItemPickerExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        // Dialog variant of the item picker for a more prominent selection flow.
        showItemPickerDialog<int>(
          context,
          title: const Text('Pick a number'),
          items: ItemBuilder(
            itemBuilder: (index) {
              return index;
            },
          ),
          builder: (context, item) {
            return ItemPickerOption(
                value: item, child: Text(item.toString()).large);
          },
        ).then(
          (value) {
            if (value != null && context.mounted) {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return SurfaceCard(
                    child: Text('You picked $value!'),
                  );
                },
              );
            } else if (context.mounted) {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return const SurfaceCard(
                    child: Text('You picked nothing!'),
                  );
                },
              );
            }
          },
        );
      },
      child: const Text('Show Item Picker'),
    );
  }
}

```

### Item Picker Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class ItemPickerExample3 extends StatefulWidget {
  const ItemPickerExample3({super.key});

  @override
  State<ItemPickerExample3> createState() => _ItemPickerExample3State();
}

class _ItemPickerExample3State extends State<ItemPickerExample3> {
  final List<NamedColor> colors = const [
    NamedColor('Red', Colors.red),
    NamedColor('Green', Colors.green),
    NamedColor('Blue', Colors.blue),
    NamedColor('Yellow', Colors.yellow),
    NamedColor('Purple', Colors.purple),
    NamedColor('Cyan', Colors.cyan),
    NamedColor('Orange', Colors.orange),
    NamedColor('Pink', Colors.pink),
    NamedColor('Teal', Colors.teal),
    NamedColor('Amber', Colors.amber),
  ];
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        showItemPickerDialog<NamedColor>(
          context,
          items: ItemList(colors),
          initialValue: colors[selectedColor],
          title: const Text('Pick a color'),
          builder: (context, item) {
            return ItemPickerOption(
              value: item,
              selectedStyle: const ButtonStyle.primary(
                shape: ButtonShape.circle,
              ),
              style: const ButtonStyle.ghost(
                shape: ButtonShape.circle,
              ),
              label: Text(item.name),
              child: Container(
                padding: const EdgeInsets.all(8),
                width: 100,
                height: 100,
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(color: item.color, shape: BoxShape.circle),
              ),
            );
          },
        ).then(
          (value) {
            if (value != null) {
              selectedColor = colors.indexOf(value);
              if (context.mounted) {
                showToast(
                  context: context,
                  builder: (context, overlay) {
                    return SurfaceCard(
                      child: Text('You picked ${value.name}!'),
                    );
                  },
                );
              }
            } else if (context.mounted) {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return const SurfaceCard(
                    child: Text('You picked nothing!'),
                  );
                },
              );
            }
          },
        );
      },
      child: const Text('Show Item Picker'),
    );
  }
}

```

### Item Picker Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class ItemPickerExample4 extends StatefulWidget {
  const ItemPickerExample4({super.key});

  @override
  State<ItemPickerExample4> createState() => _ItemPickerExample4State();
}

class _ItemPickerExample4State extends State<ItemPickerExample4> {
  final List<NamedColor> colors = const [
    NamedColor('Red', Colors.red),
    NamedColor('Green', Colors.green),
    NamedColor('Blue', Colors.blue),
    NamedColor('Yellow', Colors.yellow),
    NamedColor('Purple', Colors.purple),
    NamedColor('Cyan', Colors.cyan),
    NamedColor('Orange', Colors.orange),
    NamedColor('Pink', Colors.pink),
    NamedColor('Teal', Colors.teal),
    NamedColor('Amber', Colors.amber),
  ];
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        showItemPickerDialog<NamedColor>(
          context,
          items: ItemList(colors),
          initialValue: colors[selectedColor],
          // Force a list layout instead of a grid for narrower rows.
          layout: ItemPickerLayout.list,
          title: const Text('Pick a color'),
          builder: (context, item) {
            return ItemPickerOption(
                value: item,
                label: Text(item.name),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                  ),
                ));
          },
        ).then(
          (value) {
            if (value != null) {
              selectedColor = colors.indexOf(value);
              if (context.mounted) {
                showToast(
                  context: context,
                  builder: (context, overlay) {
                    return SurfaceCard(
                      child: Text('You picked ${value.name}!'),
                    );
                  },
                );
              }
            } else if (context.mounted) {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return const SurfaceCard(
                    child: Text('You picked nothing!'),
                  );
                },
              );
            }
          },
        );
      },
      child: const Text('Show Item Picker'),
    );
  }
}

```

### Item Picker Example 5
```dart
import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NamedColor {
  final String name;
  final Color color;

  const NamedColor(this.name, this.color);
}

class ItemPickerExample5 extends StatefulWidget {
  const ItemPickerExample5({super.key});

  @override
  State<ItemPickerExample5> createState() => _ItemPickerExample5State();
}

class _ItemPickerExample5State extends State<ItemPickerExample5> {
  final List<NamedColor> colors = const [
    NamedColor('Red', Colors.red),
    NamedColor('Green', Colors.green),
    NamedColor('Blue', Colors.blue),
    NamedColor('Yellow', Colors.yellow),
    NamedColor('Purple', Colors.purple),
    NamedColor('Cyan', Colors.cyan),
    NamedColor('Orange', Colors.orange),
    NamedColor('Pink', Colors.pink),
    NamedColor('Teal', Colors.teal),
    NamedColor('Amber', Colors.amber),
  ];
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return ItemPicker<NamedColor>(
      items: ItemList(colors),
      mode: PromptMode.popover,
      title: const Text('Pick a color'),
      builder: (context, item) {
        return ItemPickerOption(
          value: item,
          label: Text(item.name),
          style: const ButtonStyle.ghostIcon(
            shape: ButtonShape.circle,
          ),
          selectedStyle: const ButtonStyle.primary(
            shape: ButtonShape.circle,
          ),
          child: Container(
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            decoration: BoxDecoration(
              color: item.color,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
      value: colors[selectedColor],
      placeholder: const Text('Pick a color'),
      onChanged: (value) {
        if (kDebugMode) {
          print('You picked $value!');
        }
        if (value != null) {
          setState(() {
            selectedColor = colors.indexOf(value);
          });
        }
      },
    );
  }
}

```

### Item Picker Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ItemPickerTile extends StatelessWidget implements IComponentPage {
  const ItemPickerTile({super.key});

  @override
  String get title => 'Item Picker';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'item_picker',
      title: 'Item Picker',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const Text('Select an item:').bold(),
            const Gap(16),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                Chip(
                  child: const Text('Option 1'),
                  onPressed: () {},
                ),
                Chip(
                  child: const Text('Option 2'),
                  onPressed: () {},
                ),
                Chip(
                  child: const Text('Option 3'),
                  onPressed: () {},
                ),
              ],
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
| `items` | `ItemChildDelegate<T>` | Delegate providing the collection of items to display for selection.  This delegate abstracts the item source, supporting both static lists through [ItemList] and dynamic generation through [ItemBuilder]. |
| `builder` | `ItemPickerBuilder<T>` | Builder function that creates the visual representation of each item.  Called for each item to create its visual representation in the picker. The builder receives the item value and selection state, allowing customized appearance based on the current selection. |
| `value` | `T?` | The currently selected item, if any.  When null, no item is selected. The picker highlights this item visually to indicate the current selection state. |
| `onChanged` | `ValueChanged<T?>?` | Callback invoked when the user selects a different item.  Called when the user taps on an item in the picker. The callback receives the selected item, or null if the selection is cleared. |
| `layout` | `ItemPickerLayout?` | Layout style for arranging items in the picker interface.  Determines how items are arranged within the picker container, such as grid or list layout. Defaults to grid layout. |
| `placeholder` | `Widget?` | Widget displayed when no item is currently selected.  Shown in the picker trigger button when [value] is null. Provides visual feedback that no selection has been made yet. |
| `title` | `Widget?` | Optional title widget for the picker interface.  Displayed at the top of the picker when shown in dialog mode, providing context about what the user is selecting. |
| `mode` | `PromptMode?` | Presentation mode for the item picker interface.  Controls whether the picker appears as a modal dialog or a popover dropdown. Defaults to dialog mode for better item visibility. |
| `constraints` | `BoxConstraints?` | Size constraints for the picker interface container.  Controls the dimensions of the picker when displayed, allowing customization of the available space for item display. |
