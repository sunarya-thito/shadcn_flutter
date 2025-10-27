---
title: "Example: components/sortable/sortable_example_6.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class SortableExample6 extends StatefulWidget {
  const SortableExample6({super.key});

  @override
  State<SortableExample6> createState() => _SortableExample6State();
}

class _SortableExample6State extends State<SortableExample6> {
  late List<SortableData<String>> names;

  @override
  void initState() {
    super.initState();
    _reset();
  }

  void _reset() {
    names = [
      const SortableData('James'),
      const SortableData('John'),
      const SortableData('Robert'),
      const SortableData('Michael'),
      const SortableData('William'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SortableLayer(
      child: Builder(
          // this builder is needed to access the context of the SortableLayer
          builder: (context) {
        return SortableDropFallback<int>(
          onAccept: (value) {
            setState(() {
              names.add(names.removeAt(value.data));
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PrimaryButton(
                onPressed: () {
                  setState(() {
                    _reset();
                  });
                },
                child: const Text('Reset'),
              ),
              for (int i = 0; i < names.length; i++)
                Sortable<String>(
                  key: ValueKey(i),
                  data: names[i],
                  // we only want user to drag the item from the handle,
                  // so we disable the drag on the item itself
                  enabled: false,
                  onAcceptTop: (value) {
                    setState(() {
```
