---
title: "Example: components/sortable/sortable_example_5.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample5 extends StatefulWidget {
  const SortableExample5({super.key});

  @override
  State<SortableExample5> createState() => _SortableExample5State();
}

class _SortableExample5State extends State<SortableExample5> {
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
      lock: true,
      child: SortableDropFallback<int>(
        // Dropping outside edge targets appends the item to the end.
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
                key: ValueKey(i),
                data: names[i],
                // we only want user to drag the item from the handle,
                // so we disable the drag on the item itself
                enabled: false,
                onAcceptTop: (value) {
                  setState(() {
                    names.swapItem(value, i);
                  });
                },
                onAcceptBottom: (value) {
                  setState(() {
                    names.swapItem(value, i + 1);
                  });
                },
                child: OutlinedContainer(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Only this handle starts the drag; the rest of the row is inert.
                      const SortableDragHandle(child: Icon(Icons.drag_handle)),
                      const SizedBox(width: 8),
                      Expanded(child: Text(names[i].data)),
                    ],
                  ),
                ),
```
