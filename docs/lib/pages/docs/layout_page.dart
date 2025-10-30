import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../docs_page.dart';
import 'layout_page/layout_page_example_1.dart';
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
          const Text('Layout Page').h1(),
          const Text('Guide to layout in Shadcn Flutter.').lead(),
          const Text('Padding').h2().anchored(paddingKey),
          const WidgetUsageExample(
            path: 'lib/pages/docs/layout_page/layout_page_example_1.dart',
            child: LayoutPageExample1(),
          ).p(),
          const Text('Center').h2().anchored(centerKey),
          const WidgetUsageExample(
            path: 'lib/pages/docs/layout_page/layout_page_example_3.dart',
            child: LayoutPageExample3(),
          ).p(),
          const Text('Gapped Row').h2().anchored(gappedRowKey),
          const WidgetUsageExample(
            path: 'lib/pages/docs/layout_page/layout_page_example_4.dart',
            child: LayoutPageExample4(),
          ).p(),
          const Text('Separated Column').h2().anchored(separatedColumnKey),
          const WidgetUsageExample(
            path: 'lib/pages/docs/layout_page/layout_page_example_5.dart',
            child: LayoutPageExample5(),
          ).p(),
          const Text('Separated Row').h2().anchored(separatedRowKey),
          const WidgetUsageExample(
            path: 'lib/pages/docs/layout_page/layout_page_example_6.dart',
            child: LayoutPageExample6(),
          ).p(),
          const Text('Basic Layout').h2().anchored(basicLayoutKey),
          const WidgetUsageExample(
            path: 'lib/pages/docs/layout_page/layout_page_example_7.dart',
            child: LayoutPageExample7(),
          ).p(),
        ],
      ),
    );
  }
}
