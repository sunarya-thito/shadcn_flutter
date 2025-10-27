---
title: "Class: ImageInput"
description: "Reference for ImageInput"
---

```dart
class ImageInput extends StatelessWidget {
  final List<XFile> images;
  final ValueChanged<List<XFile>> onChanged;
  final VoidCallback? onAdd;
  final bool canDrop;
  const ImageInput({super.key, required this.images, required this.onChanged, this.onAdd, this.canDrop = true});
  Widget build(BuildContext context);
}
```
