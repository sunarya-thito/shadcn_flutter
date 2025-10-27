---
title: "Class: ConditionalValidator"
description: "Reference for ConditionalValidator"
---

```dart
class ConditionalValidator<T> extends Validator<T> {
  final FuturePredicate<T> predicate;
  final String message;
  final List<FormKey> dependencies;
  const ConditionalValidator(this.predicate, {required this.message, this.dependencies = const []});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool shouldRevalidate(FormKey<dynamic> source);
  void operator ==(Object other);
  int get hashCode;
}
```
