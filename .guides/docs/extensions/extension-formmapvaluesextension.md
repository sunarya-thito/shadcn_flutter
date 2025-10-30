---
title: "Extension: FormMapValuesExtension"
description: "Extension methods for [FormMapValues]."
---

```dart
/// Extension methods for [FormMapValues].
extension FormMapValuesExtension on FormMapValues {
  /// Retrieves a typed value for a specific form key.
  ///
  /// Parameters:
  /// - [key] (`FormKey<T>`, required): The form key to look up.
  ///
  /// Returns: `T?` — the value if found and correctly typed, null otherwise.
  T? getValue<T>(FormKey<T> key);
}
```
