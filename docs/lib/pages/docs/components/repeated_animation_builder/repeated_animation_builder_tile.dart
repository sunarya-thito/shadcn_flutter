import 'dart:math';
import 'package:flutter/material.dart' as material;
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class RepeatedAnimationBuilderTile extends StatelessWidget
    implements IComponentPage {
  const RepeatedAnimationBuilderTile({super.key});

  @override
  String get title => 'Repeated Animation Builder';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'repeated_animation_builder',
      title: 'Repeated Animation Builder',
      scale: 2,
      horizontalOffset: 80,
      example: RepeatedAnimationBuilder(
        duration: const Duration(seconds: 1),
        start: 0.0,
        end: 90.0,
        builder: (context, value, child) {
          return Transform.rotate(
            angle: pi / 180 * value,
            child: Container(
              width: 100,
              height: 100,
              color: material.Colors.red,
            ),
          );
        },
      ),
    );
  }
}
