---
title: "Class: FormattedInputData"
description: "Internal data structure for formatted input parts."
---

```dart
/// Internal data structure for formatted input parts.
///
/// [FormattedInputData] holds the state and configuration data needed
/// to render and manage an individual input part within a formatted input.
class FormattedInputData {
  /// The index of this part in the formatted input.
  final int partIndex;
  /// The initial value for this part.
  final String? initialValue;
  /// Whether this part is enabled for editing.
  final bool enabled;
  /// The controller managing the overall formatted input.
  final FormattedInputController? controller;
  /// The focus node for this specific part.
  final FocusNode? focusNode;
  /// All focus nodes in the formatted input.
  final List<FocusNode> focusNodes;
  /// Creates a [FormattedInputData].
  FormattedInputData({required this.partIndex, required this.initialValue, required this.enabled, required this.controller, required this.focusNode, required this.focusNodes});
  bool operator ==(Object other);
  int get hashCode;
}
```
