import '../../../shadcn_flutter.dart';

class MenuPopup extends StatelessWidget {
  final List<Widget> children;

  MenuPopup({required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedContainer(
      borderRadius: theme.radiusMd,
      backgroundColor: theme.colorScheme.popover,
      borderColor: theme.colorScheme.border,
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: IntrinsicWidth(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children,
          ),
        ),
      ),
    ).normal();
  }
}
