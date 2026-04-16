# CheckboxTheme

Theme configuration for [Checkbox] widget styling and visual appearance.

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
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `backgroundColor` | `Color?` | Color of the checkbox background when in unchecked state.  Applied as the background color when the checkbox is unchecked. When null, uses a semi-transparent version of the theme's input background color. |
| `activeColor` | `Color?` | Color of the checkbox background when in checked state.  Applied as both background and border color when the checkbox is checked. When null, uses the theme's primary color. |
| `borderColor` | `Color?` | Color of the checkbox border when in unchecked state.  Only visible when the checkbox is unchecked or in indeterminate state. When null, uses the theme's border color. |
| `size` | `double?` | Size of the checkbox square in logical pixels.  Controls both width and height of the checkbox square. The checkmark and indeterminate indicator are scaled proportionally. When null, defaults to 16 logical pixels scaled by theme scaling factor. |
| `gap` | `double?` | Spacing between the checkbox and its leading/trailing widgets.  Applied on both sides of the checkbox square when leading or trailing widgets are provided. When null, defaults to 8 logical pixels scaled by theme scaling factor. |
| `borderRadius` | `BorderRadiusGeometry?` | Border radius applied to the checkbox square corners.  Creates rounded corners on the checkbox container. When null, uses the theme's small border radius (typically 4 logical pixels). |
