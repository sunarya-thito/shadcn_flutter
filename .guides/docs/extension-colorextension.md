---
title: "Extension: ColorExtension"
description: "Reference for extension"
---

```dart
extension ColorExtension on Color {
  Color scaleAlpha(double factor);
  Color getContrastColor([double luminanceContrast = 1]);
  Color withLuminance(double luminance);
  String toHex({bool includeHashSign = false, bool includeAlpha = true});
  HSLColor toHSL();
  HSVColor toHSV();
}
```
