---
title: "Class: ConditionalValidator"
description: "A validator that applies conditional validation based on form state."
---

```dart
/// A validator that applies conditional validation based on form state.
///
/// [ConditionalValidator] only executes validation when a predicate condition
/// is met. This allows validation rules to depend on other form field values
/// or dynamic conditions.
///
/// Example:
/// ```dart
/// ConditionalValidator<String>(
///   (context, value, getFieldValue) async {
///     final country = await getFieldValue('country');
///     return country == 'US';
///   },
///   message: 'ZIP code required for US addresses',
///   dependencies: ['country'],
/// )
/// ```
class ConditionalValidator<T> extends Validator<T> {
  /// The predicate function that determines if validation should be applied.
  final FuturePredicate<T> predicate;
  /// The error message to display when validation fails.
  final String message;
  /// List of form field keys this validator depends on.
  final List<FormKey> dependencies;
  /// Creates a [ConditionalValidator] with the specified predicate and dependencies.
  const ConditionalValidator(this.predicate, {required this.message, this.dependencies = const []});
  FutureOr<ValidationResult?> validate(BuildContext context, T? value, FormValidationMode lifecycle);
  bool shouldRevalidate(FormKey<dynamic> source);
  void operator ==(Object other);
  int get hashCode;
}
```
