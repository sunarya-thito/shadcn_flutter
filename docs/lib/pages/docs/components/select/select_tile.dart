import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class SelectTile extends StatelessWidget implements IComponentPage {
  const SelectTile({super.key});

  @override
  String get title => 'Select';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      name: 'select',
      title: 'Select',
      scale: 1.2,
      example: Card(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Select<String>(
                itemBuilder: (context, item) {
                  return Text(item);
                },
                placeholder: const Text('Select a fruit'),
                value: 'Apple',
                enabled: true,
                constraints: const BoxConstraints.tightFor(width: 300),
                popup: const SelectPopup(),
              ),
              Gap(8 * theme.scaling),
              const SizedBox(
                width: 300,
                child: SelectPopup(
                  items: SelectItemList(children: [
                    SelectItemButton(
                      value: 'Apple',
                      child: Text('Apple'),
                    ),
                    SelectItemButton(
                      value: 'Banana',
                      child: Text('Banana'),
                    ),
                    SelectItemButton(
                      value: 'Lemon',
                      child: Text('Lemon'),
                    ),
                    SelectItemButton(
                      value: 'Tomato',
                      child: Text('Tomato'),
                    ),
                    SelectItemButton(
                      value: 'Cucumber',
                      child: Text('Cucumber'),
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ).sized(height: 300, width: 200),
    );
  }
}
