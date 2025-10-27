---
title: "Class: AccordionTheme"
description: "Theme configuration for [Accordion], [AccordionItem], and [AccordionTrigger] widgets."
---

```dart
/// Theme configuration for [Accordion], [AccordionItem], and [AccordionTrigger] widgets.
///
/// [AccordionTheme] provides comprehensive styling options for all accordion-related
/// widgets, including animation timing, spacing, colors, and iconography. It allows
/// for consistent accordion styling across an application while still permitting
/// per-instance customization.
///
/// Used with [ComponentTheme] to apply theme values throughout the widget tree.
///
/// Example:
/// ```dart
/// ComponentTheme<AccordionTheme>(
///   data: AccordionTheme(
///     duration: Duration(milliseconds: 300),
///     curve: Curves.easeInOut,
///     padding: 20.0,
///     arrowIcon: Icons.expand_more,
///     arrowIconColor: Colors.blue,
///   ),
///   child: MyAccordionWidget(),
/// );
/// ```
class AccordionTheme {
  /// Duration of the expand/collapse animation.
  ///
  /// Controls how long it takes for accordion items to animate between
  /// expanded and collapsed states. If null, defaults to 200 milliseconds.
  final Duration? duration;
  /// Animation curve used when expanding accordion items.
  ///
  /// Defines the easing function applied during expansion animations.
  /// If null, defaults to [Curves.easeIn].
  final Curve? curve;
  /// Animation curve used when collapsing accordion items.
  ///
  /// Defines the easing function applied during collapse animations.
  /// If null, defaults to [Curves.easeOut].
  final Curve? reverseCurve;
  /// Vertical padding applied to accordion triggers and content.
  ///
  /// Controls the space above and below trigger text and between triggers
  /// and content. If null, defaults to 16 logical pixels scaled by theme.
  final double? padding;
  /// Horizontal spacing between trigger text and the expand/collapse icon.
  ///
  /// Controls the gap between the trigger content and the arrow icon.
  /// If null, defaults to 18 logical pixels scaled by theme.
  final double? iconGap;
  /// Height of divider lines between accordion items.
  ///
  /// Controls the thickness of the visual separators between accordion items.
  /// If null, defaults to 1 logical pixel scaled by theme.
  final double? dividerHeight;
  /// Color of divider lines between accordion items.
  ///
  /// If null, uses the muted color from the theme color scheme.
  final Color? dividerColor;
  /// Icon displayed in the trigger to indicate expand/collapse state.
  ///
  /// This icon is rotated 180 degrees when transitioning between states.
  /// If null, defaults to [Icons.keyboard_arrow_up].
  final IconData? arrowIcon;
  /// Color of the expand/collapse arrow icon.
  ///
  /// If null, uses the muted foreground color from the theme color scheme.
  final Color? arrowIconColor;
  /// Creates an [AccordionTheme] with the specified styling options.
  ///
  /// All parameters are optional and will fall back to component defaults
  /// when not specified.
  ///
  /// Parameters:
  /// - [duration] (Duration?, optional): Animation duration for expand/collapse.
  /// - [curve] (Curve?, optional): Easing curve for expansion animation.
  /// - [reverseCurve] (Curve?, optional): Easing curve for collapse animation.
  /// - [padding] (double?, optional): Vertical padding for triggers and content.
  /// - [iconGap] (double?, optional): Space between trigger text and icon.
  /// - [dividerHeight] (double?, optional): Thickness of item dividers.
  /// - [dividerColor] (Color?, optional): Color of item dividers.
  /// - [arrowIcon] (IconData?, optional): Icon for expand/collapse indicator.
  /// - [arrowIconColor] (Color?, optional): Color of the arrow icon.
  const AccordionTheme({this.duration, this.curve, this.reverseCurve, this.padding, this.iconGap, this.dividerHeight, this.dividerColor, this.arrowIcon, this.arrowIconColor});
  /// Creates a copy of this theme with the given values replaced.
  ///
  /// Uses [ValueGetter] functions to allow conditional updates where
  /// null getters preserve the original value.
  ///
  /// Example:
  /// ```dart
  /// final newTheme = originalTheme.copyWith(
  ///   duration: () => Duration(milliseconds: 400),
  ///   curve: () => Curves.bounceOut,
  /// );
  /// ```
  AccordionTheme copyWith({ValueGetter<Duration?>? duration, ValueGetter<Curve?>? curve, ValueGetter<Curve?>? reverseCurve, ValueGetter<double?>? padding, ValueGetter<double?>? iconGap, ValueGetter<double?>? dividerHeight, ValueGetter<Color?>? dividerColor, ValueGetter<IconData?>? arrowIcon, ValueGetter<Color?>? arrowIconColor});
  bool operator ==(Object other);
  int get hashCode;
  String toString();
}
```
