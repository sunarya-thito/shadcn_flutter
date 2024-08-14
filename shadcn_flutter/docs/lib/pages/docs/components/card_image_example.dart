import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/card_image/card_image_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CardImageExample extends StatelessWidget {
  const CardImageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'card_image',
      description:
          'A card image is an interactive card that displays an image.',
      displayName: 'Card Image',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/card_image/card_image_example_1.dart',
          child: CardImageExample1(),
        ),
      ],
    );
  }
}
