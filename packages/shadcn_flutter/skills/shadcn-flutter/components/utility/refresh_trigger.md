# RefreshTrigger

A widget that provides pull-to-refresh functionality.

## Usage

### Refresh Trigger Example
```dart
import 'dart:ui';

import 'package:docs/pages/docs/components/refresh_trigger/refresh_trigger_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class RefreshTriggerExample extends StatelessWidget {
  const RefreshTriggerExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'refresh_trigger',
      description: 'A trigger that can be used to refresh a list.',
      displayName: 'Refresh Trigger',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/refresh_trigger/refresh_trigger_example_1.dart',
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
            }),
            child: OutlinedContainer(
              child: const RefreshTriggerExample1().sized(
                height: 400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

```

### Refresh Trigger Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RefreshTriggerExample1 extends StatefulWidget {
  const RefreshTriggerExample1({super.key});

  @override
  State<RefreshTriggerExample1> createState() => _RefreshTriggerExample1State();
}

class _RefreshTriggerExample1State extends State<RefreshTriggerExample1> {
  // A GlobalKey lets us access the RefreshTrigger's state so we can
  // trigger a programmatic refresh (via a button) in addition to pull-to-refresh.
  final GlobalKey<RefreshTriggerState> _refreshTriggerKey =
      GlobalKey<RefreshTriggerState>();
  @override
  Widget build(BuildContext context) {
    return RefreshTrigger(
      key: _refreshTriggerKey,
      // Called when the user pulls down far enough or when we call .refresh().
      // Here we simulate a network call with a short delay.
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: SingleChildScrollView(
        child: Container(
          // Give the scroll view some height so pull-to-refresh can be triggered.
          height: 800,
          padding: const EdgeInsets.only(top: 32),
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              const Text('Pull Me'),
              const Gap(16),
              PrimaryButton(
                onPressed: () {
                  // Programmatically trigger the refresh without a pull gesture.
                  _refreshTriggerKey.currentState!.refresh();
                },
                child: const Text('Refresh'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

```

### Refresh Trigger Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class RefreshTriggerTile extends StatelessWidget implements IComponentPage {
  const RefreshTriggerTile({super.key});

  @override
  String get title => 'Refresh Trigger';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'refresh_trigger',
      title: 'Refresh Trigger',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 250,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(color: theme.colorScheme.border),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              // Refresh indicator area
              Container(
                height: 60,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Transform.rotate(
                        angle: 0.5,
                        child: Icon(
                          Icons.refresh,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Pull to refresh',
                        style: TextStyle(
                          fontSize: 12,
                          color: theme.colorScheme.mutedForeground,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Content area
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text('Content List:').bold(),
                      const Gap(12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.muted.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:
                            const Text('Item 1', textAlign: TextAlign.center),
                      ),
                      const Gap(4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.muted.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:
                            const Text('Item 2', textAlign: TextAlign.center),
                      ),
                      const Gap(4),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.muted.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child:
                            const Text('Item 3', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                ),
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
| `minExtent` | `double?` | Minimum pull extent required to trigger refresh.  Pull distance must exceed this value to activate the refresh callback. If null, uses theme or default value. |
| `maxExtent` | `double?` | Maximum pull extent allowed.  Limits how far the user can pull to prevent excessive stretching. If null, uses theme or default value. |
| `onRefresh` | `FutureVoidCallback?` | Callback invoked when refresh is triggered.  Should return a Future that completes when the refresh operation finishes. While the Future is pending, the refresh indicator shows loading state. |
| `child` | `Widget` | The scrollable child widget being refreshed. |
| `direction` | `Axis` | Direction of the pull gesture.  Defaults to [Axis.vertical] for standard top-down pull-to-refresh. |
| `reverse` | `bool` | Whether to reverse the pull direction.  If true, pull gesture is inverted (e.g., pull down instead of up). |
| `indicatorBuilder` | `RefreshIndicatorBuilder?` | Custom builder for the refresh indicator.  If null, uses [defaultIndicatorBuilder]. |
| `curve` | `Curve?` | Animation curve for extent changes.  Controls how the pull extent animates during interactions. |
| `completeDuration` | `Duration?` | Duration for the completion animation.  Time to display the completion state before hiding the indicator. |
