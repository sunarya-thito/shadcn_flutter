# Checkbox

Core checkbox widget with comprehensive theming and interaction support.

## Usage

### Checkbox Example
```dart
import 'package:docs/pages/docs/components/checkbox/checkbox_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'checkbox/checkbox_example_2.dart';

class CheckboxExample extends StatelessWidget {
  const CheckboxExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'checkbox',
      description:
          'Checkboxes allow the user to select one or more items from a set.',
      displayName: 'Checkbox',
      children: [
        WidgetUsageExample(
          title: 'Checkbox Example',
          path: 'lib/pages/docs/components/checkbox/checkbox_example_1.dart',
          child: CheckboxExample1(),
        ),
        WidgetUsageExample(
          title: 'Checkbox Example with Tristate',
          path: 'lib/pages/docs/components/checkbox/checkbox_example_2.dart',
          child: CheckboxExample2(),
        ),
      ],
    );
  }
}

```

### Checkbox Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Checkbox with two states (checked/unchecked).
///
/// Demonstrates controlling [Checkbox] via a local [CheckboxState]
/// and updating it from [onChanged].
class CheckboxExample1 extends StatefulWidget {
  const CheckboxExample1({super.key});

  @override
  State<CheckboxExample1> createState() => _CheckboxExample1State();
}

class _CheckboxExample1State extends State<CheckboxExample1> {
  // Start unchecked; toggle when the user taps the control.
  CheckboxState _state = CheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      state: _state,
      onChanged: (value) {
        setState(() {
          _state = value;
        });
      },
      // Optional label placed on the trailing side.
      trailing: const Text('Remember me'),
    );
  }
}

```

### Checkbox Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Checkbox with three states (unchecked, indeterminate, checked).
///
/// Enabling [tristate] allows the middle "indeterminate" state.
class CheckboxExample2 extends StatefulWidget {
  const CheckboxExample2({super.key});

  @override
  State<CheckboxExample2> createState() => _CheckboxExample2State();
}

class _CheckboxExample2State extends State<CheckboxExample2> {
  CheckboxState _state = CheckboxState.unchecked;
  @override
  Widget build(BuildContext context) {
    return Checkbox(
      state: _state,
      onChanged: (value) {
        setState(() {
          _state = value;
        });
      },
      trailing: const Text('Remember me'),
      // Allow toggling: unchecked -> indeterminate -> checked -> ...
      tristate: true,
    );
  }
}

```

### Checkbox Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class CheckboxTile extends StatelessWidget implements IComponentPage {
  const CheckboxTile({super.key});

  @override
  String get title => 'Checkbox';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'checkbox',
      title: 'Checkbox',
      scale: 1.8,
      example: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Checkbox(
              state: CheckboxState.checked,
              trailing: const Text('Checked'),
              onChanged: (value) {},
            ),
            Checkbox(
              state: CheckboxState.indeterminate,
              trailing: const Text('Indeterminate'),
              onChanged: (value) {},
            ),
            Checkbox(
              state: CheckboxState.unchecked,
              trailing: const Text('Unchecked'),
              onChanged: (value) {},
            ),
          ],
        ).gap(4).sized(width: 300),
      ),
    );
  }
}

```



## Features
- **Tri-state support**: checked, unchecked, and indeterminate states
- **Smooth animations**: animated checkmark drawing and state transitions
- **Comprehensive theming**: colors, sizing, spacing, and border customization
- **Accessibility**: proper semantics, focus management, and keyboard support
- **Form integration**: automatic form field registration and validation support
- **Layout flexibility**: leading/trailing widgets with automatic styling

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `state` | `CheckboxState` | Current state of the checkbox.  Must be one of [CheckboxState.checked], [CheckboxState.unchecked], or [CheckboxState.indeterminate]. The widget rebuilds when this changes to reflect the new visual state with appropriate animations. |
| `onChanged` | `ValueChanged<CheckboxState>?` | Callback fired when the user interacts with the checkbox.  Called with the new [CheckboxState] that should be applied. When null, the checkbox becomes non-interactive and visually disabled.  The callback is responsible for updating the parent widget's state to reflect the change - this widget does not manage its own state. |
| `leading` | `Widget?` | Optional widget displayed before the checkbox square.  Commonly used for icons or primary labels. The widget is automatically styled with small and medium text styles for visual consistency. Spacing between leading widget and checkbox is controlled by [gap]. |
| `trailing` | `Widget?` | Optional widget displayed after the checkbox square.  Commonly used for labels, descriptions, or secondary information. The widget is automatically styled with small and medium text styles for visual consistency. Spacing is controlled by [gap]. |
| `tristate` | `bool` | Whether the checkbox supports indeterminate state cycling.  When true, user interaction cycles through: checked -> unchecked -> indeterminate. When false, only toggles between checked and unchecked states. The indeterminate state can still be set programmatically regardless of this setting. |
| `enabled` | `bool?` | Whether the checkbox is interactive and enabled.  When false, the checkbox becomes visually disabled and non-interactive. When null, the enabled state is automatically determined from the presence of an [onChanged] callback. |
| `size` | `double?` | Size of the checkbox square in logical pixels.  Overrides the theme default. When null, uses [CheckboxTheme.size] or framework default (16 logical pixels scaled by theme scaling factor). |
| `gap` | `double?` | Spacing between the checkbox and its leading/trailing widgets.  Overrides the theme default. Applied on both sides when leading or trailing widgets are present. When null, uses [CheckboxTheme.gap] or framework default. |
| `backgroundColor` | `Color?` | Color of the checkbox background when in unchecked state.  Overrides the theme default. Applied as the background color when unchecked. When null, uses a semi-transparent version of the theme's input background color. |
| `activeColor` | `Color?` | Color used for the checkbox when in checked state.  Overrides the theme default. Applied as both background and border color when checked. When null, uses [CheckboxTheme.activeColor] or theme primary color. |
| `borderColor` | `Color?` | Color used for the checkbox border when unchecked or indeterminate.  Overrides the theme default. Only visible in unchecked state as checked state uses [activeColor]. When null, uses [CheckboxTheme.borderColor] or theme border color. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius applied to the checkbox square.  Overrides the theme default. Creates rounded corners on the checkbox container. When null, uses [CheckboxTheme.borderRadius] or theme small radius. |
