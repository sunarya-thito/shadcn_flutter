import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:docs/pages/docs/components_page.dart';

class AccordionTile extends StatelessWidget implements IComponentPage {
  const AccordionTile({super.key});

  @override
  String get title => 'Accordion';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'accordion',
      title: 'Accordion',
      example: SizedBox(
        width: 280,
        child: Card(
          child: Accordion(
            items: [
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Accordion 1')),
                content: Text('Content 1'),
              ),
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Accordion 2')),
                content: Text('Content 2'),
              ),
              AccordionItem(
                trigger: AccordionTrigger(child: Text('Accordion 3')),
                content: Text('Content 3'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
