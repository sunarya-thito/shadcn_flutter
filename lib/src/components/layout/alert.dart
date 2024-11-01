import '../../../shadcn_flutter.dart';

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
    final scaling = theme.scaling;
    var scheme = theme.colorScheme;

    return OutlinedContainer(
      backgroundColor: scheme.background,
      borderColor: destructive ? scheme.destructive : null,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 16 * scaling, vertical: 12 * scaling),
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
