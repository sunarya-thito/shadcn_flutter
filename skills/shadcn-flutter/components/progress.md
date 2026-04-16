# ProgressTheme

Theme configuration for [Progress] components.

## Usage

### Progress Example
```dart
import 'package:docs/pages/docs/components/progress/progress_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class ProgressExample extends StatelessWidget {
  const ProgressExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'progress',
      description: 'A visual indicator of an operation\'s progress.',
      displayName: 'Progress',
      children: [
        WidgetUsageExample(
          title: 'Progress Example',
          path: 'lib/pages/docs/components/progress/progress_example_1.dart',
          child: ProgressExample1(),
        ),
      ],
    );
  }
}

```

### Progress Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ProgressExample1 extends StatefulWidget {
  const ProgressExample1({super.key});

  @override
  State<ProgressExample1> createState() => _ProgressExample1State();
}

class _ProgressExample1State extends State<ProgressExample1> {
  // Track the current progress value as a percentage (0–100).
  // This is a controlled example: UI buttons below update this state.
  double _progress = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Constrain the progress bar width so it doesn't grow to the full page width in docs.
        SizedBox(
          width: 400,
          child: Progress(
            // Clamp the provided value so the widget never receives out-of-range input.
            // Alternatively, you can ensure only 0–100 values are set in state.
            progress: _progress.clamp(0, 100),
            // The logical domain for the progress value. Values outside will be coerced by clamp above.
            min: 0,
            max: 100,
          ),
        ),
        const Gap(16),
        // Simple controls to demonstrate changing progress.
        Row(
          children: [
            DestructiveButton(
              onPressed: () {
                setState(() {
                  // Reset back to 0%.
                  _progress = 0;
                });
              },
              child: const Text('Reset'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                // Defensive check so we don't go below 0.
                if (_progress > 0) {
                  setState(() {
                    // Decrease by a fixed step.
                    _progress -= 10;
                  });
                }
              },
              child: const Text('Decrease by 10'),
            ),
            const Gap(16),
            PrimaryButton(
              onPressed: () {
                // Defensive check so we don't go above 100.
                if (_progress < 100) {
                  setState(() {
                    // Increase by a fixed step.
                    _progress += 10;
                  });
                }
              },
              child: const Text('Increase by 10'),
            ),
          ],
        )
      ],
    );
  }
}

```

### Progress Tile
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ProgressTile extends StatelessWidget implements IComponentPage {
  const ProgressTile({super.key});

  @override
  String get title => 'Progress';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Progress',
      name: 'progress',
      example: const Progress(
        progress: 0.75,
      ).sized(width: 200),
      center: true,
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
| `color` | `Color?` | The foreground color of the progress indicator.  Type: `Color?`. If null, uses the default progress color from theme. Applied to the filled portion that shows completion progress. |
| `backgroundColor` | `Color?` | The background color behind the progress indicator.  Type: `Color?`. If null, uses a semi-transparent version of the progress color. Visible in the unfilled portion of the progress track. |
| `borderRadius` | `BorderRadiusGeometry?` | The border radius of the progress indicator container.  Type: `BorderRadiusGeometry?`. If null, uses theme's small border radius. Applied to both the track and the progress fill for consistent styling. |
| `minHeight` | `double?` | The minimum height of the progress indicator.  Type: `double?`. If null, defaults to 8.0 scaled by theme scaling factor. Ensures adequate visual presence while maintaining proportional sizing. |
