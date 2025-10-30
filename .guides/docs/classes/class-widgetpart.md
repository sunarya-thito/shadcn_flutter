---
title: "Class: WidgetPart"
description: "A part that displays a custom widget."
---

```dart
/// A part that displays a custom widget.
class WidgetPart extends InputPart {
  /// The widget to display.
  final Widget widget;
  /// Creates a [WidgetPart] with the specified widget.
  const WidgetPart(this.widget);
  Widget build(BuildContext context, FormattedInputData data);
  Object? get partKey;
}
```
