---
title: "Class: WidgetStatesProvider"
description: "A widget that provides widget state information to descendants via `Data`."
---

```dart
/// A widget that provides widget state information to descendants via `Data`.
///
/// [WidgetStatesProvider] manages and propagates widget states (like hovered,
/// pressed, disabled) down the widget tree using the Data inheritance mechanism.
/// It supports both static state sets and dynamic controller-based states.
///
/// ## Overview
///
/// Use [WidgetStatesProvider] to:
/// - Share widget states with descendant widgets
/// - Control states programmatically via [WidgetStatesController]
/// - Inherit states from ancestor providers
/// - Create state boundaries to isolate state contexts
///
/// ## Example
///
/// ```dart
/// WidgetStatesProvider(
///   states: {WidgetState.hovered},
///   child: StatedWidget(
///     child: Text('Normal'),
///     hovered: Text('Hovered'),
///   ),
/// )
/// ```
class WidgetStatesProvider extends StatelessWidget {
  /// Optional controller for programmatic state management.
  final WidgetStatesController? controller;
  /// Static set of widget states to provide.
  final Set<WidgetState>? states;
  /// The child widget that can access the provided states.
  final Widget child;
  /// Whether to inherit states from ancestor providers.
  ///
  /// When `true`, combines local states with inherited states.
  final bool inherit;
  /// Whether this provider acts as a state boundary.
  final bool boundary;
  /// Creates a widget states provider with optional controller and states.
  ///
  /// ## Parameters
  ///
  /// * [controller] - Optional controller for dynamic state management.
  /// * [child] - The descendant widget that can access states.
  /// * [states] - Static set of states to provide. Defaults to empty set.
  /// * [inherit] - Whether to inherit from ancestors. Defaults to `true`.
  const WidgetStatesProvider({super.key, this.controller, required this.child, this.states = const {}, this.inherit = true});
  /// Creates a widget states provider that acts as a state boundary.
  ///
  /// A boundary provider blocks state inheritance from ancestors, creating
  /// an isolated state context for its descendants.
  ///
  /// ## Parameters
  ///
  /// * [child] - The descendant widget.
  const WidgetStatesProvider.boundary({super.key, required this.child});
  Widget build(BuildContext context);
}
```
