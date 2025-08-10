import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme for [Timeline].
class TimelineTheme {
  /// Constraints for the time column.
  final BoxConstraints? timeConstraints;

  /// Spacing between columns.
  final double? spacing;

  /// Diameter of the timeline indicator.
  final double? dotSize;

  /// Thickness of the connector line.
  final double? connectorThickness;

  /// Default color of the indicator and connector when data color is not provided.
  final Color? color;

  /// Gap between each timeline row.
  final double? rowGap;

  const TimelineTheme({
    this.timeConstraints,
    this.spacing,
    this.dotSize,
    this.connectorThickness,
    this.color,
    this.rowGap,
  });

  TimelineTheme copyWith({
    ValueGetter<BoxConstraints?>? timeConstraints,
    ValueGetter<double?>? spacing,
    ValueGetter<double?>? dotSize,
    ValueGetter<double?>? connectorThickness,
    ValueGetter<Color?>? color,
    ValueGetter<double?>? rowGap,
  }) {
    return TimelineTheme(
      timeConstraints:
          timeConstraints == null ? this.timeConstraints : timeConstraints(),
      spacing: spacing == null ? this.spacing : spacing(),
      dotSize: dotSize == null ? this.dotSize : dotSize(),
      connectorThickness: connectorThickness == null
          ? this.connectorThickness
          : connectorThickness(),
      color: color == null ? this.color : color(),
      rowGap: rowGap == null ? this.rowGap : rowGap(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimelineTheme &&
        other.timeConstraints == timeConstraints &&
        other.spacing == spacing &&
        other.dotSize == dotSize &&
        other.connectorThickness == connectorThickness &&
        other.color == color &&
        other.rowGap == rowGap;
  }

  @override
  int get hashCode => Object.hash(
      timeConstraints, spacing, dotSize, connectorThickness, color, rowGap);
}

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
    final compTheme = ComponentTheme.maybeOf<TimelineTheme>(context);
    final timeConstraints = this.timeConstraints ??
        compTheme?.timeConstraints ??
        BoxConstraints(minWidth: 120 * scaling, maxWidth: 120 * scaling);
    final spacing = compTheme?.spacing ?? 16 * scaling;
    final dotSize = compTheme?.dotSize ?? 12 * scaling;
    final connectorThickness =
        compTheme?.connectorThickness ?? 2 * scaling;
    final defaultColor = compTheme?.color ?? theme.colorScheme.primary;
    final rowGap = compTheme?.rowGap ?? 16 * scaling;
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
            Gap(spacing),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 4 * scaling),
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: theme.radius == 0
                        ? BoxShape.rectangle
                        : BoxShape.circle,
                    color: data.color ?? defaultColor,
                  ),
                ),
                if (i != this.data.length - 1)
                  Expanded(
                    child: VerticalDivider(
                      thickness: connectorThickness,
                      color: data.color ?? defaultColor,
                      endIndent: (-4 - spacing) * scaling,
                    ),
                  ),
              ],
            ),
            Gap(spacing),
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
    ).gap(rowGap);
  }
}
