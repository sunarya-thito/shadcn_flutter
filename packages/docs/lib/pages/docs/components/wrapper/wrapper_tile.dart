import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WrapperTile extends StatelessWidget implements IComponentPage {
  const WrapperTile({super.key});

  @override
  String get title => 'ShadcnLayer';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'ShadcnLayer',
      name: 'wrapper',
      fit: true,
      example: SizedBox(
        width: 280,
        height: 180,
        child: OutlinedContainer(
          child: Scaffold(
            headers: const [
              AppBar(title: Text('My App')),
              Divider(),
            ],
            child: const Center(
              child: Text('Hello, Shadcn Flutter!'),
            ),
          ),
        ),
      ),
    );
  }
}
