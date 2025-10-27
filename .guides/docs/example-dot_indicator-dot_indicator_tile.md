---
title: "Example: components/dot_indicator/dot_indicator_tile.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class DotIndicatorTile extends StatelessWidget implements IComponentPage {
  const DotIndicatorTile({super.key});

  @override
  String get title => 'Dot Indicator';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'dot_indicator',
      title: 'Dot Indicator',
      scale: 1.2,
      example: Card(
        child: Column(
          children: [
            const Text('Page Indicators:').bold(),
            const Gap(16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                ),
                const Gap(8),
```
