---
title: "Class: InputOTPChild"
description: "Abstract base class for OTP input child elements."
---

```dart
/// Abstract base class for OTP input child elements.
///
/// Defines the interface for children that can be placed within an [InputOTP]
/// widget, including actual input fields, separators, and spacers.
/// Subclasses implement the [build] method to render their content.
///
/// Common factories:
/// - [separator]: Creates a visual separator between OTP groups.
/// - [space]: Creates spacing between OTP input fields.
/// - [empty]: Creates an empty placeholder.
/// - [InputOTPChild.input]: Creates a configurable character input.
/// - [InputOTPChild.character]: Creates a character input with preset filters.
///
/// Example:
/// ```dart
/// InputOTP(
///   children: [
///     InputOTPChild.input(predicate: (cp) => cp >= 48 && cp <= 57),
///     InputOTPChild.space,
///     InputOTPChild.input(),
///   ],
/// )
/// ```
abstract class InputOTPChild {
  /// A visual separator between OTP groups (e.g., a dash or line).
  static InputOTPChild get separator;
  /// Spacing between OTP input fields.
  static InputOTPChild get space;
  /// An empty placeholder that takes no space.
  static InputOTPChild get empty;
  /// Creates a customizable character input field.
  ///
  /// Parameters:
  /// - [predicate] (`CodepointPredicate?`, optional): Function to validate codepoints.
  /// - [transform] (`CodepointUnaryOperator?`, optional): Function to transform codepoints.
  /// - [obscured] (`bool`, default: `false`): Whether to obscure the input.
  /// - [readOnly] (`bool`, default: `false`): Whether the input is read-only.
  /// - [keyboardType] (`TextInputType?`, optional): Keyboard type for input.
  ///
  /// Returns: A [CharacterInputOTPChild] configured with the specified options.
  factory InputOTPChild.input({CodepointPredicate? predicate, CodepointUnaryOperator? transform, bool obscured = false, bool readOnly = false, TextInputType? keyboardType});
  /// Creates a character input with alphabet and digit filtering.
  ///
  /// Parameters:
  /// - [allowLowercaseAlphabet] (`bool`, default: `false`): Allow lowercase letters.
  /// - [allowUppercaseAlphabet] (`bool`, default: `false`): Allow uppercase letters.
  /// - [allowDigit] (`bool`, default: `false`): Allow numeric digits.
  /// - [obscured] (`bool`, default: `false`): Whether to obscure the input.
  /// - [onlyUppercaseAlphabet] (`bool`, default: `false`): Convert to uppercase only.
  /// - [onlyLowercaseAlphabet] (`bool`, default: `false`): Convert to lowercase only.
  /// - [readOnly] (`bool`, default: `false`): Whether the input is read-only.
  /// - [keyboardType] (`TextInputType?`, optional): Keyboard type for input.
  ///
  /// Returns: A [CharacterInputOTPChild] configured for alphabet/digit input.
  ///
  /// Example:
  /// ```dart
  /// InputOTPChild.character(
  ///   allowDigit: true,
  ///   allowUppercaseAlphabet: true,
  /// )
  /// ```
  factory InputOTPChild.character({bool allowLowercaseAlphabet = false, bool allowUppercaseAlphabet = false, bool allowDigit = false, bool obscured = false, bool onlyUppercaseAlphabet = false, bool onlyLowercaseAlphabet = false, bool readOnly = false, TextInputType? keyboardType});
  /// Creates an [InputOTPChild].
  const InputOTPChild();
  /// Builds the widget for this OTP child.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): The build context.
  /// - [data] (`InputOTPChildData`, required): Data for building the child.
  ///
  /// Returns: The widget representing this OTP child.
  Widget build(BuildContext context, InputOTPChildData data);
  /// Whether this child can hold a value (i.e., is an input field).
  bool get hasValue;
}
```
