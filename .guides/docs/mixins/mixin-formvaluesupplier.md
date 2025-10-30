---
title: "Mixin: FormValueSupplier"
description: "Mixin that provides form value management for stateful widgets."
---

```dart
/// Mixin that provides form value management for stateful widgets.
///
/// Integrates a widget with the form system, managing value updates,
/// validation, and form state synchronization.
mixin FormValueSupplier<T, X extends StatefulWidget> on State<X> {
  /// Gets the current form value.
  T? get formValue;
  /// Sets a new form value and triggers validation.
  set formValue(T? value);
  void didChangeDependencies();
  /// Called when a form value is replaced by validation logic.
  ///
  /// Subclasses should override this to handle value replacements.
  void didReplaceFormValue(T value);
}
```
