---
title: "Class: InputOTPChild"
description: "Reference for InputOTPChild"
---

```dart
abstract class InputOTPChild {
  static InputOTPChild get separator;
  static InputOTPChild get space;
  static InputOTPChild get empty;
  factory InputOTPChild.input({CodepointPredicate? predicate, CodepointUnaryOperator? transform, bool obscured = false, bool readOnly = false, TextInputType? keyboardType});
  factory InputOTPChild.character({bool allowLowercaseAlphabet = false, bool allowUppercaseAlphabet = false, bool allowDigit = false, bool obscured = false, bool onlyUppercaseAlphabet = false, bool onlyLowercaseAlphabet = false, bool readOnly = false, TextInputType? keyboardType});
  const InputOTPChild();
  Widget build(BuildContext context, InputOTPChildData data);
  bool get hasValue;
}
```
