import '../../../shadcn_flutter.dart';

/// Theme configuration for spinner widgets.
class SpinnerTheme {
  /// Color of the spinner elements.
  final Color? color;

  /// Size of the spinner widget.
  final double? size;

  /// Creates a [SpinnerTheme] with optional color and size.
  const SpinnerTheme({this.color, this.size});

  /// Creates a copy of this theme with selectively replaced properties.
  SpinnerTheme copyWith({
    ValueGetter<Color?>? color,
    ValueGetter<double?>? size,
  }) {
    return SpinnerTheme(
      color: color == null ? this.color : color(),
      size: size == null ? this.size : size(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is SpinnerTheme && other.color == color && other.size == size;
  }

  @override
  int get hashCode => Object.hash(color, size);
}

/// Base interface for spinner transformations.
///
/// Implementations define how spinner elements are transformed during animation.
abstract class SpinnerTransform {}

/// Base interface for spinner visual elements.
///
/// Implementations define how to paint individual spinner components like
/// dots, lines, or arcs onto the canvas.
abstract class SpinnerElement {
  /// Paints this spinner element onto the canvas.
  ///
  /// Parameters:
  /// - [canvas]: The canvas to paint on
  /// - [size]: The size of the spinner widget
  /// - [transform]: The current transformation matrix for animation
  void paint(Canvas canvas, Size size, Matrix4 transform);
}

/// Abstract base class for all spinner widgets.
///
/// [Spinner] provides common functionality for loading indicators including
/// color and size resolution from theme. Concrete implementations include
/// [CircularSpinner], [DotsSpinner], and others.
abstract class Spinner extends StatelessWidget {
  /// Optional color override for the spinner.
  ///
  /// If `null`, uses theme's spinner color or default foreground color.
  final Color? color;

  /// Optional size override for the spinner in logical pixels.
  ///
  /// If `null`, uses theme's spinner size or a default size.
  final double? size;

  /// Creates a [Spinner] with optional color and size overrides.
  const Spinner({super.key, this.color, this.size});

  /// Resolve spinner color considering theme overrides.
  Color? resolveColor(BuildContext context) {
    final compTheme = ComponentTheme.maybeOf<SpinnerTheme>(context);
    return styleValue(
        widgetValue: color, themeValue: compTheme?.color, defaultValue: null);
  }

  /// Resolve spinner size considering theme overrides and a default value.
  double resolveSize(BuildContext context, double defaultValue) {
    final compTheme = ComponentTheme.maybeOf<SpinnerTheme>(context);
    return styleValue(
        widgetValue: size,
        themeValue: compTheme?.size,
        defaultValue: defaultValue);
  }
}
