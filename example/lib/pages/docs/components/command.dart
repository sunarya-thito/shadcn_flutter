import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CommandExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'command',
      description:
          'A command is a component that allows you to search for items.',
      displayName: 'Command',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return Command(
              builder: (context, query) async* {
                Map<String, List<String>> items = {
                  'Suggestions': ['Calendar', 'Search Emoji', 'Launch'],
                  'Settings': ['Profile', 'Mail', 'Settings'],
                };
                Map<String, Widget> icons = {
                  'Calendar': Icon(Icons.calendar_today),
                  'Search Emoji': Icon(Icons.emoji_emotions_outlined),
                  'Launch': Icon(Icons.rocket_launch_outlined),
                  'Profile': Icon(Icons.person_outline),
                  'Mail': Icon(Icons.mail_outline),
                  'Settings': Icon(Icons.settings_outlined),
                };
                for (final values in items.entries) {
                  List<Widget> resultItems = [];
                  for (final item in values.value) {
                    if (query == null ||
                        item.toLowerCase().contains(query.toLowerCase())) {
                      resultItems.add(CommandItem(
                        title: Text(item),
                        leading: icons[item],
                        onTap: () {},
                      ));
                    }
                  }
                  if (resultItems.isNotEmpty) {
                    yield [
                      CommandCategory(
                        title: Text(values.key),
                        children: resultItems,
                      ),
                    ];
                    // simulate loading
                    await Future.delayed(Duration(seconds: 1));
                  }
                }
              },
            ).sized(width: 300, height: 300);
          },
          code: '',
        ),
      ],
    );
  }
}
