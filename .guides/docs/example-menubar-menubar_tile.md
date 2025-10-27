---
title: "Example: components/menubar/menubar_tile.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarTile extends StatelessWidget implements IComponentPage {
  const MenubarTile({super.key});

  @override
  String get title => 'Menubar';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      title: 'Menubar',
      name: 'menubar',
      scale: 1,
      example: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedContainer(
              borderColor: theme.colorScheme.border,
              backgroundColor: theme.colorScheme.background,
              borderRadius: theme.borderRadiusMd,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('File'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar().copyWith(
                          decoration: (context, states, value) {
                            return (value as BoxDecoration).copyWith(
                              color: theme.colorScheme.accent,
                              borderRadius:
                                  BorderRadius.circular(theme.radiusSm),
                            );
                          },
                        ),
                        child: const Text('Edit'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('View'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('Help'),
```
