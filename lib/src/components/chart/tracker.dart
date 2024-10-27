import 'package:shadcn_flutter/shadcn_flutter.dart';

/// An abstract class that holds values for different Tracker levels.
///
/// This class defines the color and name for each [TrackerLevel].
///
/// For example [TrackerLevel.fine] holds two values:
/// - [name] which is set to `"Fine"`
/// - [color] which is set to `Colors.green`
abstract class TrackerLevel {
  /// Default values for the fine level.
  ///
  /// [color] is set to `Colors.green`
  /// [name] is set to `"Fine"`
  static const TrackerLevel fine = _SimpleTrackerLevel(Colors.green, 'Fine');

  /// Default values for the warning level.
  ///
  /// [color] is set to `Colors.orange`
  /// [name] is set to `"Warning"`
  static const TrackerLevel warning =
      _SimpleTrackerLevel(Colors.orange, 'Warning');

  /// Default values for the critical level.
  ///
  /// [color] is set to `Colors.red`
  /// [name] is set to `"Critical"`
  static const TrackerLevel critical =
      _SimpleTrackerLevel(Colors.red, 'Critical');

  /// Default values for the unknown level.
  ///
  /// [color] is set to `Colors.gray`
  /// [name] is set to `"Unknown"`
  static const TrackerLevel unknown =
      _SimpleTrackerLevel(Colors.gray, 'Unknown');
  // enum? no, this will allow custom implementations
  /// Gets the color for the specified [TrackerLevel].
  Color get color;

  /// Gets the name for the specified [TrackerLevel].
  String get name;
}

class _SimpleTrackerLevel implements TrackerLevel {
  @override
  final Color color;

  @override
  final String name;

  const _SimpleTrackerLevel(this.color, this.name);
}

/// A class that holds data for a tracker.
///
/// This class holds a [tooltip] and a tracker level [level].
class TrackerData {
  /// The tooltip for the tracker.
  ///
  /// This field stores the tooltip associated with the tracker.
  /// The tooltip is displayed when the user hovers over the tracker.
  final Widget tooltip;

  /// The tracker level.
  ///
  /// This field stores the tracker level associated with the tracker.
  /// The tracker level determines the color and name of the tracker.
  final TrackerLevel level;

  /// Creates a new [TrackerData] instance.
  /// requires two parameters:
  /// [tooltip] is the tooltip for the tracker.
  /// [level] is the tracker level.
  ///
  /// This constructor initializes a new instance of [TrackerData]
  /// with the specified tooltip and tracker level.
  const TrackerData({
    required this.tooltip,
    required this.level,
  });
}

class TrackerTheme {
  final double? radius;
  final double? gap;
  final double? itemHeight;

  const TrackerTheme({
    this.radius,
    this.gap,
    this.itemHeight,
  });

  TrackerTheme copyWith({
    double? radius,
    double? gap,
    double? itemHeight,
  }) {
    return TrackerTheme(
      radius: radius ?? this.radius,
      gap: gap ?? this.gap,
      itemHeight: itemHeight ?? this.itemHeight,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrackerTheme &&
        other.radius == radius &&
        other.gap == gap &&
        other.itemHeight == itemHeight;
  }

  @override
  int get hashCode => Object.hash(
        radius,
        gap,
        itemHeight,
      );

  @override
  String toString() =>
      'TrackerTheme(radius: $radius, gap: $gap, itemHeight: $itemHeight)';
}

/// A widget that displays a tracker.
///
/// This widget displays a row of tracker levels with tooltips.
/// The row contains a tracker level for each tracker in the [data] list.
class Tracker extends StatelessWidget {
  /// The data for the tracker.
  ///
  /// This field stores the data associated with the tracker.
  /// The data includes the tooltip and tracker level for each tracker.
  final List<TrackerData> data;

  /// Creates a new [Tracker] instance.
  ///
  /// [data] is the data for the tracker, which is a list of [TrackerData].
  ///
  /// This constructor initializes a new instance of [Tracker]
  /// with the specified data.
  const Tracker({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trackerTheme = ComponentTheme.maybeOf<TrackerTheme>(context);
    return ClipRRect(
      borderRadius:
          BorderRadius.circular(trackerTheme?.radius ?? theme.radiusMd),
      child: Row(
        children: [
          for (final data in this.data)
            Expanded(
              child: InstantTooltip(
                tooltipBuilder: (context) {
                  return TooltipContainer(
                    child: data.tooltip,
                  );
                },
                child: Container(
                  height: trackerTheme?.itemHeight ?? 32,
                  color: data.level.color,
                ),
              ),
            )
        ],
      ).gap(trackerTheme?.gap ?? theme.scaling * 2),
    );
  }
}
