# CommandEmpty

A default widget displayed when command search returns no results.

## Usage

### Command Example
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';
import 'command/command_example_1.dart';

class CommandExample extends StatelessWidget {
  const CommandExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'command',
      description:
          'A command is a component that allows you to search for items.',
      displayName: 'Command',
      children: [
        WidgetUsageExample(
          title: 'Command Example',
          path: 'lib/pages/docs/components/command/command_example_1.dart',
          child: CommandExample1(),
        ),
      ],
    );
  }
}

```

### Command Example 1
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
          'Calendar': const Icon(Icons.calendar_today),
          'Search Emoji': const Icon(Icons.emoji_emotions_outlined),
          'Launch': const Icon(Icons.rocket_launch_outlined),
          'Profile': const Icon(Icons.person_outline),
          'Mail': const Icon(Icons.mail_outline),
          'Settings': const Icon(Icons.settings_outlined),
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

### Command Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/command/command_example_1.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CommandTile extends StatelessWidget implements IComponentPage {
  const CommandTile({super.key});

  @override
  String get title => 'Command';

  @override
  Widget build(BuildContext context) {
    return const ComponentCard(
      name: 'command',
      title: 'Command',
      scale: 1,
      example: CommandExample1(),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |

