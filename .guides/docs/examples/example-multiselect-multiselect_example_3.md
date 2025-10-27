---
title: "Example: components/multiselect/multiselect_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class MultiSelectExample3 extends StatefulWidget {
  const MultiSelectExample3({super.key});

  @override
  State<MultiSelectExample3> createState() => _MultiSelectExample3State();
}

class _MultiSelectExample3State extends State<MultiSelectExample3> {
  final Map<String, List<String>> fruits = {
    'Apple': ['Red Apple', 'Green Apple'],
    'Banana': ['Yellow Banana', 'Brown Banana'],
    'Lemon': ['Yellow Lemon', 'Green Lemon'],
    'Tomato': ['Red', 'Green', 'Yellow', 'Brown'],
  };
  Iterable<String>? selectedValues;

  Iterable<MapEntry<String, List<String>>> _filteredFruits(
      String searchQuery) sync* {
    for (final entry in fruits.entries) {
      final filteredValues = entry.value
          .where((value) => _filterName(value, searchQuery))
          .toList();
      if (filteredValues.isNotEmpty) {
        yield MapEntry(entry.key, filteredValues);
      } else if (_filterName(entry.key, searchQuery)) {
        yield entry;
      }
    }
  }

  bool _filterName(String name, String searchQuery) {
    return name.toLowerCase().contains(searchQuery);
  }

  Color _getColorByChip(String text) {
    Random random = Random(text.hashCode);
    double hue = random.nextDouble() * 360;
    return HSLColor.fromAHSL(1, hue, 0.5, 0.5).toColor();
  }

  @override
  Widget build(BuildContext context) {
    // Advanced multi-select with async loading, empty and loading builders,
    // and dynamic per-item styling.
    return MultiSelect<String>(
      itemBuilder: (context, item) {
        var color = _getColorByChip(item);
        return MultiSelectChip(
          value: item,
          style: const ButtonStyle.primary().withBackgroundColor(
            color: color,
            hoverColor: color.withLuminance(0.3),
          ),
          child: Text(item),
        );
      },
```
