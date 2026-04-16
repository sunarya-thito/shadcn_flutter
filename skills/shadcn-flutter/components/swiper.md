# SwiperTheme

Theme configuration for swiper overlay behavior and appearance.

## Usage

### Swiper Example
```dart
import 'package:docs/pages/docs/components/swiper/swiper_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SwiperExample extends StatelessWidget {
  const SwiperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'swiper',
      description: 'Enable swiping gestures to open a drawer or a sheet.',
      displayName: 'Swiper',
      children: [
        WidgetUsageExample(
          title: 'Example 1',
          path: 'lib/pages/docs/components/swiper/swiper_example_1.dart',
          child: SwiperExample1(),
        ),
      ],
    );
  }
}

```

### Swiper Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwiperExample1 extends StatefulWidget {
  const SwiperExample1({super.key});

  @override
  State<SwiperExample1> createState() => _SwiperExample1State();
}

class _SwiperExample1State extends State<SwiperExample1> {
  OverlayPosition _position = OverlayPosition.end;
  bool _typeDrawer = true;

  Widget _buildSelectPosition(OverlayPosition position, String label) {
    return SelectedButton(
      value: _position == position,
      onChanged: (value) {
        if (value) {
          setState(() {
            _position = position;
          });
        }
      },
      style: const ButtonStyle.outline(),
      selectedStyle: const ButtonStyle.primary(),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Swiper(
      builder: (context) {
        return Container(
          constraints: const BoxConstraints(
            minWidth: 320,
            minHeight: 320,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hello!'),
              const Gap(24),
              PrimaryButton(
                onPressed: () {
                  openDrawer(
                      context: context,
                      builder: (context) {
                        return ListView.separated(
                          itemCount: 1000,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Text('Item $index'),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const Gap(8);
                          },
                        );
                      },
                      position: OverlayPosition.bottom);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
      // Swiper displays an overlay (drawer/sheet) that can be swiped in from a chosen edge.
      position: _position,
      // Choose the overlay type: Drawer slides over content; Sheet peeks up from an edge.
      handler: _typeDrawer ? SwiperHandler.drawer : SwiperHandler.sheet,
      child: SizedBox(
        height: 500,
        child: Card(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Swipe me!'),
                const Gap(24),
                ButtonGroup(children: [
                  _buildSelectPosition(OverlayPosition.left, 'Left'),
                  _buildSelectPosition(OverlayPosition.right, 'Right'),
                  _buildSelectPosition(OverlayPosition.top, 'Top'),
                  _buildSelectPosition(OverlayPosition.bottom, 'Bottom'),
                ]),
                const Gap(24),
                ButtonGroup(children: [
                  Toggle(
                    value: _typeDrawer,
                    onChanged: (value) {
                      setState(() {
                        _typeDrawer = value;
                      });
                    },
                    child: const Text('Drawer'),
                  ),
                  Toggle(
                    value: !_typeDrawer,
                    onChanged: (value) {
                      setState(() {
                        _typeDrawer = !value;
                      });
                    },
                    child: const Text('Sheet'),
                  ),
                ]),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

```

### Swiper Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwiperTile extends StatelessWidget implements IComponentPage {
  const SwiperTile({super.key});

  @override
  String get title => 'Swiper';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'swiper',
      title: 'Swiper',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Swiper content
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Slide 1',
                    style: TextStyle(
                      color: theme.colorScheme.primaryForeground,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Navigation arrows
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          theme.colorScheme.background.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_left, size: 20),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color:
                          theme.colorScheme.background.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_right, size: 20),
                  ),
                ),
              ),
              // Dots indicator
              Positioned(
                bottom: 16,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryForeground,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryForeground
                            .withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(4),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryForeground
                            .withValues(alpha: 0.5),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
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



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `expands` | `bool?` | Whether the swiper should expand to fill available space. |
| `draggable` | `bool?` | Whether the swiper can be dragged to dismiss. |
| `barrierDismissible` | `bool?` | Whether tapping the barrier dismisses the swiper. |
| `backdropBuilder` | `WidgetBuilder?` | Builder for custom backdrop content. |
| `useSafeArea` | `bool?` | Whether to respect device safe areas. |
| `showDragHandle` | `bool?` | Whether to show the drag handle. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius for the swiper container. |
| `dragHandleSize` | `Size?` | Size of the drag handle when displayed. |
| `transformBackdrop` | `bool?` | Whether to transform the backdrop when shown. |
| `surfaceOpacity` | `double?` | Opacity for surface effects. |
| `surfaceBlur` | `double?` | Blur intensity for surface effects. |
| `barrierColor` | `Color?` | Color of the modal barrier. |
| `behavior` | `HitTestBehavior?` | Hit test behavior for gesture detection. |
