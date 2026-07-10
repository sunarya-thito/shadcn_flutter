import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/breadcrumb/breadcrumb_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class BreadcrumbTile extends StatelessWidget implements IComponentPage {
  const BreadcrumbTile({super.key});

  @override
  String get title => 'Breadcrumb';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      title: 'Breadcrumb',
      name: 'breadcrumb',
      example: BreadcrumbExample1(),
    );
  }
}
