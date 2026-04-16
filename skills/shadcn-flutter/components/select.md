# SelectTheme

Theme data for customizing [Select] widget appearance and behavior.

## Usage

### Select Example
```dart
import 'package:docs/pages/docs/components/select/select_example_1.dart';
import 'package:docs/pages/docs/components/select/select_example_2.dart';
import 'package:docs/pages/docs/components/select/select_example_3.dart';
import 'package:docs/pages/docs/components/select/select_example_4.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SelectExample extends StatelessWidget {
  const SelectExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'select',
      description:
          'A select component that allows you to select an item from a list of items.',
      displayName: 'Select',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/select/select_example_1.dart',
          child: SelectExample1(),
        ),
        WidgetUsageExample(
          title: 'Example with search',
          path: 'lib/pages/docs/components/select/select_example_2.dart',
          child: SelectExample2(),
        ),
        WidgetUsageExample(
          title: 'Asynchronous infinite example',
          path: 'lib/pages/docs/components/select/select_example_3.dart',
          child: SelectExample3(),
        ),
        WidgetUsageExample(
          title: 'Example with no virtualization',
          path: 'lib/pages/docs/components/select/select_example_4.dart',
          child: SelectExample4(),
        ),
      ],
    );
  }
}

```

### Select Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample1 extends StatefulWidget {
  const SelectExample1({super.key});

  @override
  State<SelectExample1> createState() => _SelectExample1State();
}

class _SelectExample1State extends State<SelectExample1> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Select<String>(
      // How to render each selected item as text in the field.
      itemBuilder: (context, item) {
        return Text(item);
      },
      // Limit the popup size so it doesn't grow too large in the docs view.
      popupConstraints: const BoxConstraints(
        maxHeight: 300,
        maxWidth: 200,
      ),
      onChanged: (value) {
        setState(() {
          // Save the currently selected value (or null to clear).
          selectedValue = value;
        });
      },
      // The current selection bound to this field.
      value: selectedValue,
      placeholder: const Text('Select a fruit'),
      popup: const SelectPopup(
        items: SelectItemList(
          children: [
            // A simple static list of options.
            SelectItemButton(
              value: 'Apple',
              child: Text('Apple'),
            ),
            SelectItemButton(
              value: 'Banana',
              child: Text('Banana'),
            ),
            SelectItemButton(
              value: 'Cherry',
              child: Text('Cherry'),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Select Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample2 extends StatefulWidget {
  const SelectExample2({super.key});

  @override
  State<SelectExample2> createState() => _SelectExample2State();
}

class _SelectExample2State extends State<SelectExample2> {
  final Map<String, List<String>> fruits = {
    'Apple': ['Red Apple', 'Green Apple'],
    'Banana': ['Yellow Banana', 'Brown Banana'],
    'Lemon': ['Yellow Lemon', 'Green Lemon'],
    'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],
  };
  String? selectedValue;

  Iterable<MapEntry<String, List<String>>> _filteredFruits(
      String searchQuery) sync* {
    // Yield entries whose key or children match the current search query.
    for (final entry in fruits.entries) {
      final filteredValues = entry.value
          .where((value) => _filterName(value, searchQuery))
          .toList();
      if (filteredValues.isNotEmpty) {
        yield MapEntry(entry.key, filteredValues);
      } else if (_filterName(entry.key, searchQuery)) {
        yield entry;
      }
    }
  }

  bool _filterName(String name, String searchQuery) {
    // Case-insensitive substring filter.
    return name.toLowerCase().contains(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Select<String>(
      itemBuilder: (context, item) {
        return Text(item);
      },
      popup: SelectPopup.builder(
        // Provide a search field inside the popup.
        searchPlaceholder: const Text('Search fruit'),
        builder: (context, searchQuery) {
          // Filter entries by the user's search.
          final filteredFruits = searchQuery == null
              ? fruits.entries
              : _filteredFruits(searchQuery);
          return SelectItemList(
            children: [
              for (final entry in filteredFruits)
                SelectGroup(
                  // Group by category (e.g., Apple, Banana) with a header label.
                  headers: [
                    SelectLabel(
                      child: Text(entry.key),
                    ),
                  ],
                  children: [
                    for (final value in entry.value)
                      SelectItemButton(
                        value: value,
                        child: Text(value),
                      ),
                  ],
                ),
            ],
          );
        },
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      constraints: const BoxConstraints(
        minWidth: 200,
      ),
      value: selectedValue,
      placeholder: const Text('Select a fruit'),
    );
  }
}

```

### Select Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample3 extends StatefulWidget {
  const SelectExample3({super.key});

  @override
  State<SelectExample3> createState() => _SelectExample3State();
}

class _SelectExample3State extends State<SelectExample3> {
  final Map<String, List<String>> fruits = {
    'Apple': ['Red Apple', 'Green Apple'],
    'Banana': ['Yellow Banana', 'Brown Banana'],
    'Lemon': ['Yellow Lemon', 'Green Lemon'],
    'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],
  };
  String? selectedValue;

  Iterable<MapEntry<String, List<String>>> _filteredFruits(
      String searchQuery) sync* {
    for (final entry in fruits.entries) {
      final filteredValues = entry.value
          .where((value) => _filterName(value, searchQuery))
          .toList();
      if (filteredValues.isNotEmpty) {
        yield MapEntry(entry.key, filteredValues);
      } else if (_filterName(entry.key, searchQuery)) {
        yield entry;
      }
    }
  }

  bool _filterName(String name, String searchQuery) {
    return name.toLowerCase().contains(searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Select<String>(
      itemBuilder: (context, item) {
        return Text(item);
      },
      popup: SelectPopup.builder(
        // Popup with async data loading and custom empty/loading UI.
        searchPlaceholder: const Text('Search fruit'),
        emptyBuilder: (context) {
          return const Center(
            child: Text('No fruit found'),
          );
        },
        loadingBuilder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        builder: (context, searchQuery) async {
          final filteredFruits = searchQuery == null
              ? fruits.entries.toList()
              : _filteredFruits(searchQuery).toList();
          // Simulate a delay for loading
          // In a real-world scenario, you would fetch data from an API or database
          await Future.delayed(const Duration(milliseconds: 500));
          return SelectItemBuilder(
            // When 0, the popup renders the emptyBuilder; otherwise the builder lazily builds rows.
            childCount: filteredFruits.isEmpty ? 0 : null,
            builder: (context, index) {
              final entry = filteredFruits[index % filteredFruits.length];
              return SelectGroup(
                headers: [
                  SelectLabel(
                    child: Text(entry.key),
                  ),
                ],
                children: [
                  for (final value in entry.value)
                    SelectItemButton(
                      value: value,
                      child: Text(value),
                    ),
                ],
              );
            },
          );
        },
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      constraints: const BoxConstraints(
        minWidth: 200,
      ),
      value: selectedValue,
      placeholder: const Text('Select a fruit'),
    );
  }
}

```

### Select Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SelectExample4 extends StatefulWidget {
  const SelectExample4({super.key});

  @override
  State<SelectExample4> createState() => _SelectExample4State();
}

class _SelectExample4State extends State<SelectExample4> {
  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Select<String>(
      itemBuilder: (context, item) {
        return Text(item);
      },
      popupConstraints: const BoxConstraints(
        maxHeight: 300,
        maxWidth: 200,
      ),
      onChanged: (value) {
        setState(() {
          selectedValue = value;
        });
      },
      value: selectedValue,
      placeholder: const Text('Select a fruit'),
      // Constrain popup width to its intrinsic content size (no virtualization in this variant).
      popupWidthConstraint: PopoverConstraint.intrinsic,
      // Use a simple non-virtualized popup; suitable for small lists.
      popup: const SelectPopup.noVirtualization(
        items: SelectItemList(
          children: [
            SelectItemButton(
              value: 'Apple',
              child: Text('Apple'),
            ),
            SelectItemButton(
              value: 'Banana',
              child: Text('Banana'),
            ),
            SelectItemButton(
              value: 'Cherry',
              child: Text('Cherry'),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Select Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class SelectTile extends StatelessWidget implements IComponentPage {
  const SelectTile({super.key});

  @override
  String get title => 'Select';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'select',
      title: 'Select',
      scale: 1.2,
      example: Card(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Select<String>(
                itemBuilder: (context, item) {
                  return Text(item);
                },
                placeholder: const Text('Select a fruit'),
                value: 'Apple',
                enabled: true,
                constraints: const BoxConstraints.tightFor(width: 300),
                popup: const SelectPopup(),
              ),
              Gap(8 * theme.scaling),
              const SizedBox(
                width: 300,
                child: SelectPopup(
                  items: SelectItemList(children: [
                    SelectItemButton(
                      value: 'Apple',
                      child: Text('Apple'),
                    ),
                    SelectItemButton(
                      value: 'Banana',
                      child: Text('Banana'),
                    ),
                    SelectItemButton(
                      value: 'Lemon',
                      child: Text('Lemon'),
                    ),
                    SelectItemButton(
                      value: 'Tomato',
                      child: Text('Tomato'),
                    ),
                    SelectItemButton(
                      value: 'Cucumber',
                      child: Text('Cucumber'),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ).sized(height: 300, width: 200),
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
| `popupConstraints` | `BoxConstraints?` | Constraints for the popup menu size. |
| `popoverAlignment` | `AlignmentGeometry?` | Alignment of the popover relative to the anchor. |
| `popoverAnchorAlignment` | `AlignmentGeometry?` | Anchor alignment for the popover. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius for select items. |
| `padding` | `EdgeInsetsGeometry?` | Padding inside select items. |
| `disableHoverEffect` | `bool?` | Whether to disable hover effects on items. |
| `canUnselect` | `bool?` | Whether the selected item can be unselected. |
| `autoClosePopover` | `bool?` | Whether to automatically close the popover after selection. |
