---
title: "Example: components/swiper/swiper_tile.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwiperTile extends StatelessWidget implements IComponentPage {
  const SwiperTile({super.key});

  @override
  String get title => 'Swiper';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'swiper',
      title: 'Swiper',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 300,
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Stack(
            children: [
              // Swiper content
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    'Slide 1',
                    style: TextStyle(
                      color: theme.colorScheme.primaryForeground,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Navigation arrows
              Positioned(
                left: 8,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.background.withOpacity(0.8),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chevron_left, size: 20),
                  ),
                ),
              ),
              Positioned(
```
