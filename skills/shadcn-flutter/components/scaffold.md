# Scaffold

A fundamental layout widget that provides the basic structure for screen layouts.

## Usage

### Scaffold Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/scaffold/scaffold_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ScaffoldExample extends StatelessWidget {
  const ScaffoldExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'scaffold',
      description: 'A scaffold is a top-level container for a page.',
      displayName: 'Scaffold',
      children: [
        WidgetUsageExample(
          title: 'Scaffold Example',
          path: 'lib/pages/docs/components/scaffold/scaffold_example_1.dart',
          child: OutlinedContainer(
            child: const ScaffoldExample1().sized(
              height: 400,
            ),
          ),
        ),
      ],
    );
  }
}

```

### Scaffold Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ScaffoldExample1 extends StatefulWidget {
  const ScaffoldExample1({super.key});

  @override
  State<ScaffoldExample1> createState() => _ScaffoldExample1State();
}

class _ScaffoldExample1State extends State<ScaffoldExample1> {
  // Simple counter to demonstrate updating content inside the Scaffold body.
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Show an indeterminate progress indicator in the header area (for demo purposes).
      loadingProgressIndeterminate: true,
      headers: [
        AppBar(
          title: const Text('Counter App'),
          subtitle: const Text('A simple counter app'),
          leading: [
            OutlineButton(
              onPressed: () {},
              density: ButtonDensity.icon,
              child: const Icon(Icons.menu),
            ),
          ],
          trailing: [
            OutlineButton(
              onPressed: () {},
              density: ButtonDensity.icon,
              child: const Icon(Icons.search),
            ),
            OutlineButton(
              onPressed: () {},
              density: ButtonDensity.icon,
              child: const Icon(Icons.add),
            ),
          ],
        ),
        // Divider between the header and the body.
        const Divider(),
      ],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // The .p() extension adds default padding around the widget.
            const Text('You have pushed the button this many times:').p(),
            Text(
              '$_counter',
            ).h1(),
            PrimaryButton(
              onPressed: _incrementCounter,
              density: ButtonDensity.icon,
              child: const Icon(Icons.add),
            ).p(),
          ],
        ),
      ),
    );
  }
}

```

### Scaffold Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ScaffoldTile extends StatelessWidget implements IComponentPage {
  const ScaffoldTile({super.key});

  @override
  String get title => 'Scaffold';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'scaffold',
      title: 'Scaffold',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 300,
          height: 400,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // AppBar
              Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu,
                        color: theme.colorScheme.primaryForeground),
                    const Gap(16),
                    Text(
                      'Scaffold',
                      style: TextStyle(
                        color: theme.colorScheme.primaryForeground,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              // Body
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: Text('Scaffold Body Content'),
                  ),
                ),
              ),
              // Bottom Navigation
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                    bottomRight: Radius.circular(8),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.home),
                    Icon(Icons.search),
                    Icon(Icons.settings),
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
| `headers` | `List<Widget>` | Header widgets displayed at the top of the scaffold. |
| `footers` | `List<Widget>` | Footer widgets displayed at the bottom of the scaffold. |
| `child` | `Widget` | Main content widget. |
| `loadingProgress` | `double?` | Loading progress value (0.0 to 1.0). |
| `loadingProgressIndeterminate` | `bool` | Whether loading indicator shows indeterminate progress. |
| `floatingHeader` | `bool` | Whether header floats above content (takes no layout space). |
| `floatingFooter` | `bool` | Whether footer floats above content (takes no layout space). |
| `headerBackgroundColor` | `Color?` | Background color for header section. |
| `footerBackgroundColor` | `Color?` | Background color for footer section. |
| `backgroundColor` | `Color?` | Background color for the scaffold. |
| `showLoadingSparks` | `bool?` | Whether to show loading sparks effect. |
| `resizeToAvoidBottomInset` | `bool?` | Whether to resize when keyboard appears. |
