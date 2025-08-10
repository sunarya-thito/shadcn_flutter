import '../../../shadcn_flutter.dart';

/// Theme configuration for spinner widgets.
class SpinnerTheme {
  /// Color of the spinner elements.
  final Color? color;

  /// Size of the spinner widget.
  final double? size;

  const SpinnerTheme({this.color, this.size});

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

abstract class SpinnerTransform {}

abstract class SpinnerElement {
  void paint(Canvas canvas, Size size, Matrix4 transform);
}

abstract class Spinner extends StatelessWidget {
  final Color? color;
  final double? size;
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
