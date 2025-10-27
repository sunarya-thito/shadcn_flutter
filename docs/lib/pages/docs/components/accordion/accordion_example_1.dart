import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A minimal Accordion demo.
///
/// This example shows how to create a vertically stacked set of
/// expandable/collapsible items using [Accordion] and [AccordionItem].
///
/// Key points:
/// - [Accordion] manages the expansion state of its [items].
/// - Each [AccordionItem] defines a [trigger] (the clickable header)
///   and a [content] (the body shown when expanded).
/// - All text and layout here are simple to keep focus on the API usage.
class AccordionExample1 extends StatelessWidget {
  const AccordionExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // The Accordion itself simply receives a list of items.
    // Note: Using `const` here keeps the widget tree immutable since
    // the items are static in this example.
    return const Accordion(
      items: [
        // Item 1: Demonstrates a basic trigger and a longer content body.
        AccordionItem(
          trigger: AccordionTrigger(child: Text('Lorem ipsum dolor sit amet')),
          content: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        ),
        // Item 2: Another entry with its own header and body.
        AccordionItem(
          trigger: AccordionTrigger(
              child: Text(
                  'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua')),
          content: Text(
              'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        ),
        // Item 3: A third example to show multiple items expand independently.
        AccordionItem(
          trigger: AccordionTrigger(
              child: Text(
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat')),
          content: Text(
              'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
              'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
              'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
        ),
      ],
    );
  }
}
