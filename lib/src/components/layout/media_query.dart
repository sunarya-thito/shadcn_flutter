import '../../../shadcn_flutter.dart';

/// Theme configuration for [MediaQueryVisibility].
class MediaQueryVisibilityTheme {
  /// Minimum width at which the child is shown.
  final double? minWidth;

  /// Maximum width at which the child is shown.
  final double? maxWidth;

  /// Creates a [MediaQueryVisibilityTheme].
  const MediaQueryVisibilityTheme({this.minWidth, this.maxWidth});

  /// Creates a copy of this theme but with the given fields replaced.
  MediaQueryVisibilityTheme copyWith({
    ValueGetter<double?>? minWidth,
    ValueGetter<double?>? maxWidth,
  }) {
    return MediaQueryVisibilityTheme(
      minWidth: minWidth == null ? this.minWidth : minWidth(),
      maxWidth: maxWidth == null ? this.maxWidth : maxWidth(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MediaQueryVisibilityTheme &&
        other.minWidth == minWidth &&
        other.maxWidth == maxWidth;
  }

  @override
  int get hashCode => Object.hash(minWidth, maxWidth);
}

/// A widget that conditionally displays children based on media query constraints.
///
/// Shows [child] when the current screen width falls within the specified range
/// defined by [minWidth] and [maxWidth]. Optionally displays [alternateChild]
/// when the width is outside the range. Useful for responsive layouts.
///
/// Example:
/// ```dart
/// MediaQueryVisibility(
///   minWidth: 600,
///   maxWidth: 1200,
///   child: TabletLayout(),
///   alternateChild: MobileLayout(),
/// )
/// ```
class MediaQueryVisibility extends StatelessWidget {
  /// Minimum screen width to show [child].
  ///
  /// If `null`, no minimum constraint is applied.
  final double? minWidth;

  /// Maximum screen width to show [child].
  ///
  /// If `null`, no maximum constraint is applied.
  final double? maxWidth;

  /// Widget to display when width is within range.
  final Widget child;

  /// Widget to display when width is outside range.
  ///
  /// If `null`, nothing is displayed when outside range.
  final Widget? alternateChild;

  /// Creates a [MediaQueryVisibility].
  ///
  /// Parameters:
  /// - [minWidth] (`double?`, optional): Minimum width threshold.
  /// - [maxWidth] (`double?`, optional): Maximum width threshold.
  /// - [child] (`Widget`, required): Widget to show within range.
  /// - [alternateChild] (`Widget?`, optional): Widget to show outside range.
  const MediaQueryVisibility({
    super.key,
    this.minWidth,
    this.maxWidth,
    required this.child,
    this.alternateChild,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final compTheme =
        ComponentTheme.maybeOf<MediaQueryVisibilityTheme>(context);
    final size = mediaQuery.size.width;
    final minWidth = styleValue(
        widgetValue: this.minWidth,
        themeValue: compTheme?.minWidth,
        defaultValue: null);
    final maxWidth = styleValue(
        widgetValue: this.maxWidth,
        themeValue: compTheme?.maxWidth,
        defaultValue: null);
    if (minWidth != null && size < minWidth) {
      return SizedBox(
        child: alternateChild,
      );
    }
    if (maxWidth != null && size > maxWidth) {
      return SizedBox(
        child: alternateChild,
      );
    }
    // to prevent widget tree from changing
    return SizedBox(
      child: child,
    );
  }
}
