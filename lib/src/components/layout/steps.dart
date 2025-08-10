import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Theme for [Steps].
class StepsTheme {
  /// Diameter of the step indicator circle.
  final double? indicatorSize;

  /// Gap between the indicator and the step content.
  final double? spacing;

  /// Color of the indicator and connector line.
  final Color? indicatorColor;

  /// Thickness of the connector line.
  final double? connectorThickness;

  const StepsTheme({
    this.indicatorSize,
    this.spacing,
    this.indicatorColor,
    this.connectorThickness,
  });

  StepsTheme copyWith({
    ValueGetter<double?>? indicatorSize,
    ValueGetter<double?>? spacing,
    ValueGetter<Color?>? indicatorColor,
    ValueGetter<double?>? connectorThickness,
  }) {
    return StepsTheme(
      indicatorSize:
          indicatorSize == null ? this.indicatorSize : indicatorSize(),
      spacing: spacing == null ? this.spacing : spacing(),
      indicatorColor:
          indicatorColor == null ? this.indicatorColor : indicatorColor(),
      connectorThickness: connectorThickness == null
          ? this.connectorThickness
          : connectorThickness(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepsTheme &&
        other.indicatorSize == indicatorSize &&
        other.spacing == spacing &&
        other.indicatorColor == indicatorColor &&
        other.connectorThickness == connectorThickness;
  }

  @override
  int get hashCode =>
      Object.hash(indicatorSize, spacing, indicatorColor, connectorThickness);
}

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
    final compTheme = ComponentTheme.maybeOf<StepsTheme>(context);
    final indicatorSize =
        compTheme?.indicatorSize ?? 28 * scaling;
    final spacing = compTheme?.spacing ?? 18 * scaling;
    final indicatorColor =
        compTheme?.indicatorColor ?? theme.colorScheme.muted;
    final connectorThickness =
        compTheme?.connectorThickness ?? 1 * scaling;
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
                    color: indicatorColor,
                    shape: BoxShape.circle,
                  ),
                  width: indicatorSize,
                  height: indicatorSize,
                  child: Center(
                    child: Text(
                      (i + 1).toString(),
                    ).mono().bold(),
                  ),
                ),
                Gap(4 * scaling),
                Expanded(
                    child: VerticalDivider(
                  thickness: connectorThickness,
                  color: indicatorColor,
                )),
                Gap(4 * scaling),
              ],
            ),
            Gap(spacing),
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
