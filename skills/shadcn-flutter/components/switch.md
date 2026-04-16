# SwitchTheme

Theme configuration for [Switch] widget styling and visual appearance.

## Usage

### Switch Example
```dart
import 'package:docs/pages/docs/components/switch/switch_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class SwitchExample extends StatelessWidget {
  const SwitchExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'switch',
      description:
          'A switch is a visual toggle between two mutually exclusive states — on and off.',
      displayName: 'Switch',
      children: [
        WidgetUsageExample(
          title: 'Switch Example',
          path: 'lib/pages/docs/components/switch/switch_example_1.dart',
          child: SwitchExample1(),
        ),
      ],
    );
  }
}

```

### Switch Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitchExample1 extends StatefulWidget {
  const SwitchExample1({super.key});

  @override
  State<SwitchExample1> createState() => _SwitchExample1State();
}

class _SwitchExample1State extends State<SwitchExample1> {
  // Simple on/off state bound to the Switch.
  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (value) {
        setState(() {
          // Flip the switch.
          this.value = value;
        });
      },
    );
  }
}

```

### Switch Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class SwitchTile extends StatelessWidget implements IComponentPage {
  const SwitchTile({super.key});

  @override
  String get title => 'Switch';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'switch',
      title: 'Switch',
      scale: 2,
      center: true,
      example: Switch(
        value: true,
        onChanged: (value) {},
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
| `activeColor` | `Color?` | Color of the switch track when in the active/on state.  Applied as the background color of the switch track when toggled on. When null, uses the theme's primary color for visual consistency. |
| `inactiveColor` | `Color?` | Color of the switch track when in the inactive/off state.  Applied as the background color of the switch track when toggled off. When null, uses the theme's muted color for visual hierarchy. |
| `activeThumbColor` | `Color?` | Color of the switch thumb when in the active/on state.  Applied to the circular thumb element when the switch is toggled on. When null, uses the theme's primary foreground color for contrast. |
| `inactiveThumbColor` | `Color?` | Color of the switch thumb when in the inactive/off state.  Applied to the circular thumb element when the switch is toggled off. When null, uses a contrasting color against the inactive track. |
| `gap` | `double?` | Spacing between the switch and its leading/trailing widgets.  Applied on both sides of the switch when leading or trailing widgets are provided. When null, defaults to framework spacing standards. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius applied to the switch track corners.  Creates rounded corners on the switch track container. When null, uses a fully rounded appearance typical of toggle switches. |
