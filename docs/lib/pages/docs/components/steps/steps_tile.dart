import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StepsTile extends StatelessWidget implements IComponentPage {
  const StepsTile({super.key});

  @override
  String get title => 'Steps';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'steps',
      title: 'Steps',
      example: Card(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: const Steps(children: [
          StepItem(
            title: Text('Create a project'),
            content: [
              Text('Create a new flutter project'),
            ],
          ),
          StepItem(
            title: Text('Add dependencies'),
            content: [
              Text('Add dependencies to pubspec.yaml'),
            ],
          ),
          StepItem(
            title: Text('Run the project'),
            content: [
              Text('Run the project using flutter run'),
            ],
          ),
        ]),
      ),
    );
  }
}
