---
title: "Class: ImageProperties"
description: "Reference for ImageProperties"
---

```dart
class ImageProperties {
  final Rect cropRect;
  final double rotation;
  final bool flipHorizontal;
  final bool flipVertical;
  const ImageProperties({this.cropRect = Rect.zero, this.rotation = 0, this.flipHorizontal = false, this.flipVertical = false});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
  ImageProperties copyWith({ValueGetter<Rect>? cropRect, ValueGetter<double>? rotation, ValueGetter<bool>? flipHorizontal, ValueGetter<bool>? flipVertical});
}
```
