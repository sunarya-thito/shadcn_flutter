# Steps

Vertical step progression widget with numbered indicators and connectors.

## Usage

### Steps Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/steps/steps_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepsExample extends StatelessWidget {
  const StepsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'steps',
      description: 'A series of steps for progress.',
      displayName: 'Steps',
      children: [
        WidgetUsageExample(
          title: 'Steps Example',
          path: 'lib/pages/docs/components/steps/steps_example_1.dart',
          child: StepsExample1(),
        ),
      ],
    );
  }
}

```

### Steps Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepsExample1 extends StatelessWidget {
  const StepsExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Steps(
      // Static steps list with titles and supporting content lines.
      children: [
        StepItem(
          title: Text('Create a project'),
          content: [
            Text('Create a new project in the project manager.'),
            Text('Add the required files to the project.'),
          ],
        ),
        StepItem(
          title: Text('Add dependencies'),
          content: [
            Text('Add the required dependencies to the project.'),
          ],
        ),
        StepItem(
          title: Text('Run the project'),
          content: [
            Text('Run the project in the project manager.'),
          ],
        ),
      ],
    );
  }
}

```

### Steps Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepsTile extends StatelessWidget implements IComponentPage {
  const StepsTile({super.key});

  @override
  String get title => 'Steps';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'steps',
      title: 'Steps',
      example: Card(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Steps(children: [
          StepItem(
            title: Text('Create a project'),
            content: [
              Text('Create a new flutter project'),
            ],
          ),
          StepItem(
            title: Text('Add dependencies'),
            content: [
              Text('Add dependencies to pubspec.yaml'),
            ],
          ),
          StepItem(
            title: Text('Run the project'),
            content: [
              Text('Run the project using flutter run'),
            ],
          ),
        ]),
      ),
    );
  }
}

```



## Features
- **Numbered indicators**: Circular indicators with automatic step numbering
- **Connector lines**: Visual lines connecting consecutive steps
- **Flexible content**: Each step can contain any widget content
- **Responsive theming**: Customizable indicator size, spacing, and colors
- **Intrinsic sizing**: Automatically adjusts to content height

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `children` | `List<Widget>` | List of widgets representing each step in the sequence.  Each widget will be displayed with an automatically numbered circular indicator showing its position in the sequence. |
