import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimelineData {
  final Widget time;
  final Widget title;
  final Widget? content;
  final Color? color;

  TimelineData({
    required this.time,
    required this.title,
    this.content,
    this.color,
  });
}

class Timeline extends StatelessWidget {
  final List<TimelineData> data;
  final BoxConstraints? timeConstraints;

  const Timeline({
    super.key,
    required this.data,
    // this.timeConstraints = const BoxConstraints(
    //   minWidth: 120,
    //   maxWidth: 120,
    // ),
    this.timeConstraints,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    List<Widget> rows = [];
    for (int i = 0; i < data.length; i++) {
      final data = this.data[i];
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: timeConstraints ??
                  BoxConstraints(
                    minWidth: 120 * scaling,
                    maxWidth: 120 * scaling,
                  ),
              child: Align(
                alignment: Alignment.topRight,
                child: data.time.medium().small(),
              ),
            ),
            Gap(16 * scaling),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4 * scaling),
                  width: 12 * scaling,
                  height: 12 * scaling,
                  decoration: BoxDecoration(
                    shape: theme.radius == 0
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    color: data.color ?? theme.colorScheme.primary,
                  ),
                ),
                if (i != this.data.length - 1)
                  Expanded(
                    child: VerticalDivider(
                      thickness: 2 * scaling,
                      color: data.color ?? theme.colorScheme.primary,
                      endIndent: (-4 - 16) * scaling,
                    ),
                  ),
              ],
            ),
            Gap(16 * scaling),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  data.title
                      .semiBold()
                      .secondaryForeground()
                      .base()
                      .withPadding(left: 4 * scaling),
                  if (data.content != null) Gap(8 * scaling),
                  if (data.content != null)
                    Expanded(child: data.content!.muted().small()),
                ],
              ),
            )
          ],
        ),
      ));
    }
    return Column(
      children: rows,
    ).gap(16 * scaling);
  }
}
