---
title: "Class: EditablePart"
description: "Reference for EditablePart"
---

```dart
class EditablePart extends InputPart {
  final int length;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final double width;
  final Widget? placeholder;
  const EditablePart({required this.length, this.obscureText = false, this.inputFormatters = const [], this.placeholder, required this.width});
  Object? get partKey;
  bool get canHaveValue;
  Widget build(BuildContext context, FormattedInputData data);
  String toString();
}
```
