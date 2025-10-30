---
title: "Class: FormKey"
description: "A key that uniquely identifies a form field and its type."
---

```dart
/// A key that uniquely identifies a form field and its type.
///
/// [FormKey] extends [LocalKey] and is used throughout the form system to
/// reference specific form fields. It includes type information to ensure
/// type-safe access to form values.
///
/// Example:
/// ```dart
/// const emailKey = FormKey<String>('email');
/// const ageKey = FormKey<int>('age');
/// ```
class FormKey<T> extends LocalKey {
  /// The underlying key object.
  final Object key;
  /// Creates a [FormKey] with the specified key object.
  const FormKey(this.key);
  /// Gets the generic type parameter of this key.
  Type get type;
  /// Checks if a dynamic value is an instance of this key's type.
  bool isInstanceOf(dynamic value);
  /// Gets the value associated with this key from the form values map.
  T? getValue(FormMapValues values);
  /// Operator overload to get the value from form values (same as [getValue]).
  T? operator [](FormMapValues values);
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
