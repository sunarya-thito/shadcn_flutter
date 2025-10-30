---
title: "Class: InputOTP"
description: "A specialized input widget for One-Time Password (OTP) and verification code entry."
---

```dart
/// A specialized input widget for One-Time Password (OTP) and verification code entry.
///
/// [InputOTP] provides a user-friendly interface for entering OTP codes, verification
/// numbers, and similar sequential input scenarios. The widget displays a series of
/// individual input fields that automatically advance focus as the user types,
/// creating an intuitive experience for multi-digit input.
///
/// Key features:
/// - Sequential character input with automatic focus advancement
/// - Customizable field layout with separators and spacing
/// - Support for various character types (digits, letters, symbols)
/// - Keyboard navigation and clipboard paste support
/// - Form integration with validation support
/// - Accessibility features for screen readers
/// - Theming and visual customization
///
/// The widget uses a flexible child system that allows mixing input fields
/// with separators, spaces, and custom widgets:
/// - Character input fields for actual OTP digits/letters
/// - Separators for visual grouping (e.g., dashes, dots)
/// - Spacing elements for layout control
/// - Custom widgets for specialized display needs
///
/// Common use cases:
/// - SMS verification codes (e.g., 6-digit codes)
/// - Two-factor authentication tokens
/// - Credit card security codes
/// - License key input
/// - PIN code entry
///
/// Example:
/// ```dart
/// InputOTP(
///   children: [
///     CharacterInputOTPChild(),
///     CharacterInputOTPChild(),
///     CharacterInputOTPChild(),
///     InputOTPChild.separator,
///     CharacterInputOTPChild(),
///     CharacterInputOTPChild(),
///     CharacterInputOTPChild(),
///   ],
///   onChanged: (code) => _handleOTPChange(code),
///   onSubmitted: (code) => _verifyOTP(code),
/// );
/// ```
class InputOTP extends StatefulWidget {
  /// The list of children defining input fields, separators, and spaces.
  final List<InputOTPChild> children;
  /// Initial OTP codepoint values.
  final OTPCodepointList? initialValue;
  /// Called when the OTP value changes.
  final ValueChanged<OTPCodepointList>? onChanged;
  /// Called when the user submits the OTP (e.g., presses Enter on last field).
  final ValueChanged<OTPCodepointList>? onSubmitted;
  /// Creates an [InputOTP] widget.
  ///
  /// Parameters:
  /// - [children] (`List<InputOTPChild>`, required): The OTP input fields and decorations.
  /// - [initialValue] (`OTPCodepointList?`, optional): Initial codepoints.
  /// - [onChanged] (`ValueChanged<OTPCodepointList>?`, optional): Value change callback.
  /// - [onSubmitted] (`ValueChanged<OTPCodepointList>?`, optional): Submit callback.
  const InputOTP({super.key, required this.children, this.initialValue, this.onChanged, this.onSubmitted});
  State<InputOTP> createState();
}
```
