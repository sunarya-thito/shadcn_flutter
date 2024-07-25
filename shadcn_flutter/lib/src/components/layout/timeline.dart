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
  final BoxConstraints timeConstraints;

  const Timeline({
    super.key,
    required this.data,
    this.timeConstraints = const BoxConstraints(
      minWidth: 120,
      maxWidth: 120,
    ),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    List<Widget> rows = [];
    for (int i = 0; i < data.length; i++) {
      final data = this.data[i];
      rows.add(IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ConstrainedBox(
              constraints: timeConstraints,
              child: Align(
                alignment: Alignment.topRight,
                child: data.time.medium().small(),
              ),
            ),
            gap(16),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 4),
                  width: 12,
                  height: 12,
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
                      thickness: 2,
                      color: data.color ?? theme.colorScheme.primary,
                      endIndent: -4 - 16,
                    ),
                  ),
              ],
            ),
            gap(16),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  data.title
                      .semiBold()
                      .secondaryForeground()
                      .base()
                      .withPadding(left: 4),
                  if (data.content != null) gap(8),
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
    ).gap(16);
  }
}
