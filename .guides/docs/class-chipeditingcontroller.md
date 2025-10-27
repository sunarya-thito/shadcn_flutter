---
title: "Class: ChipEditingController"
description: "Reference for ChipEditingController"
---

```dart
class ChipEditingController<T> extends TextEditingController {
  factory ChipEditingController({String? text, List<T>? initialChips});
  set text(String newText);
  set value(TextEditingValue newValue);
  List<T> get chips;
  set chips(List<T> newChips);
  void removeAllChips();
  TextSpan buildTextSpan({required BuildContext context, TextStyle? style, required bool withComposing});
  String get plainText;
  String get textAtCursor;
  void insertChipAtCursor(T? Function(String chipText) chipConverter);
  void clearTextAtCursor();
  void appendChip(T chip);
  void appendChipAtCursor(T chip);
  void insertChip(T chip);
  void removeChip(T chip);
}
```
