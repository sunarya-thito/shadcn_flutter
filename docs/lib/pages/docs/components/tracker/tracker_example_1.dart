import 'package:shadcn_flutter/shadcn_flutter.dart';

class TrackerExample1 extends StatefulWidget {
  const TrackerExample1({super.key});

  @override
  State<TrackerExample1> createState() => _TrackerExample1State();
}

class _TrackerExample1State extends State<TrackerExample1> {
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
