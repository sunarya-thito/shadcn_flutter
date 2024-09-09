import 'package:shadcn_flutter/shadcn_flutter.dart';

class TrackerExample1 extends StatelessWidget {
  const TrackerExample1({super.key});
  @override
  Widget build(BuildContext context) {
    List<TrackerData> data = [];
    for (int i = 0; i < 80; i++) {
      data.add(const TrackerData(
        tooltip: Text('Tracker Fine'),
        level: TrackerLevel.fine,
      ));
    }
    data[40] = data[35] = const TrackerData(
      tooltip: Text('Tracker Warning'),
      level: TrackerLevel.warning,
    );
    data[60] = data[68] = data[72] = const TrackerData(
      tooltip: Text('Tracker Critical'),
      level: TrackerLevel.critical,
    );
    for (int i = 8; i < 16; i++) {
      data[i] = const TrackerData(
        tooltip: Text('Tracker Unknown'),
        level: TrackerLevel.unknown,
      );
    }
    return Tracker(data: data);
  }
}
