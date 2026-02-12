---
title: "Class: FlipperCharset"
description: "Defines a character set for [FlipperCharacter] and [TextFlipper]."
---

```dart
/// Defines a character set for [FlipperCharacter] and [TextFlipper].
class FlipperCharset {
  /// Digits 0–9.
  static const FlipperCharset numbers = FlipperCharset('0123456789');
  /// Uppercase Latin letters.
  static const FlipperCharset uppercase = FlipperCharset('ABCDEFGHIJKLMNOPQRSTUVWXYZ');
  /// Lowercase Latin letters.
  static const FlipperCharset lowercase = FlipperCharset('abcdefghijklmnopqrstuvwxyz');
  /// Uppercase and lowercase Latin letters.
  static const FlipperCharset letters = FlipperCharset('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz');
  /// Alphanumeric characters.
  static const FlipperCharset alphanumeric = FlipperCharset('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789');
  /// Common symbol characters.
  static const FlipperCharset symbols = FlipperCharset('!@#\$%^&*()-_=+[]{}|;:\'",.<>?/`~');
  /// Letters, numbers, and symbols.
  static const FlipperCharset all = FlipperCharset('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#\$%^&*()-_=+[]{}|;:\'",.<>?/`~');
  /// The characters available to flip through.
  final String characters;
  /// Creates a [FlipperCharset] from a string of characters.
  const FlipperCharset(this.characters);
  /// Combines two [FlipperCharset] instances into one.
  FlipperCharset operator +(FlipperCharset other);
  String toString();
  bool operator ==(Object other);
  int get hashCode;
}
```
