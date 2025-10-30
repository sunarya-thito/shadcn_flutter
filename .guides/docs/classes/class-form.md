---
title: "Class: Form"
description: "A widget that provides form management capabilities for collecting and validating user input."
---

```dart
/// A widget that provides form management capabilities for collecting and validating user input.
///
/// The Form widget creates a container that manages multiple form fields, providing
/// centralized validation, data collection, and submission handling. It maintains
/// form state through a [FormController] and coordinates validation across all
/// participating form fields.
///
/// Form components within the widget tree automatically register themselves with
/// the nearest Form ancestor, allowing centralized management of field values,
/// validation states, and error handling. The Form provides validation lifecycle
/// management and supports both synchronous and asynchronous validation.
///
/// Example:
/// ```dart
/// final controller = FormController();
///
/// Form(
///   controller: controller,
///   onSubmit: (values) async {
///     print('Form submitted with values: $values');
///   },
///   child: Column(
///     children: [
///       TextInput(
///         key: FormKey<String>('name'),
///         label: 'Name',
///         validator: RequiredValidator(),
///       ),
///       Button(
///         onPressed: () => controller.submit(),
///         child: Text('Submit'),
///       ),
///     ],
///   ),
/// );
/// ```
class Form extends StatefulWidget {
  /// Retrieves the nearest [FormController] from the widget tree, if any.
  ///
  /// Returns the [FormController] instance from the nearest Form ancestor,
  /// or null if no Form is found in the widget tree. This method is safe
  /// to call even when no Form is present.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context to search from
  ///
  /// Returns the [FormController] if found, null otherwise.
  static FormController? maybeOf(BuildContext context);
  /// Retrieves the nearest [FormController] from the widget tree.
  ///
  /// Returns the [FormController] instance from the nearest Form ancestor.
  /// Throws an assertion error if no Form is found in the widget tree.
  /// Use [maybeOf] if the Form might not be present.
  ///
  /// Parameters:
  /// - [context] (BuildContext): The build context to search from
  ///
  /// Returns the [FormController] from the nearest Form ancestor.
  ///
  /// Throws [AssertionError] if no Form is found in the widget tree.
  static FormController of(BuildContext context);
  /// Optional controller for programmatic form management.
  ///
  /// When provided, this controller manages form state externally and allows
  /// programmatic access to form values, validation states, and submission.
  /// If null, the Form creates and manages its own internal controller.
  final FormController? controller;
  /// The widget subtree containing form fields.
  ///
  /// This child widget should contain the form fields and other UI elements
  /// that participate in the form. Form fields within this subtree automatically
  /// register with this Form instance.
  final Widget child;
  /// Callback invoked when the form is submitted.
  ///
  /// This callback receives a map of form values keyed by their [FormKey]
  /// identifiers. It is called when [FormController.submit] is invoked and
  /// all form validations pass successfully.
  ///
  /// The callback can return a Future for asynchronous submission processing.
  final FormSubmitCallback? onSubmit;
  /// Creates a [Form] widget.
  ///
  /// The [child] parameter is required and should contain the form fields
  /// and UI elements that participate in the form. The [controller] and
  /// [onSubmit] parameters are optional but commonly used for form management.
  ///
  /// Parameters:
  /// - [child] (Widget, required): The widget subtree containing form fields
  /// - [onSubmit] (FormSubmitCallback?, optional): Callback for form submission
  /// - [controller] (FormController?, optional): External form state controller
  ///
  /// Example:
  /// ```dart
  /// Form(
  ///   onSubmit: (values) => print('Submitted: $values'),
  ///   child: Column(
  ///     children: [
  ///       TextInput(key: FormKey('email'), label: 'Email'),
  ///       Button(child: Text('Submit')),
  ///     ],
  ///   ),
  /// );
  /// ```
  const Form({super.key, required this.child, this.onSubmit, this.controller});
  State<Form> createState();
}
```
