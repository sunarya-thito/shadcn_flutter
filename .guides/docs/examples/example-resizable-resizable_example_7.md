---
title: "Example: components/resizable/resizable_example_7.dart"
description: "Component example"
---

Source preview
```dart
import 'dart:math';

import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample7 extends StatefulWidget {
  const ResizableExample7({super.key});

  @override
  State<ResizableExample7> createState() => _ResizableExample7State();
}

class _ResizableExample7State extends State<ResizableExample7> {
  // Dynamic list of colors to render each resizable pane.
  final List<Color> _items = List.generate(2, (index) => _generateColor());

  static Color _generateColor() {
    Random random = Random();
    return HSVColor.fromAHSV(
      1.0,
      random.nextInt(360).toDouble(),
      0.8,
      0.8,
    ).toColor();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 12,
        children: [
          ResizablePanel.vertical(
            children: [
              for (int i = 0; i < _items.length; i++)
                ResizablePane(
                  // Use a ValueKey derived from the color so Flutter can track panes across insert/remove.
                  key: ValueKey(_items[i].toARGB32()),
                  initialSize: 200,
                  minSize: 100,
                  child: Container(
                    color: _items[i],
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextButton(
                            child: const Text('Insert Before'),
                            onPressed: () {
                              setState(() {
                                // Insert a new pane before the current one.
                                _items.insert(i, _generateColor());
                              });
                            },
                          ),
                          TextButton(
                            child: const Text('Remove'),
                            onPressed: () {
                              setState(() {
```
