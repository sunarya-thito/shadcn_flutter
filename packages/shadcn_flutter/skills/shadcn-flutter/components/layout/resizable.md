# ResizableDraggerTheme

Theme for [HorizontalResizableDragger] and [VerticalResizableDragger].

## Usage

### Resizable Example
```dart
import 'package:docs/pages/docs/components/resizable/resizable_example_1.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_2.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_3.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_4.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_5.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_6.dart';
import 'package:docs/pages/docs/components/resizable/resizable_example_7.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class ResizableExample extends StatelessWidget {
  const ResizableExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'resizable',
      description: 'A resizable pane widget, support resize child widget.',
      displayName: 'Resizable',
      children: [
        WidgetUsageExample(
          title: 'Horizontal Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_1.dart',
          child: ResizableExample1(),
        ),
        WidgetUsageExample(
          title: 'Vertical Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_2.dart',
          child: ResizableExample2(),
        ),
        WidgetUsageExample(
          title: 'Horizontal Example with Dragger',
          path: 'lib/pages/docs/components/resizable/resizable_example_3.dart',
          child: ResizableExample3(),
        ),
        WidgetUsageExample(
          title: 'Controller Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_4.dart',
          child: ResizableExample4(),
        ),
        WidgetUsageExample(
          title: 'Collapsible Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_5.dart',
          child: ResizableExample5(),
        ),
        WidgetUsageExample(
          title: 'Nested Example',
          path: 'lib/pages/docs/components/resizable/resizable_example_6.dart',
          child: ResizableExample6(),
        ),
        WidgetUsageExample(
          path: 'lib/pages/docs/components/resizable/resizable_example_7.dart',
          title: 'Dynamic Children Example',
          child: ResizableExample7(),
        ),
      ],
    );
  }
}

```

### Resizable Example 1
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample1 extends StatefulWidget {
  const ResizableExample1({super.key});

  @override
  State<ResizableExample1> createState() => _ResizableExample1State();
}

class _ResizableExample1State extends State<ResizableExample1> {
  @override
  Widget build(BuildContext context) {
    return const OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      // A horizontal panel splits available width into multiple resizable panes.
      child: ResizablePanel.horizontal(
        children: [
          ResizablePane(
            // Initial width in logical pixels for this pane.
            initialSize: 80,
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 1,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 120,
            child: NumberedContainer(
              index: 2,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 3,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 4,
              height: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}

```

### Resizable Example 2
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample2 extends StatefulWidget {
  const ResizableExample2({super.key});

  @override
  State<ResizableExample2> createState() => _ResizableExample2State();
}

class _ResizableExample2State extends State<ResizableExample2> {
  @override
  Widget build(BuildContext context) {
    return const OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      // A vertical panel splits available height into multiple resizable rows (panes).
      child: ResizablePanel.vertical(
        children: [
          ResizablePane(
            // Initial height in logical pixels for this row.
            initialSize: 80,
            child: NumberedContainer(
              index: 0,
              width: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 120,
            child: NumberedContainer(
              index: 1,
              width: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 2,
              width: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}

```

### Resizable Example 3
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample3 extends StatefulWidget {
  const ResizableExample3({super.key});

  @override
  State<ResizableExample3> createState() => _ResizableExample3State();
}

class _ResizableExample3State extends State<ResizableExample3> {
  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel.horizontal(
        // Provide a custom dragger appearance/behavior for the splitters.
        draggerBuilder: (context) {
          return const HorizontalResizableDragger();
        },
        children: const [
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 1,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 120,
            child: NumberedContainer(
              index: 2,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 3,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            initialSize: 80,
            child: NumberedContainer(
              index: 4,
              height: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}

```

### Resizable Example 4
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample4 extends StatefulWidget {
  const ResizableExample4({super.key});

  @override
  State<ResizableExample4> createState() => _ResizableExample4State();
}

class _ResizableExample4State extends State<ResizableExample4> {
  // Controlled panes: each pane has its own controller so we can read/write size
  // and call helper methods (tryExpandSize, tryCollapse, etc.).
  final AbsoluteResizablePaneController controller1 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller2 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller3 =
      AbsoluteResizablePaneController(120);
  final AbsoluteResizablePaneController controller4 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller5 =
      AbsoluteResizablePaneController(80);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: ResizablePanel.horizontal(
            children: [
              ResizablePane.controlled(
                // Bind pane size to controller1 (initial 80px).
                controller: controller1,
                child: const NumberedContainer(
                  index: 0,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller2,
                child: const NumberedContainer(
                  index: 1,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller3,
                // Optional constraint: this pane cannot grow beyond 200px.
                maxSize: 200,
                child: const NumberedContainer(
                  index: 2,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller4,
                child: const NumberedContainer(
                  index: 3,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller5,
                // Min size prevents the pane from being dragged smaller than 80px.
                minSize: 80,
                // When collapsed, this pane will reduce to 20px instead of disappearing.
                collapsedSize: 20,
                child: const NumberedContainer(
                  index: 4,
                  height: 200,
                  fill: false,
                ),
              ),
            ],
          ),
        ),
        const Gap(48),
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: [
            PrimaryButton(
              onPressed: () {
                // Restore all panes to their initial sizes.
                controller1.size = 80;
                controller2.size = 80;
                controller3.size = 120;
                controller4.size = 80;
                controller5.size = 80;
              },
              child: const Text('Reset'),
            ),
            PrimaryButton(
              onPressed: () {
                // Attempt to grow pane 2 (controller3) by +20px.
                controller3.tryExpandSize(20);
              },
              child: const Text('Expand Panel 2'),
            ),
            PrimaryButton(
              onPressed: () {
                // Attempt to shrink pane 2 (controller3) by -20px.
                controller3.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 2'),
            ),
            PrimaryButton(
              onPressed: () {
                // Modify another pane's size incrementally.
                controller2.tryExpandSize(20);
              },
              child: const Text('Expand Panel 1'),
            ),
            PrimaryButton(
              onPressed: () {
                controller2.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 1'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(20);
              },
              child: const Text('Expand Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                controller5.tryExpandSize(-20);
              },
              child: const Text('Shrink Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                // Collapse reduces the pane to its 'collapsedSize'.
                controller5.tryCollapse();
              },
              child: const Text('Collapse Panel 4'),
            ),
            PrimaryButton(
              onPressed: () {
                // Expand restores from the collapsed state.
                controller5.tryExpand();
              },
              child: const Text('Expand Panel 4'),
            ),
          ],
        )
      ],
    );
  }
}

```

### Resizable Example 5
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample5 extends StatefulWidget {
  const ResizableExample5({super.key});

  @override
  State<ResizableExample5> createState() => _ResizableExample5State();
}

class _ResizableExample5State extends State<ResizableExample5> {
  final ResizablePaneController controller =
      AbsoluteResizablePaneController(120);
  final ResizablePaneController controller2 =
      AbsoluteResizablePaneController(120);
  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: ResizablePanel.horizontal(
        children: [
          ResizablePane.controlled(
            // This controlled pane supports collapsing with a minimum and collapsed size.
            minSize: 100,
            collapsedSize: 40,
            controller: controller,
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                // Render a different UI when the pane is collapsed.
                if (controller.collapsed) {
                  return Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Text('Collapsed'),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: const Text('Expanded'),
                );
              },
            ),
          ),
          ResizablePane(
            // A standard resizable pane with an absolute initial width.
            initialSize: 300,
            child: Container(
              alignment: Alignment.center,
              height: 200,
              child: const Text('Resizable'),
            ),
          ),
          ResizablePane.controlled(
            minSize: 100,
            collapsedSize: 40,
            controller: controller2,
            child: AnimatedBuilder(
              animation: controller2,
              builder: (context, child) {
                if (controller2.collapsed) {
                  return Container(
                    alignment: Alignment.center,
                    height: 200,
                    child: const RotatedBox(
                      quarterTurns: -1,
                      child: Text('Collapsed'),
                    ),
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  height: 200,
                  child: const Text('Expanded'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

```

### Resizable Example 6
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample6 extends StatefulWidget {
  const ResizableExample6({super.key});

  @override
  State<ResizableExample6> createState() => _ResizableExample6State();
}

class _ResizableExample6State extends State<ResizableExample6> {
  @override
  Widget build(BuildContext context) {
    return const OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      // Demonstrates nesting panels: horizontal root with vertical and horizontal children.
      child: ResizablePanel.horizontal(
        children: [
          ResizablePane(
            initialSize: 100,
            minSize: 40,
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            minSize: 100,
            initialSize: 300,
            // Middle pane is its own vertical resizable group.
            child: ResizablePanel.vertical(
              children: [
                ResizablePane(
                  initialSize: 80,
                  minSize: 40,
                  child: NumberedContainer(
                    index: 1,
                    fill: false,
                  ),
                ),
                ResizablePane(
                  minSize: 40,
                  initialSize: 120,
                  // This pane contains a horizontal panel using flexible panes below.
                  child: ResizablePanel.horizontal(
                    children: [
                      // Flex panes share remaining space proportionally.
                      ResizablePane.flex(
                        child: NumberedContainer(
                          index: 2,
                          fill: false,
                        ),
                      ),
                      ResizablePane.flex(
                        child: NumberedContainer(
                          index: 3,
                          fill: false,
                        ),
                      ),
                      ResizablePane.flex(
                        child: NumberedContainer(
                          index: 4,
                          fill: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ResizablePane(
            initialSize: 100,
            minSize: 40,
            child: NumberedContainer(
              index: 5,
              height: 200,
              fill: false,
            ),
          ),
        ],
      ),
    );
  }
}

```

### Resizable Example 7
```dart
import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample7 extends StatefulWidget {
  const ResizableExample7({super.key});

  @override
  State<ResizableExample7> createState() => _ResizableExample7State();
}

class _ResizableExample7State extends State<ResizableExample7> {
  // Dynamic list of colors to render each resizable pane.
  final List<Color> _items = List.generate(2, (index) => _generateColor());

  static Color _generateColor() {
    Random random = Random();
    return HSVColor.fromAHSV(
      1.0,
      random.nextInt(360).toDouble(),
      0.8,
      0.8,
    ).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          ResizablePanel.vertical(
            children: [
              for (int i = 0; i < _items.length; i++)
                ResizablePane(
                  // Use a ValueKey derived from the color so Flutter can track panes across insert/remove.
                  key: ValueKey(_items[i].toARGB32()),
                  initialSize: 200,
                  minSize: 100,
                  child: Container(
                    color: _items[i],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: const Text('Insert Before'),
                            onPressed: () {
                              setState(() {
                                // Insert a new pane before the current one.
                                _items.insert(i, _generateColor());
                              });
                            },
                          ),
                          TextButton(
                            child: const Text('Remove'),
                            onPressed: () {
                              setState(() {
                                // Remove this pane.
                                _items.removeAt(i);
                              });
                            },
                          ),
                          TextButton(
                            child: const Text('Insert After'),
                            onPressed: () {
                              setState(() {
                                // Insert a new pane after the current one.
                                _items.insert(i + 1, _generateColor());
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
          PrimaryButton(
            child: const Text('Add'),
            onPressed: () {
              setState(() {
                // Append a new pane at the end.
                _items.add(_generateColor());
              });
            },
          ),
        ],
      ),
    );
  }
}

```

### Resizable Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import 'resizable_example_3.dart';

class ResizableTile extends StatelessWidget implements IComponentPage {
  const ResizableTile({super.key});

  @override
  String get title => 'Resizable';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      title: 'Resizable',
      name: 'resizable',
      scale: 1,
      example: ResizableExample3(),
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
| `color` | `Color?` | Background color of the dragger. |
| `borderRadius` | `double?` | Border radius of the dragger. |
| `width` | `double?` | Width of the dragger. |
| `height` | `double?` | Height of the dragger. |
| `iconSize` | `double?` | Icon size inside the dragger. |
| `iconColor` | `Color?` | Icon color inside the dragger. |
