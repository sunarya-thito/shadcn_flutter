---
title: "Example: components/sortable/sortable_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample2 extends StatefulWidget {
  const SortableExample2({super.key});

  @override
  State<SortableExample2> createState() => _SortableExample2State();
}

class _SortableExample2State extends State<SortableExample2> {
  List<SortableData<String>> names = [
    const SortableData('James'),
    const SortableData('John'),
    const SortableData('Robert'),
    const SortableData('Michael'),
    const SortableData('William'),
  ];

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      // With lock enabled, the drag overlay is constrained within the layer.
      lock: true,
      child: SortableDropFallback<int>(
        // Dropping outside specific edge targets appends the item to the end.
        onAccept: (value) {
          setState(() {
            names.add(names.removeAt(value.data));
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (int i = 0; i < names.length; i++)
              Sortable<String>(
                // Use a stable key for better drag/reorder behavior.
                key: ValueKey(i),
                data: names[i],
                // Swap into the target index when dropped on the top edge.
                onAcceptTop: (value) {
                  setState(() {
                    names.swapItem(value, i);
                  });
                },
                // Insert after the target when dropped on the bottom edge.
                onAcceptBottom: (value) {
                  setState(() {
                    names.swapItem(value, i + 1);
                  });
                },
                child: OutlinedContainer(
                  padding: const EdgeInsets.all(12),
                  child: Center(child: Text(names[i].data)),
                ),
              ),
          ],
        ),
      ),
    );
  }
```
