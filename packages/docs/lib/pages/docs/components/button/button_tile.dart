import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class ButtonTile extends StatelessWidget implements IComponentPage {
  const ButtonTile({super.key});

  @override
  String get title => 'Button';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'button',
      title: 'Button',
      scale: 1.5,
      example: SizedBox(
        width: 250,
        child: Card(
          child: Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              PrimaryButton(
                onPressed: () {},
                child: const Text('Primary'),
              ),
              SecondaryButton(
                onPressed: () {},
                child: const Text('Secondary'),
              ),
              OutlineButton(
                onPressed: () {},
                child: const Text('Outline'),
              ),
              GhostButton(
                onPressed: () {},
                child: const Text('Ghost'),
              ),
              DestructiveButton(
                child: const Text('Destructive'),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
