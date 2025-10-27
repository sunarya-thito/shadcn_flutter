---
title: "Class: CharacterInputOTPChild"
description: "Reference for CharacterInputOTPChild"
---

```dart
class CharacterInputOTPChild extends InputOTPChild {
  static bool isAlphabetLower(int codepoint);
  static bool isAlphabetUpper(int codepoint);
  static int lowerToUpper(int codepoint);
  static int upperToLower(int codepoint);
  static bool isDigit(int codepoint);
  final CodepointPredicate? predicate;
  final CodepointUnaryOperator? transform;
  final bool obscured;
  final bool readOnly;
  final TextInputType? keyboardType;
  const CharacterInputOTPChild({this.predicate, this.transform, this.obscured = false, this.readOnly = false, this.keyboardType});
  bool get hasValue;
  Widget build(BuildContext context, InputOTPChildData data);
}
```
