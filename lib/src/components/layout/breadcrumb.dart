import 'package:flutter/gestures.dart';

import '../../../shadcn_flutter.dart';

/// Theme for [Breadcrumb].
class BreadcrumbTheme {
  /// Separator widget between breadcrumb items.
  final Widget? separator;

  /// Padding around the breadcrumb row.
  final EdgeInsetsGeometry? padding;

  /// Creates a [BreadcrumbTheme].
  const BreadcrumbTheme({this.separator, this.padding});

  /// Returns a copy of this theme with the given fields replaced.
  BreadcrumbTheme copyWith({
    ValueGetter<Widget?>? separator,
    ValueGetter<EdgeInsetsGeometry?>? padding,
  }) {
    return BreadcrumbTheme(
      separator: separator == null ? this.separator : separator(),
      padding: padding == null ? this.padding : padding(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BreadcrumbTheme &&
        other.separator == separator &&
        other.padding == padding;
  }

  @override
  int get hashCode => Object.hash(separator, padding);
}

class _ArrowSeparator extends StatelessWidget {
  const _ArrowSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12 * scaling),
      child: const Icon(RadixIcons.chevronRight).iconXSmall().muted(),
    );
  }
}

class _SlashSeparator extends StatelessWidget {
  const _SlashSeparator();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4 * scaling),
      child: const Text('/').small().muted(),
    );
  }
}

/// Navigation breadcrumb trail showing hierarchical path with customizable separators.
///
/// A horizontal navigation widget that displays a series of linked items
/// representing the current location within a hierarchical structure.
/// Automatically adds separators between items and supports horizontal scrolling
/// for overflow handling.
///
/// ## Features
///
/// - **Hierarchical navigation**: Clear visual representation of path structure
/// - **Customizable separators**: Built-in arrow and slash separators or custom widgets
/// - **Overflow handling**: Horizontal scrolling when content exceeds available width
/// - **Touch-optimized**: Mobile-friendly scrolling behavior
/// - **Theming support**: Consistent styling through theme system
/// - **Responsive**: Automatically adapts to different screen sizes
///
/// The breadcrumb automatically handles the last item differently, showing it
/// as the current location without making it interactive.
///
/// Example:
/// ```dart
/// Breadcrumb(
///   separator: Breadcrumb.slashSeparator,
///   children: [
///     GestureDetector(
///       onTap: () => Navigator.pop(context),
///       child: Text('Home'),
///     ),
///     GestureDetector(
///       onTap: () => Navigator.pop(context),
///       child: Text('Products'),
///     ),
///     Text('Electronics'), // Current page
///   ],
/// );
/// ```
class Breadcrumb extends StatelessWidget {
  /// Default arrow separator widget (>).
  ///
  /// Can be used as the [separator] parameter for arrow-style navigation.
  static const Widget arrowSeparator = _ArrowSeparator();

  /// Default slash separator widget (/).
  ///
  /// Can be used as the [separator] parameter for slash-style navigation.
  static const Widget slashSeparator = _SlashSeparator();

  /// The list of breadcrumb navigation items.
  ///
  /// Each widget represents a step in the navigation trail, from root to
  /// current location. The last item is styled as the current page.
  final List<Widget> children;

  /// Widget displayed between breadcrumb items.
  ///
  /// If `null`, uses the default separator from the theme.
  final Widget? separator;

  /// Padding around the entire breadcrumb widget.
  ///
  /// If `null`, uses default padding from the theme.
  final EdgeInsetsGeometry? padding;

  /// Creates a [Breadcrumb] navigation trail.
  ///
  /// The last child in the list is treated as the current location and
  /// is styled differently from the preceding navigation items.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): breadcrumb items from root to current
  /// - [separator] (Widget?, optional): custom separator between items
  /// - [padding] (EdgeInsetsGeometry?, optional): padding around the breadcrumb
  ///
  /// Example:
  /// ```dart
  /// Breadcrumb(
  ///   separator: Icon(Icons.chevron_right),
  ///   children: [
  ///     TextButton(onPressed: goHome, child: Text('Home')),
  ///     TextButton(onPressed: goToCategory, child: Text('Category')),
  ///     Text('Current Page'),
  ///   ],
  /// )
  /// ```
  const Breadcrumb({
    super.key,
    required this.children,
    this.separator,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<BreadcrumbTheme>(context);
    final sep = separator ?? compTheme?.separator ?? Breadcrumb.arrowSeparator;
    final pad = styleValue(
      widgetValue: padding,
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.zero,
    );
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(
        context,
      ).copyWith(scrollbars: false, dragDevices: {PointerDeviceKind.touch}),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: pad,
          child: Row(
            children: [
              if (children.length == 1) children[0].medium().foreground(),
              if (children.length > 1)
                for (var i = 0; i < children.length; i++)
                  if (i == children.length - 1)
                    children[i].medium().foreground()
                  else
                    Row(children: [children[i].medium(), sep]),
            ],
          ).small().muted(),
        ),
      ),
    );
  }
}
