import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/tree/tree_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TreeTile extends StatelessWidget implements IComponentPage {
  const TreeTile({super.key});

  @override
  String get title => 'Tree';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'tree',
      title: 'Tree',
      scale: 1.5,
      example: TreeExample1(),
    );
  }
}
