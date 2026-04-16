# ToggleController

A controller for managing toggle state in toggle buttons and switches.

## Usage

### Button Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'button/button_example_1.dart';
import 'button/button_example_10.dart';
import 'button/button_example_11.dart';
import 'button/button_example_12.dart';
import 'button/button_example_13.dart';
import 'button/button_example_14.dart';
import 'button/button_example_15.dart';
import 'button/button_example_16.dart';
import 'button/button_example_17.dart';
import 'button/button_example_2.dart';
import 'button/button_example_3.dart';
import 'button/button_example_4.dart';
import 'button/button_example_5.dart';
import 'button/button_example_6.dart';
import 'button/button_example_7.dart';
import 'button/button_example_8.dart';
import 'button/button_example_9.dart';

class ButtonExample extends StatelessWidget {
  const ButtonExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'button',
      description:
          'Buttons allow users to take actions, and make choices, with a single tap.',
      displayName: 'Button',
      children: [
        WidgetUsageExample(
          title: 'Primary Button Example',
          path: 'lib/pages/docs/components/button/button_example_1.dart',
          child: ButtonExample1(),
        ),
        WidgetUsageExample(
          title: 'Secondary Button Example',
          path: 'lib/pages/docs/components/button/button_example_2.dart',
          child: ButtonExample2(),
        ),
        WidgetUsageExample(
          title: 'Outline Button Example',
          path: 'lib/pages/docs/components/button/button_example_3.dart',
          child: ButtonExample3(),
        ),
        WidgetUsageExample(
          title: 'Ghost Button Example',
          path: 'lib/pages/docs/components/button/button_example_4.dart',
          child: ButtonExample4(),
        ),
        WidgetUsageExample(
          title: 'Destructive Button Example',
          path: 'lib/pages/docs/components/button/button_example_5.dart',
          child: ButtonExample5(),
        ),
        WidgetUsageExample(
          title: 'Link Button Example',
          path: 'lib/pages/docs/components/button/button_example_6.dart',
          child: ButtonExample6(),
        ),
        WidgetUsageExample(
          title: 'Text Button Example',
          path: 'lib/pages/docs/components/button/button_example_12.dart',
          child: ButtonExample12(),
        ),
        WidgetUsageExample(
          title: 'Disabled Button Example',
          path: 'lib/pages/docs/components/button/button_example_7.dart',
          child: ButtonExample7(),
        ),
        WidgetUsageExample(
          title: 'Icon Button Example',
          path: 'lib/pages/docs/components/button/button_example_8.dart',
          child: ButtonExample8(),
        ),
        WidgetUsageExample(
          title: 'Icon Button with Label Example',
          path: 'lib/pages/docs/components/button/button_example_9.dart',
          child: ButtonExample9(),
        ),
        WidgetUsageExample(
          title: 'Button Size Example',
          path: 'lib/pages/docs/components/button/button_example_10.dart',
          child: ButtonExample10(),
        ),
        WidgetUsageExample(
          title: 'Button Density Example',
          path: 'lib/pages/docs/components/button/button_example_11.dart',
          child: ButtonExample11(),
        ),
        WidgetUsageExample(
          title: 'Button Shape Example',
          path: 'lib/pages/docs/components/button/button_example_13.dart',
          child: ButtonExample13(),
        ),
        WidgetUsageExample(
          title: 'Button Group Example',
          path: 'lib/pages/docs/components/button/button_example_14.dart',
          child: ButtonExample14(),
        ),
        WidgetUsageExample(
          title: 'Button Stated Example',
          path: 'lib/pages/docs/components/button/button_example_15.dart',
          child: ButtonExample15(),
        ),
        WidgetUsageExample(
          title: 'Card Button Example',
          path: 'lib/pages/docs/components/button/button_example_16.dart',
          child: ButtonExample16(),
        ),
        WidgetUsageExample(
          title: 'Custom Button Example',
          path: 'lib/pages/docs/components/button/button_example_17.dart',
          child: ButtonExample17(),
        )
      ],
    );
  }
}

```

### Button Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Primary button.
///
/// Use for the main call-to-action on a screen.
class ButtonExample1 extends StatelessWidget {
  const ButtonExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {},
      child: const Text('Primary'),
    );
  }
}

```

### Button Example 10
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample10 extends StatelessWidget {
  const ButtonExample10({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          size: ButtonSize.xSmall,
          onPressed: () {},
          child: const Text('Extra Small'),
        ),
        PrimaryButton(
          onPressed: () {},
          size: ButtonSize.small,
          child: const Text('Small'),
        ),
        PrimaryButton(
          size: ButtonSize.normal,
          onPressed: () {},
          child: const Text('Normal'),
        ),
        PrimaryButton(
          size: ButtonSize.large,
          onPressed: () {},
          child: const Text('Large'),
        ),
        PrimaryButton(
          size: ButtonSize.xLarge,
          onPressed: () {},
          child: const Text('Extra Large'),
        ),
      ],
    );
  }
}

```

### Button Example 11
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample11 extends StatelessWidget {
  const ButtonExample11({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.compact,
          child: const Text('Compact'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.dense,
          child: const Text('Dense'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.normal,
          child: const Text('Normal'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.comfortable,
          child: const Text('Comfortable'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.icon,
          child: const Text('Icon'),
        ),
        PrimaryButton(
          onPressed: () {},
          density: ButtonDensity.iconComfortable,
          child: const Text('Icon Comfortable'),
        ),
      ],
    );
  }
}

```

### Button Example 12
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample12 extends StatelessWidget {
  const ButtonExample12({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: const Text('Text Button'),
    );
  }
}

```

### Button Example 13
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample13 extends StatelessWidget {
  const ButtonExample13({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      alignment: WrapAlignment.center,
      runAlignment: WrapAlignment.center,
      children: [
        PrimaryButton(
          onPressed: () {},
          shape: ButtonShape.circle,
          child: const Icon(Icons.add),
        ),
        PrimaryButton(
          onPressed: () {},
          shape: ButtonShape.rectangle,
          child: const Text('Rectangle'),
        ),
      ],
    );
  }
}

```

### Button Example 14
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample14 extends StatelessWidget {
  const ButtonExample14({super.key});

  @override
  Widget build(BuildContext context) {
    return ButtonGroup(
      children: [
        PrimaryButton(
          child: const Text('Primary'),
          onPressed: () {},
        ),
        SecondaryButton(
          child: const Text('Secondary'),
          onPressed: () {},
        ),
        DestructiveButton(
          child: const Text('Destructive'),
          onPressed: () {},
        ),
        OutlineButton(
          child: const Text('Outlined'),
          onPressed: () {},
        ),
        GhostButton(
          child: const Text('Ghost'),
          onPressed: () {},
        ),
        IconButton.primary(
          icon: const Icon(Icons.add),
          onPressed: () {},
        ),
      ],
    );
  }
}

```

### Button Example 15
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample15 extends StatelessWidget {
  const ButtonExample15({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      leading: const StatedWidget.map(
        states: {
          'disabled': Icon(Icons.close),
          {WidgetState.hovered, WidgetState.focused}:
              Icon(Icons.add_a_photo_rounded),
          WidgetState.hovered: Icon(Icons.add_a_photo),
        },
        child: Icon(Icons.add_a_photo_outlined),
      ),
      onPressed: () {},
      child: const StatedWidget(
        focused: Text('Focused'),
        hovered: Text('Hovered'),
        pressed: Text('Pressed'),
        child: Text('Normal'),
      ),
    );
  }
}

```

### Button Example 16
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample16 extends StatelessWidget {
  const ButtonExample16({super.key});

  @override
  Widget build(BuildContext context) {
    return CardButton(
      onPressed: () {},
      child: const Basic(
        title: Text('Project #1'),
        subtitle: Text('Project description'),
        content:
            Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit.'),
      ),
    );
  }
}

```

### Button Example 17
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample17 extends StatelessWidget {
  const ButtonExample17({super.key});

  @override
  Widget build(BuildContext context) {
    return Button(
      style: const ButtonStyle.primary()
          .withBackgroundColor(color: Colors.red, hoverColor: Colors.purple)
          .withForegroundColor(color: Colors.white)
          .withBorderRadius(hoverBorderRadius: BorderRadius.circular(16)),
      onPressed: () {},
      leading: const Icon(Icons.sunny),
      child: const Text('Custom Button'),
    );
  }
}

```

### Button Example 2
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Secondary button.
///
/// A lower-emphasis action compared to [PrimaryButton].
class ButtonExample2 extends StatelessWidget {
  const ButtonExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return SecondaryButton(
      onPressed: () {},
      child: const Text('Secondary'),
    );
  }
}

```

### Button Example 3
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Outline button.
///
/// Uses an outlined border for a minimal visual weight.
class ButtonExample3 extends StatelessWidget {
  const ButtonExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {},
      child: const Text('Outlined'),
    );
  }
}

```

### Button Example 4
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Ghost button.
///
/// Very subtle styling for least-emphasis or inline actions.
class ButtonExample4 extends StatelessWidget {
  const ButtonExample4({super.key});

  @override
  Widget build(BuildContext context) {
    return GhostButton(
      onPressed: () {},
      child: const Text('Ghost'),
    );
  }
}

```

### Button Example 5
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Destructive button.
///
/// Use to represent dangerous or irreversible actions (e.g., delete).
class ButtonExample5 extends StatelessWidget {
  const ButtonExample5({super.key});

  @override
  Widget build(BuildContext context) {
    return DestructiveButton(
      onPressed: () {},
      child: const Text('Destructive'),
    );
  }
}

```

### Button Example 6
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample6 extends StatelessWidget {
  const ButtonExample6({super.key});

  @override
  Widget build(BuildContext context) {
    return LinkButton(
      onPressed: () {},
      child: const Text('Link'),
    );
  }
}

```

### Button Example 7
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample7 extends StatelessWidget {
  const ButtonExample7({super.key});

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          child: Text('Disabled'),
        ),
        SecondaryButton(
          child: Text('Disabled'),
        ),
        OutlineButton(
          child: Text('Disabled'),
        ),
        GhostButton(
          child: Text('Disabled'),
        ),
        TextButton(
          child: Text('Disabled'),
        ),
        DestructiveButton(
          child: Text('Disabled'),
        ),
      ],
    );
  }
}

```

### Button Example 8
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample8 extends StatelessWidget {
  const ButtonExample8({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: [
        IconButton.primary(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.secondary(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.outline(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.ghost(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.text(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
        IconButton.destructive(
          onPressed: () {},
          density: ButtonDensity.icon,
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}

```

### Button Example 9
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample9 extends StatelessWidget {
  const ButtonExample9({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        SecondaryButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        OutlineButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        GhostButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        TextButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
        DestructiveButton(
          onPressed: () {},
          trailing: const Icon(Icons.add),
          child: const Text('Add'),
        ),
      ],
    );
  }
}

```

### Button Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ButtonTile extends StatelessWidget implements IComponentPage {
  const ButtonTile({super.key});

  @override
  String get title => 'Button';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'button',
      title: 'Button',
      scale: 1.5,
      example: SizedBox(
        width: 250,
        child: Card(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              PrimaryButton(
                onPressed: () {},
                child: const Text('Primary'),
              ),
              SecondaryButton(
                onPressed: () {},
                child: const Text('Secondary'),
              ),
              OutlineButton(
                onPressed: () {},
                child: const Text('Outline'),
              ),
              GhostButton(
                onPressed: () {},
                child: const Text('Ghost'),
              ),
              DestructiveButton(
                child: const Text('Destructive'),
                onPressed: () {},
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

