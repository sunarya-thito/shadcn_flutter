---
title: "Class: ChipSpan"
description: "An inline span representing a chip value inside a [ChipEditingController].   Unlike a plain [WidgetSpan], a [ChipSpan] also carries the underlying chip  [value]. This lets clipboard operations serialize the actual value instead  of the private-use placeholder codepoint that lays the chip out within the  editable text."
---

```dart
/// An inline span representing a chip value inside a [ChipEditingController].
///
/// Unlike a plain [WidgetSpan], a [ChipSpan] also carries the underlying chip
/// [value]. This lets clipboard operations serialize the actual value instead
/// of the private-use placeholder codepoint that lays the chip out within the
/// editable text.
class ChipSpan<T> extends WidgetSpan {
  /// The value represented by this chip.
  final T value;
  /// Creates a [ChipSpan] wrapping [child] and carrying [value].
  const ChipSpan({required this.value, required super.child, super.alignment = PlaceholderAlignment.middle, super.baseline, super.style});
}
```
