---
title: "Class: WidgetPart"
description: "Reference for WidgetPart"
---

```dart
class WidgetPart extends InputPart {
  final Widget widget;
  const WidgetPart(this.widget);
  Widget build(BuildContext context, FormattedInputData data);
  Object? get partKey;
}
```
