import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';
import '../card/card_example_1.dart';

class CardTile extends StatelessWidget implements IComponentPage {
  const CardTile({super.key});

  @override
  String get title => 'Card';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'card',
      title: 'Card',
      example: CardExample1(),
    );
  }
}
