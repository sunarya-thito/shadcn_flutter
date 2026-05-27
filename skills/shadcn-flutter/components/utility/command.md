# Command

Interactive command palette with search functionality and dynamic results.

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
- **Real-time search**: Dynamic filtering with configurable debounce timing
- **Keyboard navigation**: Full arrow key and Enter/Escape support
- **Async data loading**: Stream-based results with loading and error states
- **Customizable states**: Custom builders for empty, loading, and error states
- **Auto-focus**: Optional automatic focus on the search input
- **Accessibility**: Screen reader friendly with proper focus management
- Quick action selection (Cmd+K style interfaces)
- Searchable option lists
- Dynamic content filtering
- Command-driven workflows

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `autofocus` | `bool` | Whether the search input should be auto-focused when the command palette opens.  Defaults to `true` for convenient keyboard-driven interaction. |
| `builder` | `CommandBuilder` | Async builder function that provides search results based on the query.  Receives the current search query string and should return a stream of widget lists representing the filtered command results. |
| `debounceDuration` | `Duration` | Debounce duration for search input to prevent excessive rebuilds.  The builder is called only after the user stops typing for this duration, reducing unnecessary API calls or computations. Defaults to 500ms. |
| `emptyBuilder` | `WidgetBuilder?` | Custom widget builder for displaying empty search results.  If `null`, displays a default "No results" message via [CommandEmpty]. |
| `errorBuilder` | `ErrorWidgetBuilder?` | Custom widget builder for displaying error states.  Receives the error object and stack trace for custom error presentation. |
| `loadingBuilder` | `WidgetBuilder?` | Custom widget builder for displaying loading state while fetching results.  If `null`, displays a default loading spinner. |
| `surfaceOpacity` | `double?` | Optional opacity override for the command palette surface.  When provided, overrides the theme's default surface opacity. |
| `surfaceBlur` | `double?` | Optional blur amount override for the command palette surface backdrop.  When provided, overrides the theme's default surface blur. |
| `searchPlaceholder` | `Widget?` | Optional custom placeholder widget for the search input field.  If `null`, displays default localized placeholder text. |
