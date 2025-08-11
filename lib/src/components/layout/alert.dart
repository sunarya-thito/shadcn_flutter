import '../../../shadcn_flutter.dart';

/// Theme for [Alert].
class AlertTheme {
  /// The padding around the alert content.
  final EdgeInsetsGeometry? padding;

  /// The background color of the alert.
  final Color? backgroundColor;

  /// The border color of the alert.
  final Color? borderColor;

  /// Creates an [AlertTheme].
  const AlertTheme({this.padding, this.backgroundColor, this.borderColor});

  /// Creates a copy of this theme with the given values replaced.
  AlertTheme copyWith({
    ValueGetter<EdgeInsetsGeometry?>? padding,
    ValueGetter<Color?>? backgroundColor,
    ValueGetter<Color?>? borderColor,
  }) {
    return AlertTheme(
      padding: padding == null ? this.padding : padding(),
      backgroundColor:
          backgroundColor == null ? this.backgroundColor : backgroundColor(),
      borderColor: borderColor == null ? this.borderColor : borderColor(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AlertTheme &&
        other.padding == padding &&
        other.backgroundColor == backgroundColor &&
        other.borderColor == borderColor;
  }

  @override
  int get hashCode => Object.hash(padding, backgroundColor, borderColor);
}

class Alert extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? content;
  final Widget? trailing;
  final bool destructive;

  const Alert(
      {super.key,
      this.leading,
      this.title,
      this.content,
      this.trailing,
      this.destructive = false});

  const Alert.destructive({
    super.key,
    this.leading,
    this.title,
    this.content,
    this.trailing,
  }) : destructive = true;

  @override
  Widget build(BuildContext context) {
    if (destructive) {
      var destructive2 = Theme.of(context).colorScheme.destructive;
      return DefaultTextStyle.merge(
        style: TextStyle(
          color: destructive2,
        ),
        child: IconTheme.merge(
          data: IconThemeData(
            color: destructive2,
          ),
          child: _build(context),
        ),
      );
    }
    return _build(context);
  }

  Widget _build(BuildContext context) {
    final theme = Theme.of(context);
    final compTheme = ComponentTheme.maybeOf<AlertTheme>(context);
    final scaling = theme.scaling;
    var scheme = theme.colorScheme;
    final padding = styleValue(
      themeValue: compTheme?.padding,
      defaultValue: EdgeInsets.symmetric(
          horizontal: 16 * scaling, vertical: 12 * scaling),
    );
    final backgroundColor = styleValue(
      themeValue: compTheme?.backgroundColor,
      defaultValue: scheme.card,
    );

    return OutlinedContainer(
      backgroundColor: backgroundColor,
      child: Container(
        padding: padding,
        child: Basic(
          leading: leading,
          title: title,
          content: content,
          trailing: trailing,
        ),
      ),
    );
  }
}
