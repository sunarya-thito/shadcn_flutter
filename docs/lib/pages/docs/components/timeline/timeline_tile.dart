import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/timeline/timeline_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TimelineTile extends StatelessWidget implements IComponentPage {
  const TimelineTile({super.key});

  @override
  String get title => 'Timeline';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'timeline',
      title: 'Timeline',
      scale: 1,
      example: const TimelineExample1().sized(width: 700, height: 800),
    );
  }
}
