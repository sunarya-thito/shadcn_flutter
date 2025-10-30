---
title: "Class: StatedWidget"
description: "An abstract widget that provides state-aware visual variations."
---

```dart
/// An abstract widget that provides state-aware visual variations.
///
/// Enables widgets to display different appearances based on their current
/// interactive state (disabled, selected, pressed, hovered, focused, error).
/// The widget automatically selects the appropriate visual representation
/// from provided alternatives based on a configurable state priority order.
///
/// Three factory constructors provide different approaches to state handling:
/// - Default constructor: Explicit widgets for each state
/// - `.map()`: Map-based state-to-widget associations
/// - `.builder()`: Function-based dynamic state handling
///
/// The state resolution follows a priority order where earlier states in the
/// order take precedence over later ones. This ensures consistent behavior
/// when multiple states are active simultaneously.
///
/// Example:
/// ```dart
/// StatedWidget(
///   child: Text('Default'),
///   disabled: Text('Disabled State'),
///   hovered: Text('Hovered State'),
///   pressed: Text('Pressed State'),
///   selected: Text('Selected State'),
/// )
/// ```
abstract class StatedWidget extends StatelessWidget {
  /// Default state priority order for resolving multiple active states.
  ///
  /// Defines the precedence when multiple widget states are active simultaneously.
  /// States earlier in the list take priority over later ones. The default order
  /// prioritizes accessibility and interaction feedback appropriately.
  static const List<WidgetState> defaultStateOrder = [WidgetState.disabled, WidgetState.error, WidgetState.selected, WidgetState.pressed, WidgetState.hovered, WidgetState.focused];
  /// Creates a [StatedWidget] with explicit state-specific widgets.
  ///
  /// Provides dedicated widget instances for each supported state.
  /// The [child] serves as the default widget when no specific state
  /// matches or when no state-specific widget is provided.
  ///
  /// State resolution follows the [order] priority, with earlier states
  /// taking precedence. The first matching state with a non-null widget
  /// is selected for display.
  ///
  /// Parameters:
  /// - [child] (Widget, required): Default widget for normal state
  /// - [order] (`List<WidgetState>`, default: defaultStateOrder): State priority order
  /// - [disabled] (Widget?, optional): Widget for disabled state
  /// - [selected] (Widget?, optional): Widget for selected state
  /// - [pressed] (Widget?, optional): Widget for pressed/active state
  /// - [hovered] (Widget?, optional): Widget for hover state
  /// - [focused] (Widget?, optional): Widget for focused state
  /// - [error] (Widget?, optional): Widget for error state
  ///
  /// Example:
  /// ```dart
  /// StatedWidget(
  ///   child: Icon(Icons.star_border),
  ///   selected: Icon(Icons.star, color: Colors.yellow),
  ///   hovered: Icon(Icons.star_border, color: Colors.grey),
  ///   disabled: Icon(Icons.star_border, color: Colors.grey.shade300),
  /// )
  /// ```
  factory StatedWidget({Key? key, required Widget child, List<WidgetState> order, Widget? disabled, Widget? selected, Widget? pressed, Widget? hovered, Widget? focused, Widget? error});
  /// Creates a [StatedWidget] using a map-based state configuration.
  ///
  /// Provides a flexible approach where states are defined using a map
  /// with keys representing state identifiers and values being the
  /// corresponding widgets. This approach is useful when states are
  /// determined dynamically or when working with custom state types.
  ///
  /// The [child] parameter serves as a fallback when no matching state
  /// is found in the states map. State resolution prioritizes exact
  /// matches in the provided map.
  ///
  /// Parameters:
  /// - [states] (`Map<Object, Widget>`, required): Map of state-to-widget mappings
  /// - [child] (Widget?, optional): Fallback widget when no state matches
  ///
  /// Example:
  /// ```dart
  /// StatedWidget.map(
  ///   states: {
  ///     WidgetState.selected: Icon(Icons.check_circle, color: Colors.green),
  ///     WidgetState.error: Icon(Icons.error, color: Colors.red),
  ///     'custom': Icon(Icons.star, color: Colors.blue),
  ///   },
  ///   child: Icon(Icons.circle_outlined),
  /// )
  /// ```
  factory StatedWidget.map({Key? key, required Map<Object, Widget> states, Widget? child});
  /// Creates a [StatedWidget] using a builder function for dynamic state handling.
  ///
  /// Provides maximum flexibility by using a builder function that receives
  /// the current set of active widget states and returns the appropriate
  /// widget. This approach allows for complex state logic, animations,
  /// and dynamic visual computations based on state combinations.
  ///
  /// The builder function is called whenever the widget states change,
  /// allowing for real-time adaptation to state transitions. This is
  /// ideal for complex UI that needs to respond to multiple simultaneous states.
  ///
  /// Parameters:
  /// - [builder] (Function, required): Builder function receiving context and states
  ///
  /// Example:
  /// ```dart
  /// StatedWidget.builder(
  ///   builder: (context, states) {
  ///     if (states.contains(WidgetState.disabled)) {
  ///       return Opacity(opacity: 0.5, child: Icon(Icons.block));
  ///     }
  ///     if (states.contains(WidgetState.selected)) {
  ///       return Icon(Icons.check_circle, color: Colors.green);
  ///     }
  ///     if (states.contains(WidgetState.hovered)) {
  ///       return AnimatedScale(scale: 1.1, child: Icon(Icons.star));
  ///     }
  ///     return Icon(Icons.star_border);
  ///   },
  /// )
  /// ```
  factory StatedWidget.builder({Key? key, required Widget Function(BuildContext context, Set<WidgetState> states) builder});
}
```
