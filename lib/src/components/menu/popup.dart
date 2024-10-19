import '../../../shadcn_flutter.dart';

class MenuPopup extends StatelessWidget {
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final List<Widget> children;

  const MenuPopup({
    super.key,
    this.surfaceOpacity,
    this.surfaceBlur,
    required this.children,
  });

  Widget _buildIntrinsicContainer(Widget child, Axis direction) {
    if (direction == Axis.vertical) {
      return IntrinsicWidth(child: child);
    }
    return IntrinsicHeight(child: child);
  }

  @override
  Widget build(BuildContext context) {
    final data = Data.maybeOf<MenuGroupData>(context);
    final theme = Theme.of(context);
    return OutlinedContainer(
      borderRadius: theme.borderRadiusMd,
      backgroundColor: theme.colorScheme.popover,
      borderColor: theme.colorScheme.border,
      surfaceBlur: surfaceBlur ?? theme.surfaceBlur,
      surfaceOpacity: surfaceOpacity ?? theme.surfaceOpacity,
      child: Padding(
        padding: const EdgeInsets.all(4) * theme.scaling,
        child: SingleChildScrollView(
          scrollDirection: data?.direction ?? Axis.vertical,
          child: _buildIntrinsicContainer(
            Flex(
              direction: data?.direction ?? Axis.vertical,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
            data?.direction ?? Axis.vertical,
          ),
        ),
      ),
    ).normal();
  }
}
