import '../../../shadcn_flutter.dart';

class Alert extends StatelessWidget {
  final Widget? leading;
  final Widget? title;
  final Widget? content;
  final Widget? trailing;
  final bool destructive;

  const Alert(
      {Key? key,
      this.leading,
      this.title,
      this.content,
      this.trailing,
      this.destructive = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (destructive) {
      var destructive2 = Theme.of(context).colorScheme.destructive;
      return mergeAnimatedTextStyle(
        duration: kDefaultDuration,
        style: TextStyle(
          color: destructive2,
        ),
        child: AnimatedIconTheme.merge(
          duration: kDefaultDuration,
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
    var scheme = Theme.of(context).colorScheme;
    return OutlinedContainer(
      backgroundColor: scheme.background,
      borderColor: destructive ? scheme.destructive : null,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
