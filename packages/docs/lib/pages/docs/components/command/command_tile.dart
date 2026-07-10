import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/command/command_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CommandTile extends StatelessWidget implements IComponentPage {
  const CommandTile({super.key});

  @override
  String get title => 'Command';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'command',
      title: 'Command',
      scale: 1,
      example: CommandExample1(),
    );
  }
}
