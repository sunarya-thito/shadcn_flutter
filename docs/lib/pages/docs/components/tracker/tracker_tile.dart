import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/tracker/tracker_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TrackerTile extends StatelessWidget implements IComponentPage {
  const TrackerTile({super.key});

  @override
  String get title => 'Tracker';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'tracker',
      title: 'Tracker',
      scale: 2,
      verticalOffset: 48,
      example: const TrackerExample1().sized(width: 500),
    );
  }
}
