---
title: "Extension: IconExtension"
description: "Extension on [Widget] providing convenient icon theme utilities."
---

```dart
/// Extension on [Widget] providing convenient icon theme utilities.
///
/// Provides methods to wrap icons with predefined size and color themes,
/// making it easy to apply consistent styling to icon widgets throughout
/// an application.
extension IconExtension on Widget {
  /// Wraps the icon with extra-extra-extra-extra small size theme.
  WrappedIcon get iconX4Small;
  /// Wraps the icon with extra-extra-extra small size theme.
  WrappedIcon get iconX3Small;
  /// Wraps the icon with extra-extra small size theme.
  WrappedIcon get iconX2Small;
  /// Wraps the icon with extra small size theme.
  WrappedIcon get iconXSmall;
  /// Wraps the icon with small size theme.
  WrappedIcon get iconSmall;
  /// Wraps the icon with medium size theme.
  WrappedIcon get iconMedium;
  /// Wraps the icon with large size theme.
  WrappedIcon get iconLarge;
  /// Wraps the icon with extra large size theme.
  WrappedIcon get iconXLarge;
  /// Wraps the icon with extra-extra large size theme.
  WrappedIcon get iconX2Large;
  /// Wraps the icon with extra-extra-extra large size theme.
  WrappedIcon get iconX3Large;
  /// Wraps the icon with extra-extra-extra-extra large size theme.
  WrappedIcon get iconX4Large;
  /// Wraps the icon with muted foreground color.
  ///
  /// Applies a subdued color suitable for secondary or less prominent icons.
  WrappedIcon get iconMutedForeground;
  /// Wraps the icon with destructive foreground color.
  ///
  /// Deprecated: Use alternative color scheme methods instead.
  WrappedIcon get iconDestructiveForeground;
  /// Wraps the icon with primary foreground color.
  ///
  /// Typically used for icons on primary-colored backgrounds.
  WrappedIcon get iconPrimaryForeground;
  /// Wraps the icon with primary color.
  ///
  /// Applies the theme's primary accent color to the icon.
  WrappedIcon get iconPrimary;
  /// Wraps the icon with secondary color.
  ///
  /// Applies the theme's secondary accent color to the icon.
  WrappedIcon get iconSecondary;
  /// Wraps the icon with secondary foreground color.
  ///
  /// Typically used for icons on secondary-colored backgrounds.
  WrappedIcon get iconSecondaryForeground;
}
```
