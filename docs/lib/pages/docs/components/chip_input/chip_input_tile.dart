import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ChipInputTile extends StatelessWidget implements IComponentPage {
  const ChipInputTile({super.key});

  @override
  String get title => 'Chip Input';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'chip_input',
      title: 'Chip Input',
      scale: 1,
      example: Card(
        child: SizedBox(
          width: 300,
          height: 300,
          child: OutlinedContainer(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  children: [
                    // Empty for now - chip input components would go here
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
