---
title: "Example: components/table/table_example_3.dart"
description: "Component example"
---

Source preview
```dart
import 'dart:ui';

import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a scrollable Table hooked to ScrollableClient with frozen
// rows/columns and diagonal drag panning.

class TableExample3 extends StatefulWidget {
  const TableExample3({super.key});

  @override
  State<TableExample3> createState() => _TableExample3State();
}

class _TableExample3State extends State<TableExample3> {
  // Builds a bordered cell; amounts can be right-aligned by passing true.
  TableCell buildCell(String text, [bool alignRight = false]) {
    final theme = Theme.of(context);
    return TableCell(
      theme: TableCellTheme(
        border: WidgetStatePropertyAll(
          Border.all(
            color: theme.colorScheme.border,
            strokeAlign: BorderSide.strokeAlignCenter,
          ),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        alignment: alignRight ? Alignment.topRight : null,
        child: Text(text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(
        dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        },
        // Disable overscroll glow and bouncing to keep the table steady.
        overscroll: false,
      ),
      child: SizedBox(
        height: 400,
        child: OutlinedContainer(
          child: ScrollableClient(
              // Allow simultaneous horizontal and vertical drags for panning.
              diagonalDragBehavior: DiagonalDragBehavior.free,
              builder: (context, offset, viewportSize, child) {
                return Table(
                  // Hook the table's scroll offsets to the ScrollableClient.
                  horizontalOffset: offset.dx,
                  verticalOffset: offset.dy,
                  // The viewport tells the table how much content area is visible.
                  viewportSize: viewportSize,
                  // Fixed sizes for consistent cell dimensions.
```
