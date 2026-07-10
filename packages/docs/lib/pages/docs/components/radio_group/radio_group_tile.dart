import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class RadioGroupTile extends StatelessWidget implements IComponentPage {
  const RadioGroupTile({super.key});

  @override
  String get title => 'Radio Group';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'radio_group',
      title: 'Radio Group',
      scale: 2,
      example: Card(
        child: RadioGroup<int>(
          value: 1,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioItem<int>(
                trailing: Text('Option 1'),
                value: 0,
              ),
              RadioItem<int>(
                trailing: Text('Option 2'),
                value: 1,
              ),
              RadioItem<int>(
                trailing: Text('Option 3'),
                value: 2,
              ),
            ],
          ).gap(4),
        ).sized(width: 300),
      ),
    );
  }
}
