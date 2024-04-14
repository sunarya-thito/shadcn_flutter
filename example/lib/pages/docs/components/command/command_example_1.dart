import 'package:shadcn_flutter/shadcn_flutter.dart';

class CommandExample1 extends StatelessWidget {
  const CommandExample1({super.key});

  @override
  Widget build(BuildContext context) {
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
            await Future.delayed(Duration(seconds: 1));
          }
        }
      },
    ).sized(width: 300, height: 300);
  }
}
