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

  /// Creates a [StepsTheme].
  const StepsTheme({
    this.indicatorSize,
    this.spacing,
    this.indicatorColor,
    this.connectorThickness,
  });

  /// Creates a copy of this theme with the given fields replaced.
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

/// Vertical step progression widget with numbered indicators and connectors.
///
/// A layout widget that displays a vertical sequence of steps, each with a
/// numbered circular indicator connected by lines. Ideal for showing progress
/// through multi-step processes, tutorials, or workflows.
///
/// ## Features
///
/// - **Numbered indicators**: Circular indicators with automatic step numbering
/// - **Connector lines**: Visual lines connecting consecutive steps
/// - **Flexible content**: Each step can contain any widget content
/// - **Responsive theming**: Customizable indicator size, spacing, and colors
/// - **Intrinsic sizing**: Automatically adjusts to content height
///
/// The widget automatically numbers each step starting from 1 and connects
/// them with vertical lines. Each step's content is placed to the right of
/// its indicator.
///
/// Example:
/// ```dart
/// Steps(
///   children: [
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Create Account', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Sign up with your email address'),
///       ],
///     ),
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Verify Email', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Check your inbox for verification'),
///       ],
///     ),
///     Column(
///       crossAxisAlignment: CrossAxisAlignment.start,
///       children: [
///         Text('Complete Profile', style: TextStyle(fontWeight: FontWeight.bold)),
///         Text('Add your personal information'),
///       ],
///     ),
///   ],
/// );
/// ```
class Steps extends StatelessWidget {
  /// List of widgets representing each step in the sequence.
  ///
  /// Each widget will be displayed with an automatically numbered
  /// circular indicator showing its position in the sequence.
  final List<Widget> children;

  /// Creates a [Steps] widget.
  ///
  /// Each child widget represents one step in the sequence and will be
  /// displayed with an automatically numbered circular indicator.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): list of widgets representing each step
  ///
  /// Example:
  /// ```dart
  /// Steps(
  ///   children: [
  ///     Text('First step content'),
  ///     Text('Second step content'),
  ///     Text('Third step content'),
  ///   ],
  /// )
  /// ```
  const Steps({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    final compTheme = ComponentTheme.maybeOf<StepsTheme>(context);
    final indicatorSize = compTheme?.indicatorSize ?? 28 * scaling;
    final spacing = compTheme?.spacing ?? 18 * scaling;
    final indicatorColor = compTheme?.indicatorColor ?? theme.colorScheme.muted;
    final connectorThickness = compTheme?.connectorThickness ?? 1 * scaling;
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

/// A vertical step indicator widget that displays a step's title and content.
///
/// Typically used as children within [Steps] to create a multi-step
/// process visualization. Displays a title in bold followed by content items.
///
/// Example:
/// ```dart
/// StepItem(
///   title: Text('Step Title'),
///   content: [
///     Text('Step description'),
///     Text('Additional details'),
///   ],
/// )
/// ```
class StepItem extends StatelessWidget {
  /// The title of this step, displayed prominently.
  final Widget title;

  /// List of content widgets to display under the title.
  final List<Widget> content;

  /// Creates a [StepItem].
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
