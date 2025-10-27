---
title: "Example: components/resizable/resizable_example_6.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample6 extends StatefulWidget {
  const ResizableExample6({super.key});

  @override
  State<ResizableExample6> createState() => _ResizableExample6State();
}

class _ResizableExample6State extends State<ResizableExample6> {
  @override
  Widget build(BuildContext context) {
    return const OutlinedContainer(
      clipBehavior: Clip.antiAlias,
      // Demonstrates nesting panels: horizontal root with vertical and horizontal children.
      child: ResizablePanel.horizontal(
        children: [
          ResizablePane(
            initialSize: 100,
            minSize: 40,
            child: NumberedContainer(
              index: 0,
              height: 200,
              fill: false,
            ),
          ),
          ResizablePane(
            minSize: 100,
            initialSize: 300,
            // Middle pane is its own vertical resizable group.
            child: ResizablePanel.vertical(
              children: [
                ResizablePane(
                  initialSize: 80,
                  minSize: 40,
                  child: NumberedContainer(
                    index: 1,
                    fill: false,
                  ),
                ),
                ResizablePane(
                  minSize: 40,
                  initialSize: 120,
                  // This pane contains a horizontal panel using flexible panes below.
                  child: ResizablePanel.horizontal(
                    children: [
                      // Flex panes share remaining space proportionally.
                      ResizablePane.flex(
                        child: NumberedContainer(
                          index: 2,
                          fill: false,
                        ),
                      ),
                      ResizablePane.flex(
                        child: NumberedContainer(
                          index: 3,
                          fill: false,
                        ),
                      ),
```
