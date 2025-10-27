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
  final List<InputOTPChild> children;
  final OTPCodepointList? initialValue;
  final ValueChanged<OTPCodepointList>? onChanged;
  final ValueChanged<OTPCodepointList>? onSubmitted;
  const InputOTP({super.key, required this.children, this.initialValue, this.onChanged, this.onSubmitted});
  State<InputOTP> createState();
}
```
