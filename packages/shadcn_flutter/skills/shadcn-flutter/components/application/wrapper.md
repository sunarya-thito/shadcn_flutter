# Wrapper

A widget that conditionally wraps its child with a builder function.

## Usage

### Wrapper Example
```dart
// Wrapper example page: lists and renders the Wrapper component demos.
//
// This is a docs wrapper page (not the demo unit). It composes a ComponentPage
// with one or more WidgetUsageExample entries that point to the actual demo
// files under components/wrapper/*. Behavior unchanged; comments only.
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/wrapper/wrapper_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WrapperExample extends StatelessWidget {
  const WrapperExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'wrapper',
      description:
          'ShadcnUI widget is a component that allows you to use Shadcn/UI components '
          'within your MaterialApp or CupertinoApp, providing consistent theming and styling.',
      displayName: 'Wrapper',
      children: [
        WidgetUsageExample(
          title: 'Wrapper Example',
          path: 'lib/pages/docs/components/wrapper/wrapper_example_1.dart',
          child: const WrapperExample1().sized(height: 300),
        ),
      ],
    );
  }
}

```

### Wrapper Example 1
```dart
import 'package:material_ui/material_ui.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart' as shadcn;

// Wrap part of an existing Material/Cupertino app with ShadcnLayer.
// Useful when you want to adopt shadcn_flutter components and theming without
// replacing your root MaterialApp/CupertinoApp structure.
//
// This is the mirror image of MaterialLayer/CupertinoLayer from
// shadcn_flutter_material and shadcn_flutter_cupertino: those bring Material or
// Cupertino into a shadcn app, this brings shadcn into a Material or Cupertino
// app. Neither requires shadcn_flutter itself to depend on Material.

class WrapperExample1 extends StatelessWidget {
  const WrapperExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // If you are using MaterialApp or CupertinoApp
    // but still want to use shadcn_flutter theming and components,
    // wrap that subtree with ShadcnLayer.
    return const shadcn.ShadcnLayer(
      theme: shadcn.ThemeData(),
      darkTheme: shadcn.ThemeData.dark(),
      child: shadcn.Scaffold(
        headers: [
          shadcn.AppBar(
            title: Text('Shadcn UI Wrapper Example'),
          ),
          shadcn.Divider(),
        ],
        child: Center(
          child: shadcn.Text('Hello, Shadcn Flutter!'),
        ),
      ),
    );
  }
}

```

### Wrapper Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WrapperTile extends StatelessWidget implements IComponentPage {
  const WrapperTile({super.key});

  @override
  String get title => 'ShadcnLayer';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'ShadcnLayer',
      name: 'wrapper',
      fit: true,
      example: SizedBox(
        width: 280,
        height: 180,
        child: OutlinedContainer(
          child: Scaffold(
            headers: const [
              AppBar(title: Text('My App')),
              Divider(),
            ],
            child: const Center(
              child: Text('Hello, Shadcn Flutter!'),
            ),
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
| `child` | `Widget` | The child widget to be wrapped. |
| `builder` | `WrapperBuilder?` | Optional builder function to wrap the child.  If [wrap] is true and this is provided, the child will be wrapped using this builder function. If null, the child is returned as-is. |
| `wrap` | `bool` | Whether to apply the [builder] wrapper.  When false, the [child] is returned directly regardless of [builder]. Defaults to true. |
| `maintainStructure` | `bool` | Whether to maintain the widget structure across rebuilds.  When true, wraps the child in a [KeyedSubtree] to preserve the widget subtree identity across rebuilds. This can be useful for maintaining widget state when the wrapper's parent rebuilds. Defaults to false. |
