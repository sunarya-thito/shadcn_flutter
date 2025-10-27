---
title: "Class: ToastTheme"
description: "Theme configuration for toast notification system."
---

```dart
/// Theme configuration for toast notification system.
///
/// Provides comprehensive styling properties for toast notifications including
/// layout, positioning, animation behavior, and visual effects. These properties
/// integrate with the design system and can be overridden at the widget level.
///
/// The theme supports advanced features like stacking behavior, expansion modes,
/// and sophisticated animation timing for professional toast experiences.
class ToastTheme {
  /// Maximum number of toast notifications to stack visually.
  ///
  /// Type: `int?`. If null, defaults to 3 stacked entries. Controls how many
  /// toasts are visible simultaneously, with older toasts being collapsed or hidden.
  final int? maxStackedEntries;
  /// Padding around the toast notification area.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, defaults to EdgeInsets.all(24) scaled
  /// by theme scaling factor. Applied to the toast positioning within safe area.
  final EdgeInsetsGeometry? padding;
  /// Behavior mode for toast stack expansion.
  ///
  /// Type: `ExpandMode?`. If null, defaults to [ExpandMode.expandOnHover].
  /// Controls when stacked toasts expand to show multiple entries simultaneously.
  final ExpandMode? expandMode;
  /// Offset for collapsed toast positioning.
  ///
  /// Type: `Offset?`. If null, defaults to Offset(0, 12) scaled by theme.
  /// Controls the vertical/horizontal spacing between stacked toast entries.
  final Offset? collapsedOffset;
  /// Scale factor for collapsed toast entries.
  ///
  /// Type: `double?`. If null, defaults to 0.9. Controls the size reduction
  /// of toast notifications that are stacked behind the active toast.
  final double? collapsedScale;
  /// Animation curve for toast expansion transitions.
  ///
  /// Type: `Curve?`. If null, defaults to Curves.easeOutCubic.
  /// Applied when transitioning between collapsed and expanded stack states.
  final Curve? expandingCurve;
  /// Duration for toast expansion animations.
  ///
  /// Type: `Duration?`. If null, defaults to 500 milliseconds.
  /// Controls the timing of stack expansion and collapse transitions.
  final Duration? expandingDuration;
  /// Opacity level for collapsed toast entries.
  ///
  /// Type: `double?`. If null, defaults to 1.0 (fully opaque).
  /// Controls the visibility of toast notifications in the stack behind the active toast.
  final double? collapsedOpacity;
  /// Initial opacity for toast entry animations.
  ///
  /// Type: `double?`. If null, defaults to 0.0 (fully transparent).
  /// Starting opacity value for toast notifications when they first appear.
  final double? entryOpacity;
  /// Spacing between expanded toast entries.
  ///
  /// Type: `double?`. If null, defaults to 8.0. Controls the gap between
  /// toast notifications when the stack is in expanded state.
  final double? spacing;
  /// Size constraints for individual toast notifications.
  ///
  /// Type: `BoxConstraints?`. If null, defaults to fixed width of 320 scaled
  /// by theme. Defines the maximum/minimum dimensions for toast content.
  final BoxConstraints? toastConstraints;
  /// Creates a [ToastTheme].
  ///
  /// All parameters are optional and can be null to use intelligent defaults
  /// that integrate with the current theme's design system and provide
  /// professional toast notification behavior.
  ///
  /// Example:
  /// ```dart
  /// const ToastTheme(
  ///   maxStackedEntries: 5,
  ///   expandMode: ExpandMode.expandOnHover,
  ///   spacing: 12.0,
  ///   collapsedScale: 0.95,
  /// );
  /// ```
  const ToastTheme({this.maxStackedEntries, this.padding, this.expandMode, this.collapsedOffset, this.collapsedScale, this.expandingCurve, this.expandingDuration, this.collapsedOpacity, this.entryOpacity, this.spacing, this.toastConstraints});
  /// Type definition for toast content builder functions.
  ///
  /// Takes a [BuildContext] and [ToastOverlay] instance, returning the widget
  /// that represents the toast's visual content. The overlay parameter provides
  /// control methods for dismissing or manipulating the toast notification.
  ///
  /// Example:
  /// ```dart
  /// ToastBuilder builder = (context, overlay) => Card(
  ///   child: ListTile(
  ///     title: Text('Notification'),
  ///     trailing: IconButton(
  ///       icon: Icon(Icons.close),
  ///       onPressed: overlay.close,
  ///     ),
  ///   ),
  /// );
  /// ```
  ToastTheme copyWith({ValueGetter<int?>? maxStackedEntries, ValueGetter<EdgeInsetsGeometry?>? padding, ValueGetter<ExpandMode?>? expandMode, ValueGetter<Offset?>? collapsedOffset, ValueGetter<double?>? collapsedScale, ValueGetter<Curve?>? expandingCurve, ValueGetter<Duration?>? expandingDuration, ValueGetter<double?>? collapsedOpacity, ValueGetter<double?>? entryOpacity, ValueGetter<double?>? spacing, ValueGetter<BoxConstraints?>? toastConstraints});
  int get hashCode;
  bool operator ==(Object other);
  String toString();
}
```
