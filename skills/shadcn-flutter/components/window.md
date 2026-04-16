# WindowTheme

Theme configuration for window components.

## Usage

### Window Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/window/window_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WindowExample extends StatelessWidget {
  const WindowExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'window',
      description:
          'A window manager that allows you to create and manage windows.',
      displayName: 'Window',
      children: [
        WidgetUsageExample(
          title: 'Window Example',
          path: 'lib/pages/docs/components/window/window_example_1.dart',
          child: WindowExample1(),
        ),
      ],
    );
  }
}

```

### Window Example 1
```dart
import 'package:docs/debug.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a WindowNavigator simulating multiple desktop-style windows,
// with an action to add a new window at runtime.

class WindowExample1 extends StatefulWidget {
  const WindowExample1({super.key});

  @override
  State<WindowExample1> createState() => _WindowExample1State();
}

class _WindowExample1State extends State<WindowExample1> {
  final GlobalKey<WindowNavigatorHandle> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedContainer(
          height: 600, // for example purpose
          child: WindowNavigator(
            key: navigatorKey,
            // Pre-populate with two windows, each with its own bounds and title.
            initialWindows: [
              Window(
                bounds: const Rect.fromLTWH(0, 0, 200, 200),
                title: const Text('Window 1'),
                content: const RebuildCounter(),
              ),
              Window(
                bounds: const Rect.fromLTWH(200, 0, 200, 200),
                title: const Text('Window 2'),
                content: const RebuildCounter(),
              ),
            ],
            child: const Center(
              child: Text('Desktop'),
            ),
          ),
        ),
        PrimaryButton(
          child: const Text('Add Window'),
          onPressed: () {
            // Push a new window via the navigator; title uses the current count.
            navigatorKey.currentState?.pushWindow(
              Window(
                bounds: const Rect.fromLTWH(0, 0, 200, 200),
                title: Text(
                    'Window ${navigatorKey.currentState!.windows.length + 1}'),
                content: const RebuildCounter(),
              ),
            );
          },
        )
      ],
    );
  }
}

```

### Window Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WindowTile extends StatelessWidget implements IComponentPage {
  const WindowTile({super.key});

  @override
  String get title => 'Window';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'window',
      title: 'Window',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 320,
          height: 240,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Window title bar
              Container(
                height: 40,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    // Window controls
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.yellow,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(6),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const Gap(16),
                    const Text('Window Title').medium(),
                    const Spacer(),
                    const Icon(Icons.minimize, size: 16),
                    const Gap(8),
                    const Icon(Icons.crop_square, size: 16),
                    const Gap(8),
                    const Icon(Icons.close, size: 16),
                  ],
                ),
              ),
              // Window content
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('Window Content Area'),
                  ),
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
| `titleBarHeight` | `double?` | Height of the window's title bar in logical pixels.  Determines the vertical space allocated for the title bar which typically contains the window title, control buttons (minimize, maximize, close), and any custom action widgets.  If `null`, uses the default title bar height from the theme. |
| `resizeThickness` | `double?` | Thickness of the window's resize border in logical pixels.  Defines the width of the interactive area along window edges that allows users to resize the window by dragging. A larger value makes it easier to grab the edge for resizing.  If `null`, uses the default resize border thickness from the theme. |
