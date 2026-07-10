# ToastTheme

Theme configuration for toast notification system.

## Usage

### Toast Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/toast/toast_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ToastExample extends StatelessWidget {
  const ToastExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'toast',
      description:
          'A toast is a non-modal, unobtrusive window element used to display brief, auto-expiring information to the user.',
      displayName: 'Toast',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/toast/toast_example_1.dart',
          child: ToastExample1(),
        ),
      ],
    );
  }
}

```

### Toast Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates toast overlays in different screen locations with a custom
// content builder and programmatic close via the overlay handle.

class ToastExample1 extends StatefulWidget {
  const ToastExample1({super.key});

  @override
  State<ToastExample1> createState() => _ToastExample1State();
}

class _ToastExample1State extends State<ToastExample1> {
  // Builder for the toast content; receives an overlay handle so we can close it.
  Widget buildToast(BuildContext context, ToastOverlay overlay) {
    return SurfaceCard(
      child: Basic(
        title: const Text('Event has been created'),
        subtitle: const Text('Sunday, July 07, 2024 at 12:00 PM'),
        trailing: PrimaryButton(
            size: ButtonSize.small,
            onPressed: () {
              // Close the toast programmatically when clicking Undo.
              overlay.close();
            },
            child: const Text('Undo')),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position bottom-left.
              location: ToastLocation.bottomLeft,
            );
          },
          child: const Text('Show Bottom Left Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position bottom-right.
              location: ToastLocation.bottomRight,
            );
          },
          child: const Text('Show Bottom Right Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position top-left.
              location: ToastLocation.topLeft,
            );
          },
          child: const Text('Show Top Left Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              // Position top-right.
              location: ToastLocation.topRight,
            );
          },
          child: const Text('Show Top Right Toast'),
        ),
        // bottom center
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.bottomCenter,
            );
          },
          child: const Text('Show Bottom Center Toast'),
        ),
        // top center
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.topCenter,
            );
          },
          child: const Text('Show Top Center Toast'),
        ),
      ],
    );
  }
}

```

### Toast Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ToastTile extends StatelessWidget implements IComponentPage {
  const ToastTile({super.key});

  @override
  String get title => 'Toast';

  Widget _buildToast() {
    return Card(
      child: Basic(
        title: const Text('Event has been created'),
        subtitle: const Text('Sunday, July 07, 2024 at 12:00 PM'),
        trailing: PrimaryButton(
            size: ButtonSize.small,
            onPressed: () {},
            child: const Text('Undo')),
        trailingAlignment: Alignment.center,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Toast',
      name: 'toast',
      scale: 1.3,
      reverseVertical: true,
      example: Stack(
        children: [
          Transform.translate(
            offset: const Offset(0, -24),
            child: Transform.scale(
              scale: 0.9 * 0.9,
              child: Opacity(
                opacity: 0.5,
                child: _buildToast(),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -12),
            child: Transform.scale(
              scale: 0.9,
              child: Opacity(
                opacity: 0.75,
                child: _buildToast(),
              ),
            ),
          ),
          _buildToast(),
        ],
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
| `maxStackedEntries` | `int?` | Maximum number of toast notifications to stack visually.  Type: `int?`. If null, defaults to 3 stacked entries. Controls how many toasts are visible simultaneously, with older toasts being collapsed or hidden. |
| `padding` | `EdgeInsetsGeometry?` | Padding around the toast notification area.  Type: `EdgeInsetsGeometry?`. If null, defaults to EdgeInsets.all(24) scaled by theme scaling factor. Applied to the toast positioning within safe area. |
| `expandMode` | `ExpandMode?` | Behavior mode for toast stack expansion.  Type: `ExpandMode?`. If null, defaults to [ExpandMode.expandOnHover]. Controls when stacked toasts expand to show multiple entries simultaneously. |
| `collapsedOffset` | `Offset?` | Offset for collapsed toast positioning.  Type: `Offset?`. If null, defaults to Offset(0, 12) scaled by theme. Controls the vertical/horizontal spacing between stacked toast entries. |
| `collapsedScale` | `double?` | Scale factor for collapsed toast entries.  Type: `double?`. If null, defaults to 0.9. Controls the size reduction of toast notifications that are stacked behind the active toast. |
| `expandingCurve` | `Curve?` | Animation curve for toast expansion transitions.  Type: `Curve?`. If null, defaults to Curves.easeOutCubic. Applied when transitioning between collapsed and expanded stack states. |
| `expandingDuration` | `Duration?` | Duration for toast expansion animations.  Type: `Duration?`. If null, defaults to 500 milliseconds. Controls the timing of stack expansion and collapse transitions. |
| `collapsedOpacity` | `double?` | Opacity level for collapsed toast entries.  Type: `double?`. If null, defaults to 1.0 (fully opaque). Controls the visibility of toast notifications in the stack behind the active toast. |
| `entryOpacity` | `double?` | Initial opacity for toast entry animations.  Type: `double?`. If null, defaults to 0.0 (fully transparent). Starting opacity value for toast notifications when they first appear. |
| `spacing` | `double?` | Spacing between expanded toast entries.  Type: `double?`. If null, defaults to 8.0. Controls the gap between toast notifications when the stack is in expanded state. |
| `toastConstraints` | `BoxConstraints?` | Size constraints for individual toast notifications.  Type: `BoxConstraints?`. If null, defaults to fixed width of 320 scaled by theme. Defines the maximum/minimum dimensions for toast content. |
