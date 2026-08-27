---
title: "Example: components/command/command_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CommandExample1 extends StatelessWidget {
  const CommandExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Command(
      // The builder is an async generator producing lists of CommandCategory
      // based on the current search query. Each yield updates the UI.
      builder: (context, query) async* {
        Map<String, List<String>> items = {
          'Suggestions': ['Calendar', 'Search Emoji', 'Launch'],
          'Settings': ['Profile', 'Mail', 'Settings'],
        };
        Map<String, Widget> icons = {
          'Calendar': const Icon(LucideIcons.calendar),
          'Search Emoji': const Icon(LucideIcons.smile),
          'Launch': const Icon(LucideIcons.rocket),
          'Profile': const Icon(LucideIcons.user),
          'Mail': const Icon(LucideIcons.mail),
          'Settings': const Icon(LucideIcons.settings),
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
            // Simulate latency to showcase incremental results.
            await Future.delayed(const Duration(seconds: 1));
            yield [
              CommandCategory(
                title: Text(values.key),
                children: resultItems,
              ),
            ];
          }
        }
      },
    ).sized(width: 300, height: 300);
  }
}

```
