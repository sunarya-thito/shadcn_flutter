# Switch

A Material Design switch for toggling boolean values.

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
| `value` | `bool` | The current state of the switch. |
| `onChanged` | `ValueChanged<bool>?` | Callback invoked when the switch state changes.  If `null`, the switch is disabled. |
| `leading` | `Widget?` | Optional leading widget displayed before the switch.  Typically an icon or text label. |
| `trailing` | `Widget?` | Optional trailing widget displayed after the switch.  Typically an icon or text label. |
| `enabled` | `bool?` | Whether the switch is interactive.  When `false`, the switch is disabled. Defaults to `true`. |
| `gap` | `double?` | Spacing between the switch and [leading]/[trailing] widgets.  If `null`, uses the default gap from the theme. |
| `activeColor` | `Color?` | Color of the switch when in the active (on) state.  If `null`, uses the theme's primary color. |
| `inactiveColor` | `Color?` | Color of the switch when in the inactive (off) state.  If `null`, uses a default inactive color from the theme. |
| `activeThumbColor` | `Color?` | Color of the thumb (knob) when the switch is active.  If `null`, uses a default thumb color. |
| `inactiveThumbColor` | `Color?` | Color of the thumb (knob) when the switch is inactive.  If `null`, uses a default thumb color. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius for the switch track.  If `null`, uses the default border radius from the theme. |
