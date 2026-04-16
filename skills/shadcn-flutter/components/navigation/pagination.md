# Pagination

A navigation widget for paginated content with comprehensive page controls.

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
| `page` | `int` | The current active page number (1-indexed).  Must be between 1 and [totalPages] inclusive. |
| `totalPages` | `int` | The total number of pages available.  Must be >= 1. |
| `onPageChanged` | `ValueChanged<int>` | Callback invoked when the page changes.  Called with the new page number (1-indexed) when user navigates. |
| `maxPages` | `int` | The maximum number of page buttons to show.  When total pages exceed this number, pagination shows a subset centered around the current page. Defaults to 3. |
| `showSkipToFirstPage` | `bool` | Whether to show a button to skip to the first page.  Displays a "first page" button when `true`. Defaults to `true`. |
| `showSkipToLastPage` | `bool` | Whether to show a button to skip to the last page.  Displays a "last page" button when `true`. Defaults to `true`. |
| `hidePreviousOnFirstPage` | `bool` | Whether to hide the previous button on the first page.  When `true`, hides the "previous" button when [page] is 1. Defaults to `false`. |
| `hideNextOnLastPage` | `bool` | Whether to hide the next button on the last page.  When `true`, hides the "next" button when [page] equals [totalPages]. Defaults to `false`. |
| `showLabel` | `bool?` | Whether to show text labels on previous/next buttons.  When `true`, shows "Previous" and "Next" text along with icons. When `false`, shows only icons. If `null`, uses theme default. |
| `gap` | `double?` | Spacing between pagination controls in logical pixels.  If `null`, uses theme default spacing. |
