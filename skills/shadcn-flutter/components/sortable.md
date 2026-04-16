# Sortable

A draggable widget that supports drag-and-drop reordering with directional drop zones.

## Usage

### Sortable Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_1.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_2.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_3.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_4.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_5.dart';
import 'package:docs/pages/docs/components/sortable/sortable_example_6.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';

class SortableExample extends StatelessWidget {
  const SortableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'sortable',
      description: 'A sortable is a way of displaying a list of items in '
          'a way that allows the user to change the order of the items.',
      displayName: 'Sortable',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_1.dart',
          child: SortableExample1(),
        ),
        WidgetUsageExample(
          title: 'Locked Axis Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_2.dart',
          child: SortableExample2(),
        ),
        WidgetUsageExample(
          title: 'Horizontal Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_3.dart',
          child: SortableExample3(),
        ),
        WidgetUsageExample(
          title: 'ListView Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_4.dart',
          child: SortableExample4(),
        ),
        WidgetUsageExample(
          title: 'Drag Handle Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_5.dart',
          child: SortableExample5(),
        ),
        WidgetUsageExample(
          title: 'Remove Item Example',
          path: 'lib/pages/docs/components/sortable/sortable_example_6.dart',
          child: SortableExample6(),
        ),
      ],
    );
  }
}

```

### Sortable Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample1 extends StatefulWidget {
  const SortableExample1({super.key});

  @override
  State<SortableExample1> createState() => _SortableExample1State();
}

class _SortableExample1State extends State<SortableExample1> {
  // Two separate lists for demonstrating cross-list drag-and-drop.
  List<SortableData<String>> invited = [
    const SortableData('James'),
    const SortableData('John'),
    const SortableData('Robert'),
    const SortableData('Michael'),
    const SortableData('William'),
  ];
  List<SortableData<String>> reserved = [
    const SortableData('David'),
    const SortableData('Richard'),
    const SortableData('Joseph'),
    const SortableData('Thomas'),
    const SortableData('Charles'),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: SortableLayer(
        // The SortableLayer coordinates drag-over/accept behavior for nested Sortable zones.
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Card(
                child: SortableDropFallback<String>(
                  // If dropped into empty space in this list, append to the end.
                  onAccept: (value) {
                    setState(() {
                      swapItemInLists(
                          [invited, reserved], value, invited, invited.length);
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < invited.length; i++)
                        Sortable<String>(
                          data: invited[i],
                          // Insert above the current index when dropped at the top edge.
                          onAcceptTop: (value) {
                            setState(() {
                              swapItemInLists(
                                  [invited, reserved], value, invited, i);
                            });
                          },
                          // Insert below the current index when dropped at the bottom edge.
                          onAcceptBottom: (value) {
                            setState(() {
                              swapItemInLists(
                                  [invited, reserved], value, invited, i + 1);
                            });
                          },
                          child: OutlinedContainer(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(invited[i].data)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
            gap(12),
            Expanded(
              child: Card(
                child: SortableDropFallback<String>(
                  // Same behavior for the second list.
                  onAccept: (value) {
                    setState(() {
                      swapItemInLists([invited, reserved], value, reserved,
                          reserved.length);
                    });
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (int i = 0; i < reserved.length; i++)
                        Sortable<String>(
                          data: reserved[i],
                          onAcceptTop: (value) {
                            setState(() {
                              swapItemInLists(
                                  [invited, reserved], value, reserved, i);
                            });
                          },
                          onAcceptBottom: (value) {
                            setState(() {
                              swapItemInLists(
                                  [invited, reserved], value, reserved, i + 1);
                            });
                          },
                          child: OutlinedContainer(
                            padding: const EdgeInsets.all(12),
                            child: Center(child: Text(reserved[i].data)),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

```

### Sortable Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample2 extends StatefulWidget {
  const SortableExample2({super.key});

  @override
  State<SortableExample2> createState() => _SortableExample2State();
}

class _SortableExample2State extends State<SortableExample2> {
  List<SortableData<String>> names = [
    const SortableData('James'),
    const SortableData('John'),
    const SortableData('Robert'),
    const SortableData('Michael'),
    const SortableData('William'),
  ];

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      // With lock enabled, the drag overlay is constrained within the layer.
      lock: true,
      child: SortableDropFallback<int>(
        // Dropping outside specific edge targets appends the item to the end.
        onAccept: (value) {
          setState(() {
            names.add(names.removeAt(value.data));
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < names.length; i++)
              Sortable<String>(
                // Use a stable key for better drag/reorder behavior.
                key: ValueKey(i),
                data: names[i],
                // Swap into the target index when dropped on the top edge.
                onAcceptTop: (value) {
                  setState(() {
                    names.swapItem(value, i);
                  });
                },
                // Insert after the target when dropped on the bottom edge.
                onAcceptBottom: (value) {
                  setState(() {
                    names.swapItem(value, i + 1);
                  });
                },
                child: OutlinedContainer(
                  padding: const EdgeInsets.all(12),
                  child: Center(child: Text(names[i].data)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

```

### Sortable Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample3 extends StatefulWidget {
  const SortableExample3({super.key});

  @override
  State<SortableExample3> createState() => _SortableExample3State();
}

class _SortableExample3State extends State<SortableExample3> {
  List<SortableData<String>> names = [
    const SortableData('James'),
    const SortableData('John'),
    const SortableData('Robert'),
    const SortableData('Michael'),
    const SortableData('William'),
  ];

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      // Constrain the drag overlay within the horizontal strip.
      lock: true,
      child: SortableDropFallback<int>(
        onAccept: (value) {
          setState(() {
            names.add(names.removeAt(value.data));
          });
        },
        child: SizedBox(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < names.length; i++)
                Sortable<String>(
                  key: ValueKey(i),
                  data: names[i],
                  // For horizontal sorting, drop on the left/right edges to reorder.
                  onAcceptLeft: (value) {
                    setState(() {
                      names.swapItem(value, i);
                    });
                  },
                  onAcceptRight: (value) {
                    setState(() {
                      names.swapItem(value, i + 1);
                    });
                  },
                  child: OutlinedContainer(
                    width: 100,
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(names[i].data)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

```

### Sortable Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample4 extends StatefulWidget {
  const SortableExample4({super.key});

  @override
  State<SortableExample4> createState() => _SortableExample4State();
}

class _SortableExample4State extends State<SortableExample4> {
  List<SortableData<String>> names = [
    const SortableData('James'),
    const SortableData('John'),
    const SortableData('Robert'),
    const SortableData('Michael'),
    const SortableData('William'),
    const SortableData('David'),
    const SortableData('Richard'),
    const SortableData('Joseph'),
    const SortableData('Thomas'),
    const SortableData('Charles'),
    const SortableData('Daniel'),
    const SortableData('Matthew'),
    const SortableData('Anthony'),
    const SortableData('Donald'),
    const SortableData('Mark'),
    const SortableData('Paul'),
    const SortableData('Steven'),
    const SortableData('Andrew'),
    const SortableData('Kenneth'),
  ];

  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: SortableLayer(
        // Constrain drag overlays to the layer bounds so they scroll within the list.
        lock: true,
        child: SortableDropFallback<int>(
          // If dropped outside a specific edge target, append to the end.
          onAccept: (value) {
            setState(() {
              names.add(names.removeAt(value.data));
            });
          },
          // Wrap the scrollable so auto-scrolling can occur while dragging near edges.
          child: ScrollableSortableLayer(
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemBuilder: (context, i) {
                return Sortable<String>(
                  // Stable key helps maintain drag state with virtualization.
                  key: ValueKey(i),
                  data: names[i],
                  onAcceptTop: (value) {
                    setState(() {
                      names.swapItem(value, i);
                    });
                  },
                  onAcceptBottom: (value) {
                    setState(() {
                      names.swapItem(value, i + 1);
                    });
                  },
                  child: OutlinedContainer(
                    padding: const EdgeInsets.all(12),
                    child: Center(child: Text(names[i].data)),
                  ),
                );
              },
              itemCount: names.length,
            ),
          ),
        ),
      ),
    );
  }
}

```

### Sortable Example 5
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample5 extends StatefulWidget {
  const SortableExample5({super.key});

  @override
  State<SortableExample5> createState() => _SortableExample5State();
}

class _SortableExample5State extends State<SortableExample5> {
  List<SortableData<String>> names = [
    const SortableData('James'),
    const SortableData('John'),
    const SortableData('Robert'),
    const SortableData('Michael'),
    const SortableData('William'),
  ];

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      lock: true,
      child: SortableDropFallback<int>(
        // Dropping outside edge targets appends the item to the end.
        onAccept: (value) {
          setState(() {
            names.add(names.removeAt(value.data));
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < names.length; i++)
              Sortable<String>(
                key: ValueKey(i),
                data: names[i],
                // we only want user to drag the item from the handle,
                // so we disable the drag on the item itself
                enabled: false,
                onAcceptTop: (value) {
                  setState(() {
                    names.swapItem(value, i);
                  });
                },
                onAcceptBottom: (value) {
                  setState(() {
                    names.swapItem(value, i + 1);
                  });
                },
                child: OutlinedContainer(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Only this handle starts the drag; the rest of the row is inert.
                      const SortableDragHandle(child: Icon(Icons.drag_handle)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(names[i].data)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

```

### Sortable Example 6
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample6 extends StatefulWidget {
  const SortableExample6({super.key});

  @override
  State<SortableExample6> createState() => _SortableExample6State();
}

class _SortableExample6State extends State<SortableExample6> {
  late List<SortableData<String>> names;

  @override
  void initState() {
    super.initState();
    _reset();
  }

  void _reset() {
    names = [
      const SortableData('James'),
      const SortableData('John'),
      const SortableData('Robert'),
      const SortableData('Michael'),
      const SortableData('William'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      child: Builder(
          // this builder is needed to access the context of the SortableLayer
          builder: (context) {
        return SortableDropFallback<int>(
          onAccept: (value) {
            setState(() {
              names.add(names.removeAt(value.data));
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PrimaryButton(
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: const Text('Reset'),
              ),
              for (int i = 0; i < names.length; i++)
                Sortable<String>(
                  key: ValueKey(i),
                  data: names[i],
                  // we only want user to drag the item from the handle,
                  // so we disable the drag on the item itself
                  enabled: false,
                  onAcceptTop: (value) {
                    setState(() {
                      names.swapItem(value, i);
                    });
                  },
                  onAcceptBottom: (value) {
                    setState(() {
                      names.swapItem(value, i + 1);
                    });
                  },
                  onDropFailed: () {
                    // Remove the item from the list if the drop failed
                    setState(() {
                      var removed = names.removeAt(i);
                      // Ensure the drag overlay exists and then dismiss it so
                      // the item does not animate back to its original position.
                      SortableLayer.ensureAndDismissDrop(context, removed);
                      // Dismissing drop will prevent the SortableLayer from
                      // animating the item back to its original position
                    });
                  },
                  child: OutlinedContainer(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        const SortableDragHandle(
                            child: Icon(Icons.drag_handle)),
                        const SizedBox(width: 8),
                        Expanded(child: Text(names[i].data)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

```

### Sortable Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableTile extends StatelessWidget implements IComponentPage {
  const SortableTile({super.key});

  @override
  String get title => 'Sortable';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'sortable',
      title: 'Sortable',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const Text('Sortable List:').bold(),
            const Gap(16),
            const Column(
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.drag_handle),
                        Gap(8),
                        Text('Item 1'),
                      ],
                    ),
                  ),
                ),
                Gap(8),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.drag_handle),
                        Gap(8),
                        Text('Item 2'),
                      ],
                    ),
                  ),
                ),
                Gap(8),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Icon(Icons.drag_handle),
                        Gap(8),
                        Text('Item 3'),
                      ],
                    ),
                  ),
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
| `canAcceptTop` | `Predicate<SortableData<T>>?` | Predicate to determine if data can be accepted when dropped above this widget.  Type: `Predicate<SortableData<T>>?`. If null, drops from the top are not accepted. Called before [onAcceptTop] to validate the drop operation. |
| `canAcceptLeft` | `Predicate<SortableData<T>>?` | Predicate to determine if data can be accepted when dropped to the left of this widget.  Type: `Predicate<SortableData<T>>?`. If null, drops from the left are not accepted. Called before [onAcceptLeft] to validate the drop operation. |
| `canAcceptRight` | `Predicate<SortableData<T>>?` | Predicate to determine if data can be accepted when dropped to the right of this widget.  Type: `Predicate<SortableData<T>>?`. If null, drops from the right are not accepted. Called before [onAcceptRight] to validate the drop operation. |
| `canAcceptBottom` | `Predicate<SortableData<T>>?` | Predicate to determine if data can be accepted when dropped below this widget.  Type: `Predicate<SortableData<T>>?`. If null, drops from the bottom are not accepted. Called before [onAcceptBottom] to validate the drop operation. |
| `onAcceptTop` | `ValueChanged<SortableData<T>>?` | Callback invoked when data is successfully dropped above this widget.  Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped data and should handle the reordering logic. Only called after [canAcceptTop] validation passes. |
| `onAcceptLeft` | `ValueChanged<SortableData<T>>?` | Callback invoked when data is successfully dropped to the left of this widget.  Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped data and should handle the reordering logic. Only called after [canAcceptLeft] validation passes. |
| `onAcceptRight` | `ValueChanged<SortableData<T>>?` | Callback invoked when data is successfully dropped to the right of this widget.  Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped data and should handle the reordering logic. Only called after [canAcceptRight] validation passes. |
| `onAcceptBottom` | `ValueChanged<SortableData<T>>?` | Callback invoked when data is successfully dropped below this widget.  Type: `ValueChanged<SortableData<T>>?`. The callback receives the dropped data and should handle the reordering logic. Only called after [canAcceptBottom] validation passes. |
| `onDragStart` | `VoidCallback?` | Callback invoked when a drag operation starts on this widget.  Type: `VoidCallback?`. Called immediately when the user begins dragging this sortable item. Useful for providing haptic feedback or updating UI state. |
| `onDragEnd` | `VoidCallback?` | Callback invoked when a drag operation ends successfully.  Type: `VoidCallback?`. Called when the drag completes with a successful drop. This is called before the appropriate accept callback. |
| `onDragCancel` | `VoidCallback?` | Callback invoked when a drag operation is cancelled.  Type: `VoidCallback?`. Called when the drag is cancelled without a successful drop, such as when the user releases outside valid drop zones. |
| `child` | `Widget` | The main child widget that will be made sortable.  Type: `Widget`. This widget is displayed normally and becomes draggable when drag interactions are initiated. |
| `data` | `SortableData<T>` | The data associated with this sortable item.  Type: `SortableData<T>`. Contains the actual data being sorted and provides identity for the drag-and-drop operations. |
| `placeholder` | `Widget?` | Widget displayed in drop zones when this item is being dragged over them.  Type: `Widget?`. If null, uses [SizedBox.shrink]. This creates visual space in potential drop locations, providing clear feedback about where the item will be placed if dropped. |
| `ghost` | `Widget?` | Widget displayed while dragging instead of the original child.  Type: `Widget?`. If null, uses [child]. Typically a semi-transparent or styled version of the child to provide visual feedback during dragging. |
| `fallback` | `Widget?` | Widget displayed in place of the child while it's being dragged.  Type: `Widget?`. If null, the original child becomes invisible but maintains its space. Used to show an alternative representation at the original location. |
| `candidateFallback` | `Widget?` | Widget displayed when the item is a candidate for dropping.  Type: `Widget?`. Shows alternative styling when the dragged item hovers over this sortable as a potential drop target. |
| `enabled` | `bool` | Whether drag interactions are enabled for this sortable.  Type: `bool`, default: `true`. When false, the widget cannot be dragged and will not respond to drag gestures. |
| `behavior` | `HitTestBehavior` | How hit-testing behaves for drag gesture recognition.  Type: `HitTestBehavior`, default: `HitTestBehavior.deferToChild`. Controls how the gesture detector participates in hit testing. |
| `onDropFailed` | `VoidCallback?` | Callback invoked when a drop operation fails.  Type: `VoidCallback?`. Called when the user drops outside of any valid drop zones or when drop validation fails. |
