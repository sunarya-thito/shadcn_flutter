---
title: "Class: InputPart"
description: "Abstract base class for parts of a formatted input."
---

```dart
/// Abstract base class for parts of a formatted input.
///
/// [InputPart] defines the interface for components that make up a formatted
/// input field, such as static text, editable sections, or custom widgets.
/// Each part can be rendered and may optionally hold a value.
///
/// Example parts:
/// - Static text separators (e.g., "/", "-")
/// - Editable numeric fields (e.g., month, day, year)
/// - Custom widget decorations
abstract class InputPart implements FormattedValuePart {
  /// Creates a static text part.
  factory InputPart.static(String text);
  /// Creates an editable input part.
  factory InputPart.editable({required int length, bool obscureText, List<TextInputFormatter> inputFormatters, Widget? placeholder, required double width});
  /// Creates a custom widget part.
  factory InputPart.widget(Widget widget);
  /// Creates an [InputPart].
  const InputPart();
  /// Builds the widget for this part.
  Widget build(BuildContext context, FormattedInputData data);
  /// A unique key identifying this part.
  Object? get partKey;
  /// Whether this part can hold a value.
  bool get canHaveValue;
  /// The current value of this part, or null if it doesn't hold a value.
  String? get value;
  /// Returns this part.
  InputPart get part;
  /// Creates a copy of this part with the specified value.
  FormattedValuePart withValue(String value);
}
```
