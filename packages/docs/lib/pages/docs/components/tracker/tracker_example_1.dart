import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a Tracker strip with varying levels (fine/warning/critical)
// and per-cell tooltips, similar to a heatmap timeline.

class TrackerExample1 extends StatefulWidget {
  const TrackerExample1({super.key});

  @override
  State<TrackerExample1> createState() => _TrackerExample1State();
}

class _TrackerExample1State extends State<TrackerExample1> {
  @override
  Widget build(BuildContext context) {
    // Build a simple sequence of tracker cells with different severity levels.
    List<TrackerData> data = [];
    for (int i = 0; i < 80; i++) {
      data.add(const TrackerData(
        tooltip: Text('Tracker Fine'),
        level: TrackerLevel.fine,
      ));
    }
    // Mark some indices as warnings.
    data[40] = data[35] = const TrackerData(
      tooltip: Text('Tracker Warning'),
      level: TrackerLevel.warning,
    );
    // And a few as critical.
    data[60] = data[68] = data[72] = const TrackerData(
      tooltip: Text('Tracker Critical'),
      level: TrackerLevel.critical,
    );
    // Unknown levels to show a broader legend.
    for (int i = 8; i < 16; i++) {
      data[i] = const TrackerData(
        tooltip: Text('Tracker Unknown'),
        level: TrackerLevel.unknown,
      );
    }
    // Tracker renders a compact heatmap-like strip with tooltips per cell.
    return Tracker(data: data);
  }
}
