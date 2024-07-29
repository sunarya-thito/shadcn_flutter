import 'package:shadcn_flutter/shadcn_flutter.dart';

abstract class TrackerLevel {
  static const TrackerLevel fine =
      const _SimpleTrackerLevel(Colors.green, 'Fine');
  static const TrackerLevel warning =
      const _SimpleTrackerLevel(Colors.orange, 'Warning');
  static const TrackerLevel critical =
      const _SimpleTrackerLevel(Colors.red, 'Critical');
  static const TrackerLevel unknown =
      const _SimpleTrackerLevel(Colors.gray, 'Unknown');
  // enum? no, this will allow custom implementations
  Color get color;
  String get name;
}

class _SimpleTrackerLevel implements TrackerLevel {
  @override
  final Color color;

  @override
  final String name;

  const _SimpleTrackerLevel(this.color, this.name);
}

class TrackerData {
  final Widget tooltip;
  final TrackerLevel level;

  const TrackerData({
    required this.tooltip,
    required this.level,
  });
}

class Tracker extends StatelessWidget {
  final List<TrackerData> data;

  const Tracker({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(theme.radiusMd),
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
                  height: 32,
                  color: data.level.color,
                ),
              ),
            )
        ],
      ).gap(2),
    );
  }
}
