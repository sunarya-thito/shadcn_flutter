---
title: "Class: InputPart"
description: "Reference for InputPart"
---

```dart
abstract class InputPart implements FormattedValuePart {
  factory InputPart.static(String text);
  factory InputPart.editable({required int length, bool obscureText, List<TextInputFormatter> inputFormatters, Widget? placeholder, required double width});
  factory InputPart.widget(Widget widget);
  const InputPart();
  Widget build(BuildContext context, FormattedInputData data);
  Object? get partKey;
  bool get canHaveValue;
  String? get value;
  InputPart get part;
  FormattedValuePart withValue(String value);
}
```
