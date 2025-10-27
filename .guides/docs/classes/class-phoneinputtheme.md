---
title: "Class: PhoneInputTheme"
description: "Theme data for [PhoneInput]."
---

```dart
/// Theme data for [PhoneInput].
class PhoneInputTheme {
  /// The padding of the [PhoneInput].
  final EdgeInsetsGeometry? padding;
  /// The border radius of the [PhoneInput].
  final BorderRadiusGeometry? borderRadius;
  /// The constraints of the country selector popup.
  final BoxConstraints? popupConstraints;
  /// The maximum width of the [PhoneInput].
  final double? maxWidth;
  /// The height of the flag.
  final double? flagHeight;
  /// The width of the flag.
  final double? flagWidth;
  /// The gap between the flag and the country code.
  final double? flagGap;
  /// The gap between the country code and the text field.
  final double? countryGap;
  /// The shape of the flag.
  final Shape? flagShape;
  /// Theme data for [PhoneInput].
  const PhoneInputTheme({this.padding, this.borderRadius, this.popupConstraints, this.maxWidth, this.flagHeight, this.flagWidth, this.flagGap, this.countryGap, this.flagShape});
  /// Creates a copy of this [PhoneInputTheme] with the given values overridden.
  PhoneInputTheme copyWith({ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<BorderRadiusGeometry?>? borderRadius, ValueGetter<BoxConstraints?>? popupConstraints, ValueGetter<double?>? maxWidth, ValueGetter<double?>? flagHeight, ValueGetter<double?>? flagWidth, ValueGetter<double?>? flagGap, ValueGetter<double?>? countryGap, ValueGetter<Shape?>? flagShape});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
