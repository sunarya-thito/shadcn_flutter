import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class AccordionExample extends StatelessWidget {
  const AccordionExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'accordion',
      description: 'An accordion is a vertically stacked list of items. '
          'Each item can be "expanded" or "collapsed" to reveal the content associated with that item.',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return Accordion(
              items: [
                AccordionItem(
                  trigger: AccordionTrigger(
                      child: Text('Lorem ipsum dolor sit amet')),
                  content: Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
                      'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'),
                ),
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
          },
          code: '''
Accordion(
  items: [
    AccordionItem(
      trigger: AccordionTrigger(
        child: Text('Lorem ipsum dolor sit amet')
      ),
      content: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ),
    ),
    AccordionItem(
      trigger: AccordionTrigger(
        child: Text('Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua')
      ),
      content: Text(
        'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ),
    ),
    AccordionItem(
      trigger: AccordionTrigger(
        child: Text('Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat')
      ),
      content: Text(
        'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. '
        'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
        'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
      ),
    ),
  ],
)''',
        )
      ],
      displayName: 'Accordion',
    );
  }
}
