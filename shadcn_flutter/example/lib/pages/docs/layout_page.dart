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
  final OnThisPage paddingKey = OnThisPage();
  final OnThisPage marginKey = OnThisPage();
  final OnThisPage centerKey = OnThisPage();
  final OnThisPage gappedColumnKey = OnThisPage();
  final OnThisPage gappedRowKey = OnThisPage();
  final OnThisPage separatedColumnKey = OnThisPage();
  final OnThisPage separatedRowKey = OnThisPage();
  final OnThisPage basicLayoutKey = OnThisPage();

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
          Text('Padding').h2().anchored(paddingKey),
          WidgetUsageExample(
            child: LayoutPageExample1(),
            path: 'lib/pages/docs/layout_page/layout_page_example_1.dart',
          ).p(),
          Text('Margin').h2().anchored(marginKey),
          WidgetUsageExample(
            child: LayoutPageExample2(),
            path: 'lib/pages/docs/layout_page/layout_page_example_2.dart',
          ).p(),
          Text('Center').h2().anchored(centerKey),
          WidgetUsageExample(
            child: LayoutPageExample3(),
            path: 'lib/pages/docs/layout_page/layout_page_example_3.dart',
          ).p(),
          Text('Gapped Row').h2().anchored(gappedRowKey),
          WidgetUsageExample(
            child: LayoutPageExample4(),
            path: 'lib/pages/docs/layout_page/layout_page_example_4.dart',
          ).p(),
          Text('Separated Column').h2().anchored(separatedColumnKey),
          WidgetUsageExample(
            child: LayoutPageExample5(),
            path: 'lib/pages/docs/layout_page/layout_page_example_5.dart',
          ).p(),
          Text('Separated Row').h2().anchored(separatedRowKey),
          WidgetUsageExample(
            child: LayoutPageExample6(),
            path: 'lib/pages/docs/layout_page/layout_page_example_6.dart',
          ).p(),
          Text('Basic Layout').h2().anchored(basicLayoutKey),
          WidgetUsageExample(
            child: LayoutPageExample7(),
            path: 'lib/pages/docs/layout_page/layout_page_example_7.dart',
          ).p(),
        ],
      ),
    );
  }
}
