# StepsTheme

Theme for [Steps].

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
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `indicatorSize` | `double?` | Diameter of the step indicator circle. |
| `spacing` | `double?` | Gap between the indicator and the step content. |
| `indicatorColor` | `Color?` | Color of the indicator and connector line. |
| `connectorThickness` | `double?` | Thickness of the connector line. |
