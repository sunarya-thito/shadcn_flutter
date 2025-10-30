---
title: "Class: HoverCardTheme"
description: "Theme configuration for hover card behavior and appearance."
---

```dart
/// Theme configuration for hover card behavior and appearance.
///
/// Defines timing, positioning, and interaction behavior for hover cards,
/// providing consistent styling across the application.
///
/// Example:
/// ```dart
/// ComponentThemeData(
///   data: {
///     HoverCardTheme: HoverCardTheme(
///       debounce: Duration(milliseconds: 300),
///       wait: Duration(milliseconds: 700),
///       popoverAlignment: Alignment.topCenter,
///     ),
///   },
///   child: MyApp(),
/// )
/// ```
class HoverCardTheme {
  /// Duration to wait before hiding the hover card after mouse exit.
  final Duration? debounce;
  /// Duration to wait before showing the hover card after mouse enter.
  final Duration? wait;
  /// Alignment of the popover relative to its anchor.
  final AlignmentGeometry? popoverAlignment;
  /// Alignment point on the anchor widget.
  final AlignmentGeometry? anchorAlignment;
  /// Offset of the popover from its calculated position.
  final Offset? popoverOffset;
  /// Hit test behavior for mouse interactions.
  final HitTestBehavior? behavior;
  /// Creates a [HoverCardTheme].
  ///
  /// All parameters are optional and will use system defaults when null.
  ///
  /// Parameters:
  /// - [debounce] (Duration?, optional): delay before hiding after mouse exit
  /// - [wait] (Duration?, optional): delay before showing after mouse enter
  /// - [popoverAlignment] (AlignmentGeometry?, optional): popover alignment
  /// - [anchorAlignment] (AlignmentGeometry?, optional): anchor point alignment
  /// - [popoverOffset] (Offset?, optional): offset from calculated position
  /// - [behavior] (HitTestBehavior?, optional): mouse interaction behavior
  ///
  /// Example:
  /// ```dart
  /// const HoverCardTheme(
  ///   debounce: Duration(milliseconds: 200),
  ///   wait: Duration(milliseconds: 600),
  ///   popoverAlignment: Alignment.bottomCenter,
  /// )
  /// ```
  const HoverCardTheme({this.debounce, this.wait, this.popoverAlignment, this.anchorAlignment, this.popoverOffset, this.behavior});
  /// Creates a copy with specified fields replaced.
  ///
  /// Parameters:
  /// - [debounce] (`ValueGetter<Duration?>?`, optional): New debounce duration getter.
  /// - [wait] (`ValueGetter<Duration?>?`, optional): New wait duration getter.
  /// - [popoverAlignment] (`ValueGetter<AlignmentGeometry?>?`, optional): New popover alignment getter.
  /// - [anchorAlignment] (`ValueGetter<AlignmentGeometry?>?`, optional): New anchor alignment getter.
  /// - [popoverOffset] (`ValueGetter<Offset?>?`, optional): New offset getter.
  /// - [behavior] (`ValueGetter<HitTestBehavior?>?`, optional): New behavior getter.
  ///
  /// Returns: `HoverCardTheme` — new theme with updated values.
  HoverCardTheme copyWith({ValueGetter<Duration?>? debounce, ValueGetter<Duration?>? wait, ValueGetter<AlignmentGeometry?>? popoverAlignment, ValueGetter<AlignmentGeometry?>? anchorAlignment, ValueGetter<Offset?>? popoverOffset, ValueGetter<HitTestBehavior?>? behavior});
  bool operator ==(Object other);
  int get hashCode;
}
```
