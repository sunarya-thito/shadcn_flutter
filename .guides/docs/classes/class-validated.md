---
title: "Class: Validated"
description: "A widget that displays validation feedback for form entries."
---

```dart
/// A widget that displays validation feedback for form entries.
///
/// Wraps a form entry with a custom builder that receives validation results,
/// allowing you to customize the visual presentation of validation errors and
/// success states.
///
/// Example:
/// ```dart
/// Validated<String>(
///   validator: (value) => value.isEmpty ? ValidationResult.error('Required') : null,
///   builder: (context, error, child) {
///     return Column(
///       children: [
///         child!,
///         if (error != null) Text(error.message, style: TextStyle(color: Colors.red)),
///       ],
///     );
///   },
///   child: TextField(),
/// )
/// ```
class Validated<T> extends StatefulWidget {
  /// Builder function that creates the widget based on validation state.
  final ValidatedBuilder builder;
  /// The validator to apply to the form entry.
  final Validator<T> validator;
  /// Optional child widget to display.
  final Widget? child;
  /// Creates a [Validated].
  ///
  /// Parameters:
  /// - [builder] (`ValidatedBuilder`, required): Builds widget with validation feedback.
  /// - [validator] (`Validator<T>`, required): Validation logic.
  /// - [child] (`Widget?`, optional): Child widget to wrap.
  const Validated({super.key, required this.builder, required this.validator, this.child});
  State<Validated> createState();
}
```
