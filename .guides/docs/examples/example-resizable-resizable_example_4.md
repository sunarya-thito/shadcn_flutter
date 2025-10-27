---
title: "Example: components/resizable/resizable_example_4.dart"
description: "Component example"
---

Source preview
```dart
import 'package:docs/pages/docs/components/carousel_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ResizableExample4 extends StatefulWidget {
  const ResizableExample4({super.key});

  @override
  State<ResizableExample4> createState() => _ResizableExample4State();
}

class _ResizableExample4State extends State<ResizableExample4> {
  // Controlled panes: each pane has its own controller so we can read/write size
  // and call helper methods (tryExpandSize, tryCollapse, etc.).
  final AbsoluteResizablePaneController controller1 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller2 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller3 =
      AbsoluteResizablePaneController(120);
  final AbsoluteResizablePaneController controller4 =
      AbsoluteResizablePaneController(80);
  final AbsoluteResizablePaneController controller5 =
      AbsoluteResizablePaneController(80);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OutlinedContainer(
          clipBehavior: Clip.antiAlias,
          child: ResizablePanel.horizontal(
            children: [
              ResizablePane.controlled(
                // Bind pane size to controller1 (initial 80px).
                controller: controller1,
                child: const NumberedContainer(
                  index: 0,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller2,
                child: const NumberedContainer(
                  index: 1,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller3,
                // Optional constraint: this pane cannot grow beyond 200px.
                maxSize: 200,
                child: const NumberedContainer(
                  index: 2,
                  height: 200,
                  fill: false,
                ),
              ),
              ResizablePane.controlled(
                controller: controller4,
```
