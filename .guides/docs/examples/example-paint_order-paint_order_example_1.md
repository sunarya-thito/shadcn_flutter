---
title: "Example: components/paint_order/paint_order_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PaintOrderExample1 extends StatelessWidget {
  const PaintOrderExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      width: 300,
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // First child (painted first, appears below)
          Transform.translate(
            offset: const Offset(20, 0),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Center(
                child: Text(
                  'Below',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
          // Second child with higher paintOrder (painted last, appears on top)
          PaintOrder(
            paintOrder: 1,
            child: Transform.translate(
              offset: const Offset(-20, 0),
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    'On Top',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

```
