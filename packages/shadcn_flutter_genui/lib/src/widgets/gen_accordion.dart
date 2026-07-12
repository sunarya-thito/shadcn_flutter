import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';
import 'package:shadcn_flutter_genui/src/widgets/gen_text.dart';

class GenAccordionSchema extends GenSchema {
  late final GenField<List<String>> titles;
  late final GenField<List<Widget>> bodies;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    titles = descriptor.list(
      'titles',
      label: 'Section titles',
      item: descriptor.string('titleItem', label: 'Title'),
      example: ['What is this?', 'How does it work?'],
    );
    bodies = descriptor.widgetList(
      'bodies',
      label: 'Section bodies',
      example: [
        TextSchema.new.withExample(
          (s) => s.text.example = 'An AI-generated accordion.',
        ),
        TextSchema.new.withExample(
          (s) => s.text.example = 'Each section is its own widget.',
        ),
      ],
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final sectionTitles = titles[context];
    final sectionBodies = bodies[context];
    final count = sectionTitles.length < sectionBodies.length
        ? sectionTitles.length
        : sectionBodies.length;
    return Accordion(
      items: [
        for (var i = 0; i < count; i++)
          AccordionItem(
            trigger: AccordionTrigger(child: Text(sectionTitles[i])),
            content: sectionBodies[i],
          ),
      ],
    );
  }
}

const genAccordion = GenCatalogItem(
  name: 'Accordion',
  label: 'A vertically stacked set of collapsible sections, each with a title and body.',
  schema: GenAccordionSchema.new,
);
