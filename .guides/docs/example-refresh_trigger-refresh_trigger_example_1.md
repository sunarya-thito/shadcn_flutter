---
title: "Example: components/refresh_trigger/refresh_trigger_example_1.dart"
description: "Component example"
---

Source preview
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
