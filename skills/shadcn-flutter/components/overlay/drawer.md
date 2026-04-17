# DrawerTheme

Theme configuration for drawer and sheet overlays.

## Usage

### Drawer Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'drawer/drawer_example_1.dart';

class DrawerExample extends StatelessWidget {
  const DrawerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'drawer',
      description:
          'A drawer is a panel that slides in from the edge of a screen.',
      displayName: 'Drawer',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/drawer/drawer_example_1.dart',
          child: DrawerExample1(),
        ),
      ],
    );
  }
}

```

### Drawer Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Drawer overlay opened from different screen edges.
///
/// Repeatedly opens nested drawers cycling through positions to showcase
/// [openDrawer] and how to close using [closeOverlay].
class DrawerExample1 extends StatefulWidget {
  const DrawerExample1({super.key});

  @override
  State<DrawerExample1> createState() => _DrawerExample1State();
}

class _DrawerExample1State extends State<DrawerExample1> {
  // Sequence of positions to cycle through as drawers are stacked.
  List<OverlayPosition> positions = [
    OverlayPosition.end,
    OverlayPosition.end,
    OverlayPosition.bottom,
    OverlayPosition.bottom,
    OverlayPosition.top,
    OverlayPosition.top,
    OverlayPosition.start,
    OverlayPosition.start,
  ];
  // Open a drawer and optionally open another from within it.
  void open(BuildContext context, int count) {
    openDrawer(
      context: context,
      expands: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(48),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    'Drawer ${count + 1} at ${positions[count % positions.length].name}'),
                const Gap(16),
                PrimaryButton(
                  onPressed: () {
                    // Open another drawer on top.
                    open(context, count + 1);
                  },
                  child: const Text('Open Another Drawer'),
                ),
                const Gap(8),
                SecondaryButton(
                  onPressed: () {
                    // Close the current top-most overlay.
                    closeOverlay(context);
                  },
                  child: const Text('Close Drawer'),
                ),
              ],
            ),
          ),
        );
      },
      position: positions[count % positions.length],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        open(context, 0);
      },
      child: const Text('Open Drawer'),
    );
  }
}

```

### Drawer Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DrawerTile extends StatelessWidget implements IComponentPage {
  const DrawerTile({super.key});

  @override
  String get title => 'Drawer';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Drawer',
      name: 'drawer',
      scale: 1,
      example: DrawerWrapper(
        stackIndex: 0,
        position: OverlayPosition.bottom,
        size: const Size(300, 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Drawer!').large().medium(),
            const Gap(4),
            const Text('This is a drawer that you can use to display content')
                .muted(),
          ],
        ).withPadding(horizontal: 32),
      ).sized(width: 300, height: 300),
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
| `surfaceOpacity` | `double?` | Surface opacity for backdrop effects. |
| `surfaceBlur` | `double?` | Surface blur intensity for backdrop effects. |
| `barrierColor` | `Color?` | Color of the barrier behind the drawer. |
| `showDragHandle` | `bool?` | Whether to display the drag handle for draggable drawers. |
| `dragHandleSize` | `Size?` | Size of the drag handle when displayed. |
