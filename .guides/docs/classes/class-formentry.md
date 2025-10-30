---
title: "Class: FormEntry"
description: "A form field entry that wraps a form widget with validation."
---

```dart
/// A form field entry that wraps a form widget with validation.
///
/// [FormEntry] associates a [FormKey] with a form field widget and optional
/// validator. It integrates with the form state management system to track
/// field values and validation states.
class FormEntry<T> extends StatefulWidget {
  /// The form field widget to wrap.
  final Widget child;
  /// Optional validator function for this form field.
  ///
  /// Called when form validation is triggered. Should return `null` for valid
  /// values or a validation error message for invalid values.
  final Validator<T>? validator;
  /// Creates a form entry with a typed key.
  ///
  /// The [key] parameter must be a [FormKey<T>] to ensure type safety.
  const FormEntry({required FormKey<T> super.key, required this.child, this.validator});
  FormKey get key;
  State<FormEntry> createState();
}
```
