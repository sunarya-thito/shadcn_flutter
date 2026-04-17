# Tracker

A widget that displays a tracker.

## Usage

### Tracker Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/tracker/tracker_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TrackerExample extends StatelessWidget {
  const TrackerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'tracker',
      description: 'Component for visualizing data related to monitoring',
      displayName: 'Tracker',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/tracker/tracker_example_1.dart',
          child: TrackerExample1(),
        ),
      ],
    );
  }
}

```

### Tracker Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a Tracker strip with varying levels (fine/warning/critical)
// and per-cell tooltips, similar to a heatmap timeline.

class TrackerExample1 extends StatefulWidget {
  const TrackerExample1({super.key});

  @override
  State<TrackerExample1> createState() => _TrackerExample1State();
}

class _TrackerExample1State extends State<TrackerExample1> {
  @override
  Widget build(BuildContext context) {
    // Build a simple sequence of tracker cells with different severity levels.
    List<TrackerData> data = [];
    for (int i = 0; i < 80; i++) {
      data.add(const TrackerData(
        tooltip: Text('Tracker Fine'),
        level: TrackerLevel.fine,
      ));
    }
    // Mark some indices as warnings.
    data[40] = data[35] = const TrackerData(
      tooltip: Text('Tracker Warning'),
      level: TrackerLevel.warning,
    );
    // And a few as critical.
    data[60] = data[68] = data[72] = const TrackerData(
      tooltip: Text('Tracker Critical'),
      level: TrackerLevel.critical,
    );
    // Unknown levels to show a broader legend.
    for (int i = 8; i < 16; i++) {
      data[i] = const TrackerData(
        tooltip: Text('Tracker Unknown'),
        level: TrackerLevel.unknown,
      );
    }
    // Tracker renders a compact heatmap-like strip with tooltips per cell.
    return Tracker(data: data);
  }
}

```

### Tracker Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/tracker/tracker_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TrackerTile extends StatelessWidget implements IComponentPage {
  const TrackerTile({super.key});

  @override
  String get title => 'Tracker';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'tracker',
      title: 'Tracker',
      scale: 2,
      verticalOffset: 48,
      example: const TrackerExample1().sized(width: 500),
    );
  }
}

```



## Features
- **Status Visualization**: Color-coded segments based on [TrackerLevel]
- **Interactive Tooltips**: Hover-activated tooltips with custom content
- **Flexible Sizing**: Segments automatically expand to fill available width
- **Theming**: Comprehensive styling via [TrackerTheme]
- **Rounded Corners**: Configurable corner radius for modern appearance

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `data` | `List<TrackerData>` | List of data points to display as tracker segments.  Type: `List<TrackerData>`. Each data point contains a status level for visual styling and tooltip content for user interaction. The segments are displayed in the order provided, each taking equal horizontal space. |
