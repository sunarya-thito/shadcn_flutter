import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A function signature for building widgets that wrap child widgets.
///
/// Takes a [BuildContext] and a [Widget] child, returning a wrapped [Widget].
/// This allows for dynamic wrapping behavior where the wrapper can access
/// the build context.
typedef WrapperBuilder = Widget Function(
  BuildContext context,
  Widget child,
);

/// A widget that conditionally wraps its child with a builder function.
///
/// [Wrapper] provides flexible control over whether and how to wrap a child widget.
/// It can optionally apply a custom builder function and maintain the widget
/// structure across rebuilds using a keyed subtree.
///
/// Key features:
/// - Conditional wrapping with [wrap] flag
/// - Optional structure preservation with [maintainStructure]
/// - Custom builder function support via [WrapperBuilder]
///
/// Example:
/// ```dart
/// Wrapper(
///   wrap: true,
///   builder: (context, child) => Container(
///     padding: EdgeInsets.all(8),
///     child: child,
///   ),
///   child: Text('Hello'),
/// )
/// ```
class Wrapper extends StatefulWidget {
  /// The child widget to be wrapped.
  final Widget child;

  /// Optional builder function to wrap the child.
  ///
  /// If [wrap] is true and this is provided, the child will be wrapped
  /// using this builder function. If null, the child is returned as-is.
  final WrapperBuilder? builder;

  /// Whether to apply the [builder] wrapper.
  ///
  /// When false, the [child] is returned directly regardless of [builder].
  /// Defaults to true.
  final bool wrap;

  /// Whether to maintain the widget structure across rebuilds.
  ///
  /// When true, wraps the child in a [KeyedSubtree] to preserve the widget
  /// subtree identity across rebuilds. This can be useful for maintaining
  /// widget state when the wrapper's parent rebuilds.
  /// Defaults to false.
  final bool maintainStructure;

  /// Creates a [Wrapper] widget.
  ///
  /// The [child] parameter is required. The [wrap] parameter defaults to true,
  /// and [maintainStructure] defaults to false.
  const Wrapper({
    super.key,
    required this.child,
    this.builder,
    this.wrap = true,
    this.maintainStructure = false,
  });

  @override
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
