import 'package:shadcn_flutter/shadcn_flutter.dart';

class Steps extends StatelessWidget {
  final List<Widget> children;

  const Steps({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    List<Widget> mapped = [];
    for (var i = 0; i < children.length; i++) {
      mapped.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.muted,
                    shape: BoxShape.circle,
                  ),
                  width: 28 * scaling,
                  height: 28 * scaling,
                  child: Center(
                    child: Text(
                      (i + 1).toString(),
                    ).mono().bold(),
                  ),
                ),
                Gap(4 * scaling),
                const Expanded(child: VerticalDivider()),
                Gap(4 * scaling),
              ],
            ),
            Gap(18 * scaling),
            Expanded(child: children[i].withPadding(bottom: 32 * scaling)),
          ],
        ),
      ));
    }
    return IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: mapped,
      ),
    );
  }
}

class StepItem extends StatelessWidget {
  final Widget title;
  final List<Widget> content;

  const StepItem({
    super.key,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        title.h4(),
        ...content,
      ],
    );
  }
}
