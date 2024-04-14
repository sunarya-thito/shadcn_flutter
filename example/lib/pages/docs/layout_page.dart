import 'package:example/main.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../docs_page.dart';
import 'layout_page/layout_page_example_1.dart';
import 'layout_page/layout_page_example_2.dart';
import 'layout_page/layout_page_example_3.dart';
import 'layout_page/layout_page_example_4.dart';
import 'layout_page/layout_page_example_5.dart';
import 'layout_page/layout_page_example_6.dart';
import 'layout_page/layout_page_example_7.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  final GlobalKey paddingKey = GlobalKey();
  final GlobalKey marginKey = GlobalKey();
  final GlobalKey centerKey = GlobalKey();
  final GlobalKey gappedColumnKey = GlobalKey();
  final GlobalKey gappedRowKey = GlobalKey();
  final GlobalKey separatedColumnKey = GlobalKey();
  final GlobalKey separatedRowKey = GlobalKey();
  final GlobalKey basicLayoutKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'layout',
      onThisPage: {
        'Padding': paddingKey,
        'Margin': marginKey,
        'Center': centerKey,
        'Gapped Column': gappedColumnKey,
        'Gapped Row': gappedRowKey,
        'Separated Column': separatedColumnKey,
        'Separated Row': separatedRowKey,
        'Basic Layout': basicLayoutKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Layout Page').h1(),
          Text('Guide to layout in Shadcn Flutter.').lead(),
          Text('Padding').h2().keyed(paddingKey),
          WidgetUsageExample(
            child: LayoutPageExample1(),
            path: 'lib/pages/docs/layout_page/layout_page_example_1.dart',
          ).p(),
          Text('Margin').h2().keyed(marginKey),
          WidgetUsageExample(
            child: LayoutPageExample2(),
            path: 'lib/pages/docs/layout_page/layout_page_example_2.dart',
          ).p(),
          Text('Center').h2().keyed(centerKey),
          WidgetUsageExample(
            child: LayoutPageExample3(),
            path: 'lib/pages/docs/layout_page/layout_page_example_3.dart',
          ).p(),
          Text('Gapped Row').h2().keyed(gappedRowKey),
          WidgetUsageExample(
            child: LayoutPageExample4(),
            path: 'lib/pages/docs/layout_page/layout_page_example_4.dart',
          ).p(),
          Text('Separated Column').h2().keyed(separatedColumnKey),
          WidgetUsageExample(
            child: LayoutPageExample5(),
            path: 'lib/pages/docs/layout_page/layout_page_example_5.dart',
          ).p(),
          Text('Separated Row').h2().keyed(separatedRowKey),
          WidgetUsageExample(
            child: LayoutPageExample6(),
            path: 'lib/pages/docs/layout_page/layout_page_example_6.dart',
          ).p(),
          Text('Basic Layout').h2().keyed(basicLayoutKey),
          WidgetUsageExample(
            child: LayoutPageExample7(),
            path: 'lib/pages/docs/layout_page/layout_page_example_7.dart',
          ).p(),
        ],
      ),
    );
  }
}
