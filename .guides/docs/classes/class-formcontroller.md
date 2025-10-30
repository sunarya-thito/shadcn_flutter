---
title: "Class: FormController"
description: "Controller for managing form state, validation, and submission."
---

```dart
/// Controller for managing form state, validation, and submission.
///
/// The FormController coordinates all form field interactions, maintaining
/// a centralized registry of field values and validation states. It provides
/// programmatic access to form data collection, validation triggering, and
/// submission handling.
///
/// The controller automatically manages the lifecycle of form fields as they
/// register and unregister, tracking their values and validation results.
/// It supports both synchronous and asynchronous validation, cross-field
/// validation dependencies, and comprehensive error state management.
///
/// Example:
/// ```dart
/// final controller = FormController();
///
/// // Listen to form state changes
/// controller.addListener(() {
///   print('Form validity: ${controller.isValid}');
///   print('Form values: ${controller.values}');
/// });
///
/// // Submit the form
/// await controller.submit();
///
/// // Access specific field values
/// final emailValue = controller.getValue(emailKey);
/// ```
class FormController extends ChangeNotifier {
  /// A map of all current form field values keyed by their [FormKey].
  ///
  /// This getter provides access to the current state of all registered form
  /// fields. The map is rebuilt on each access to reflect the latest values
  /// from all active form fields.
  ///
  /// Returns a `Map<FormKey, Object?>` where each key corresponds to a form field
  /// and each value is the current value of that field.
  Map<FormKey, Object?> get values;
  void dispose();
  /// A map of all current validation results keyed by their [FormKey].
  ///
  /// This getter provides access to the validation state of all registered
  /// form fields. Values can be either synchronous ValidationResult objects
  /// or `Future<ValidationResult?>` for asynchronous validation.
  ///
  /// Returns a `Map<FormKey, FutureOr<ValidationResult?>>` representing the
  /// current validation state of all form fields.
  Map<FormKey, FutureOr<ValidationResult?>> get validities;
  /// A map of all current validation errors keyed by their [FormKey].
  ///
  /// This getter filters the validation results to only include fields with
  /// validation errors. For asynchronous validations that are still pending,
  /// a [WaitingResult] is included to indicate the validation is in progress.
  ///
  /// Returns a `Map<FormKey, ValidationResult>` containing only fields with errors.
  Map<FormKey, ValidationResult> get errors;
  /// Retrieves the validation result for a specific form field.
  ///
  /// This method returns the current validation state for the specified form key,
  /// which can be either a synchronous ValidationResult or a Future for asynchronous
  /// validation. Returns null if no validation result exists for the key.
  ///
  /// Parameters:
  /// - [key] (FormKey): The form key to get validation result for
  ///
  /// Returns the validation result or null if none exists.
  FutureOr<ValidationResult?>? getError(FormKey key);
  /// Retrieves the synchronous validation result for a specific form field.
  ///
  /// This method returns the current validation state for the specified form key,
  /// converting asynchronous validations to [WaitingResult] objects. This provides
  /// a synchronous interface for accessing validation states.
  ///
  /// Parameters:
  /// - [key] (FormKey): The form key to get validation result for
  ///
  /// Returns the synchronous validation result or null if valid.
  ValidationResult? getSyncError(FormKey key);
  T? getValue<T>(FormKey<T> key);
  bool hasValue(FormKey key);
  void revalidate(BuildContext context, FormValidationMode state);
  FutureOr<ValidationResult?> attach(BuildContext context, FormFieldHandle handle, Object? value, Validator? validator, [bool forceRevalidate = false]);
}
```
