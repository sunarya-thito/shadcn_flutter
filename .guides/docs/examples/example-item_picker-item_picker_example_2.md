---
title: "Example: components/item_picker/item_picker_example_2.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ItemPickerExample2 extends StatelessWidget {
  const ItemPickerExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        // Dialog variant of the item picker for a more prominent selection flow.
        showItemPickerDialog<int>(
          context,
          title: const Text('Pick a number'),
          items: ItemBuilder(
            itemBuilder: (index) {
              return index;
            },
          ),
          builder: (context, item) {
            return ItemPickerOption(
                value: item, child: Text(item.toString()).large);
          },
        ).then(
          (value) {
            if (value != null && context.mounted) {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return SurfaceCard(
                    child: Text('You picked $value!'),
                  );
                },
              );
            } else if (context.mounted) {
              showToast(
                context: context,
                builder: (context, overlay) {
                  return const SurfaceCard(
                    child: Text('You picked nothing!'),
                  );
                },
              );
            }
          },
        );
      },
      child: const Text('Show Item Picker'),
    );
  }
}

```
