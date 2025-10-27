---
title: "Class: ToastLayer"
description: "A sophisticated layer widget that provides toast notification infrastructure."
---

```dart
/// A sophisticated layer widget that provides toast notification infrastructure.
///
/// ToastLayer serves as the foundation for the toast notification system,
/// managing the display, positioning, animation, and lifecycle of multiple
/// toast notifications. It wraps application content and provides the necessary
/// context for [showToast] functions to work properly.
///
/// The layer handles complex features including toast stacking, expansion modes,
/// hover/tap interactions, automatic dismissal timing, gesture-based dismissal,
/// and smooth animations between states. It ensures proper theme integration
/// and responsive behavior across different screen sizes.
///
/// Key features:
/// - Multi-location toast support with six standard positions
/// - Intelligent toast stacking with configurable maximum entries
/// - Interactive expansion modes (hover, tap, always, disabled)
/// - Gesture-based dismissal with swipe recognition
/// - Automatic timeout handling with pause on hover
/// - Smooth animations for entry, exit, and state transitions
/// - Safe area and padding handling for various screen layouts
/// - Theme integration with comprehensive customization options
///
/// This is typically placed high in the widget tree, often wrapping the main
/// application content or individual screens that need toast functionality.
///
/// Example:
/// ```dart
/// ToastLayer(
///   maxStackedEntries: 4,
///   expandMode: ExpandMode.expandOnHover,
///   child: MyAppContent(),
/// );
/// ```
class ToastLayer extends StatefulWidget {
  /// The child widget to wrap with toast functionality.
  ///
  /// Type: `Widget`, required. The main application content that will have
  /// toast notification capabilities available through the widget tree.
  final Widget child;
  /// Maximum number of toast notifications to display simultaneously.
  ///
  /// Type: `int`, default: `3`. Controls how many toasts are visible at once,
  /// with older toasts being hidden or collapsed when limit is exceeded.
  final int maxStackedEntries;
  /// Padding around toast notification areas.
  ///
  /// Type: `EdgeInsetsGeometry?`. If null, uses default padding that respects
  /// safe area constraints. Applied to toast positioning within screen boundaries.
  final EdgeInsetsGeometry? padding;
  /// Behavior for toast stack expansion interactions.
  ///
  /// Type: `ExpandMode`, default: [ExpandMode.expandOnHover]. Controls when
  /// stacked toasts expand to show multiple entries simultaneously.
  final ExpandMode expandMode;
  /// Position offset for collapsed toast entries.
  ///
  /// Type: `Offset?`. If null, uses default offset that creates subtle
  /// stacking effect. Applied to toasts behind the active notification.
  final Offset? collapsedOffset;
  /// Scale factor for collapsed toast entries.
  ///
  /// Type: `double`, default: `0.9`. Controls size reduction of background
  /// toasts to create depth perception in the stack visualization.
  final double collapsedScale;
  /// Animation curve for expansion state transitions.
  ///
  /// Type: `Curve`, default: [Curves.easeOutCubic]. Applied when transitioning
  /// between collapsed and expanded stack states.
  final Curve expandingCurve;
  /// Duration for expansion animation transitions.
  ///
  /// Type: `Duration`, default: `500ms`. Controls timing of stack expansion
  /// and collapse animations for smooth user experience.
  final Duration expandingDuration;
  /// Opacity level for collapsed toast entries.
  ///
  /// Type: `double`, default: `1.0`. Controls visibility of background toasts
  /// in the stack, with 1.0 being fully opaque and 0.0 being transparent.
  final double collapsedOpacity;
  /// Initial opacity for toast entry animations.
  ///
  /// Type: `double`, default: `0.0`. Starting opacity value for toast
  /// notifications during their entrance animation sequence.
  final double entryOpacity;
  /// Spacing between toast entries in expanded mode.
  ///
  /// Type: `double`, default: `8.0`. Gap between individual toast notifications
  /// when the stack is expanded to show multiple entries.
  final double spacing;
  /// Size constraints for individual toast notifications.
  ///
  /// Type: `BoxConstraints?`. If null, uses responsive width based on screen
  /// size and theme scaling. Defines maximum and minimum toast dimensions.
  final BoxConstraints? toastConstraints;
  /// Creates a [ToastLayer].
  ///
  /// The [child] parameter is required as the content to wrap with toast
  /// functionality. All other parameters have sensible defaults but can be
  /// customized to match specific design requirements.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Content to wrap with toast capabilities
  /// - [maxStackedEntries] (int, default: 3): Maximum visible toast count
  /// - [padding] (EdgeInsetsGeometry?, optional): Toast area padding override
  /// - [expandMode] (ExpandMode, default: expandOnHover): Stack expansion behavior
  /// - [collapsedOffset] (Offset?, optional): Background toast positioning offset
  /// - [collapsedScale] (double, default: 0.9): Background toast size reduction
  /// - [expandingCurve] (Curve, default: easeOutCubic): Expansion animation curve
  /// - [expandingDuration] (Duration, default: 500ms): Expansion animation timing
  /// - [collapsedOpacity] (double, default: 1.0): Background toast visibility
  /// - [entryOpacity] (double, default: 0.0): Toast entrance starting opacity
  /// - [spacing] (double, default: 8.0): Gap between expanded toast entries
  /// - [toastConstraints] (BoxConstraints?, optional): Individual toast size limits
  ///
  /// Example:
  /// ```dart
  /// ToastLayer(
  ///   maxStackedEntries: 5,
  ///   expandMode: ExpandMode.expandOnTap,
  ///   spacing: 12.0,
  ///   child: MaterialApp(home: HomePage()),
  /// );
  /// ```
  const ToastLayer({super.key, required this.child, this.maxStackedEntries = 3, this.padding, this.expandMode = ExpandMode.expandOnHover, this.collapsedOffset, this.collapsedScale = 0.9, this.expandingCurve = Curves.easeOutCubic, this.expandingDuration = const Duration(milliseconds: 500), this.collapsedOpacity = 1, this.entryOpacity = 0.0, this.spacing = 8, this.toastConstraints});
  State<ToastLayer> createState();
}
```
