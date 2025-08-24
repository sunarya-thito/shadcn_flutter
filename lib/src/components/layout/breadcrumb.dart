import 'package:flutter/gestures.dart';

import '../../../shadcn_flutter.dart';

/// Theme configuration for [Breadcrumb] navigation components.
///
/// [BreadcrumbTheme] provides styling options for breadcrumb navigation
/// including separator widgets and container padding. Used with [ComponentTheme]
/// to apply consistent breadcrumb styling throughout an application.
///
/// Example:
/// ```dart
/// ComponentTheme<BreadcrumbTheme>(
///   data: BreadcrumbTheme(
///     separator: Icon(Icons.arrow_forward_ios, size: 12),
///     padding: EdgeInsets.all(8.0),
///   ),
///   child: MyBreadcrumbWidget(),
/// );
/// ```
class BreadcrumbTheme {
  /// Widget displayed between breadcrumb navigation items.
  ///
  /// Provides visual separation between breadcrumb items to indicate
  /// navigation hierarchy. When null, uses the default arrow separator.
  /// Common options include arrows, slashes, or custom icons.
  final Widget? separator;

  /// Padding applied around the entire breadcrumb row.
  ///
  /// Controls spacing around the breadcrumb container. When null,
  /// uses framework default padding or no padding.
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
  /// Predefined arrow-style separator with right-pointing chevron icon.
  ///
  /// Uses a small, muted chevron right icon with appropriate horizontal padding.
  /// This is the default separator when no custom separator is specified.
  static const Widget arrowSeparator = _ArrowSeparator();
  
  /// Predefined slash-style separator using a forward slash character.
  ///
  /// Uses a small, muted forward slash with minimal horizontal padding.
  /// Provides a more compact separator option for breadcrumb trails.
  static const Widget slashSeparator = _SlashSeparator();
  
  /// List of widgets representing the breadcrumb navigation path.
  ///
  /// Items should be ordered from root to current location. The last item
  /// is treated as the current page and styled differently from navigation items.
  /// Typically includes interactive elements like buttons for navigation items.
  final List<Widget> children;
  
  /// Custom separator widget to display between breadcrumb items.
  ///
  /// When null, uses theme separator or [arrowSeparator] as fallback.
  /// Can be any widget including icons, text, or custom graphics.
  final Widget? separator;
  
  /// Padding applied around the entire breadcrumb navigation row.
  ///
  /// When null, uses theme padding or no padding as fallback.
  /// Controls spacing around the breadcrumb container.
  final EdgeInsetsGeometry? padding;

  /// Creates a [Breadcrumb] navigation trail.
  ///
  /// The last child in the list is treated as the current location and
  /// is styled differently from the preceding navigation items.
  ///
  /// Parameters:
  /// - [children] (List<Widget>, required): breadcrumb items from root to current
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
