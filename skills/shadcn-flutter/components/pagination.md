# PaginationTheme

Theme data for customizing [Pagination] widget appearance.

## Usage

### Pagination Example
```dart
import 'package:docs/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:flutter/widgets.dart';

import '../../widget_usage_example.dart';
import '../component_page.dart';

class PaginationExample extends StatelessWidget {
  const PaginationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'pagination',
      description:
          'A pagination component is used to navigate through a series of pages.',
      displayName: 'Pagination',
      children: [
        WidgetUsageExample(
          title: 'Pagination Example',
          path:
              'lib/pages/docs/components/pagination/pagination_example_1.dart',
          child: PaginationExample1(),
        ),
      ],
    );
  }
}

```

### Pagination Example 1
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PaginationExample1 extends StatefulWidget {
  const PaginationExample1({super.key});

  @override
  State<PaginationExample1> createState() => _PaginationExample1State();
}

class _PaginationExample1State extends State<PaginationExample1> {
  int page = 1;
  @override
  Widget build(BuildContext context) {
    return Pagination(
      page: page,
      totalPages: 20,
      // Limit how many page buttons are visible at once (rest via ellipsis).
      onPageChanged: (value) {
        setState(() {
          page = value;
        });
      },
      maxPages: 3,
    );
  }
}

```

### Pagination Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PaginationTile extends StatelessWidget implements IComponentPage {
  const PaginationTile({super.key});

  @override
  String get title => 'Pagination';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Pagination',
      name: 'pagination',
      reverse: true,
      example: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Card(child: PaginationExample1()),
          Transform.translate(
              offset: const Offset(250, 0),
              child: const Card(child: PaginationExample1())),
        ],
      ).gap(16),
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
| `gap` | `double?` | The spacing between pagination controls. |
| `showLabel` | `bool?` | Whether to show the previous/next labels. |
