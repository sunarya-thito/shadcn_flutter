import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Function signature for building wrapper widgets around child content.
/// 
/// WrapperBuilder defines the callback used by [Wrapper] components to
/// construct wrapper widgets that surround child content. The builder
/// receives the build context and child widget, returning a widget that
/// wraps or decorates the child.
/// 
/// This pattern is commonly used for conditional decorations, theme
/// applications, or dynamic wrapper injection based on runtime conditions.
/// 
/// ## Parameters
/// 
/// - [context] (BuildContext): Build context for theme and configuration access
/// - [child] (Widget): The child widget to be wrapped
/// 
/// ## Returns
/// 
/// A [Widget] that wraps or decorates the provided child widget.
/// 
/// Example:
/// ```dart
/// WrapperBuilder cardWrapper = (context, child) {
///   return Card(
///     elevation: 4,
///     child: Padding(
///       padding: EdgeInsets.all(16),
///       child: child,
///     ),
///   );
/// };
/// ```
typedef WrapperBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

/// A utility widget for conditionally applying wrapper widgets around child content.
/// 
/// Wrapper provides a flexible system for conditionally decorating or wrapping
/// widgets based on runtime conditions. It supports optional wrapper application,
/// widget structure preservation, and dynamic wrapper building through builder functions.
/// 
/// ## Key Features
/// 
/// - **Conditional Wrapping**: Apply wrappers only when needed
/// - **Structure Preservation**: Maintain widget structure for performance optimization
/// - **Dynamic Building**: Use builder functions for runtime wrapper creation
/// - **Performance Optimization**: Avoid unnecessary widget creation when wrapping is disabled
/// 
/// ## Use Cases
/// 
/// - Conditional theming or styling application
/// - Debug wrapper injection during development
/// - Dynamic decoration based on user preferences
/// - Performance-optimized wrapper management
/// - A/B testing with different wrapper configurations
/// 
/// ## Wrapper Behavior
/// 
/// The wrapper application follows this logic:
/// 1. If [maintainStructure] is true, child is wrapped in [KeyedSubtree]
/// 2. If [wrap] is true and [builder] is provided, builder wraps the child
/// 3. Otherwise, child is returned unchanged
/// 
/// Example:
/// ```dart
/// // Conditional card wrapper based on user preference
/// Wrapper(
///   wrap: userPreferences.showCards,
///   builder: (context, child) => Card(
///     elevation: 2,
///     child: Padding(
///       padding: EdgeInsets.all(12),
///       child: child,
///     ),
///   ),
///   child: Text('Content that may be wrapped in a card'),
/// )
/// 
/// // Debug wrapper that only applies in development
/// Wrapper(
///   wrap: kDebugMode,
///   builder: (context, child) => Container(
///     decoration: BoxDecoration(border: Border.all(color: Colors.red)),
///     child: child,
///   ),
///   child: MyWidget(),
/// )
/// ```
class Wrapper extends StatefulWidget {
  /// The child widget that may be wrapped.
  /// 
  /// This is the core content that will either be wrapped by the [builder]
  /// function or returned unchanged, depending on the [wrap] parameter.
  final Widget child;
  
  /// Function that builds the wrapper widget around the child.
  /// 
  /// Called when [wrap] is true to create a wrapper around the child.
  /// The builder receives the build context and child widget, returning
  /// a widget that decorates or wraps the child.
  /// 
  /// When null, no wrapping occurs regardless of the [wrap] setting.
  final WrapperBuilder? builder;
  
  /// Whether to apply the wrapper builder to the child.
  /// 
  /// When true and [builder] is not null, the child is wrapped using
  /// the builder function. When false, the child is returned unchanged
  /// (potentially with structure preservation if [maintainStructure] is true).
  /// 
  /// This allows for conditional wrapper application based on runtime conditions.
  final bool wrap;
  
  /// Whether to preserve widget structure using [KeyedSubtree].
  /// 
  /// When true, the child is wrapped in [KeyedSubtree] to maintain
  /// widget identity and preserve internal state even when the wrapper
  /// configuration changes. This is useful for performance optimization
  /// in scenarios with frequent wrapper changes.
  /// 
  /// When false, no structure preservation is applied.
  final bool maintainStructure;

  /// Creates a [Wrapper] with the specified child and configuration.
  /// 
  /// The [child] parameter is required. All other parameters provide
  /// configuration options for conditional wrapping behavior.
  /// 
  /// Parameters:
  /// - [child] (Widget, required): The widget to potentially wrap
  /// - [builder] (WrapperBuilder?, optional): Function to build wrapper widget
  /// - [wrap] (bool, default: true): Whether to apply wrapper when builder exists
  /// - [maintainStructure] (bool, default: false): Whether to preserve widget structure
  /// 
  /// Example:
  /// ```dart
  /// // Basic conditional wrapper
  /// Wrapper(
  ///   wrap: showBorder,
  ///   builder: (context, child) => DecoratedBox(
  ///     decoration: BoxDecoration(border: Border.all()),
  ///     child: child,
  ///   ),
  ///   child: Text('Maybe bordered text'),
  /// );
  /// 
  /// // Structure-preserving wrapper for performance
  /// Wrapper(
  ///   maintainStructure: true,
  ///   builder: expensiveWrapperBuilder,
  ///   child: ComplexStatefulWidget(),
  /// );
  /// ```
  const Wrapper({
    super.key,
    required this.child,
    this.builder,
    this.wrap = true,
    this.maintainStructure = false,
  });

  @override
  /// Creates the mutable state for this wrapper.
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final GlobalKey _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    Widget wrappedChild = widget.child;
    if (widget.maintainStructure) {
      wrappedChild = KeyedSubtree(
        key: _key,
        child: wrappedChild,
      );
    }
    if (widget.wrap && widget.builder != null) {
      wrappedChild = widget.builder!(context, wrappedChild);
    }
    return wrappedChild;
  }
}
