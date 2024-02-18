import 'package:example/main.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../docs_page.dart';

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
              builder: (context) {
                return Container(
                  color: Colors.red,
                  child: Container(
                    color: Colors.green,
                    child: Container(
                      color: Colors.blue,
                      height: 20,
                    ).withPadding(all: 16),
                  ).withPadding(top: 24, bottom: 12, horizontal: 16),
                );
              },
              code: '''
      Container(
        color: Colors.red,
        child: Container(
      color: Colors.green,
      child: Container(
        color: Colors.blue,
        height: 20,
      ).withPadding(all: 16),
        ).withPadding(top: 24, bottom: 12, horizontal: 16),
      );''',
            ).p(),
            Text('Margin').h2().keyed(marginKey),
            WidgetUsageExample(
              builder: (context) {
                return Container(
                  color: Colors.red,
                  child: Container(
                    color: Colors.green,
                    child: Container(
                      color: Colors.blue,
                      height: 20,
                    ).withMargin(all: 16),
                  ).withMargin(top: 24, bottom: 12, horizontal: 16),
                );
              },
              code: '''
      Container(
        color: Colors.red,
        child: Container(
      color: Colors.green,
      child: Container(
        color: Colors.blue,
        height: 20,
      ).withMargin(all: 16),
        ).withMargin(top: 24, bottom: 12, horizontal: 16),
      );''',
            ).p(),
            Text('Center').h2().keyed(centerKey),
            WidgetUsageExample(
                    builder: (context) {
                      return Container(
                        color: Colors.red,
                        height: 30,
                        width: 30,
                      ).center();
                    },
                    code: '''
      Container(
        color: Colors.red,
        height: 30,
        width: 30,
      ).center();''')
                .p(),
            Text('Gapped Column').h2().keyed(gappedColumnKey),
            WidgetUsageExample(
              builder: (context) {
                return Column(
                  children: [
                    Text('Item 1'),
                    Text('Item 2'),
                    Text('Item 3'),
                  ],
                ).gap(32);
              },
              code: '''
      Column(
        children: [
      Text('Item 1'),
      Text('Item 2'),
      Text('Item 3'),
        ],
      ).gap(32);''',
            ).p(),
            Text('Gapped Row').h2().keyed(gappedRowKey),
            WidgetUsageExample(
              builder: (context) {
                return Row(
                  children: [
                    Text('Item 1'),
                    Text('Item 2'),
                    Text('Item 3'),
                  ],
                ).gap(32);
              },
              code: '''
      Row(
        children: [
      Text('Item 1'),
      Text('Item 2'),
      Text('Item 3'),
        ],
      ).gap(32);''',
            ).p(),
            Text('Separated Column').h2().keyed(separatedColumnKey),
            WidgetUsageExample(
              builder: (context) {
                return Column(
                  children: [
                    Text('Item 1'),
                    Text('Item 2'),
                    Text('Item 3'),
                  ],
                ).separator(Divider());
              },
              code: '''
      Column(
        children: [
      Text('Item 1'),
      Text('Item 2'),
      Text('Item 3'),
        ],
      ).separator(Divider());''',
            ).p(),
            Text('Separated Row').h2().keyed(separatedRowKey),
            WidgetUsageExample(
              builder: (context) {
                return IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(' Item 1 '),
                      Text(' Item 2 '),
                      Text(' Item 3 '),
                    ],
                  ).separator(VerticalDivider()),
                );
              },
              code: '''
      Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
      Text(' Item 1 '),
      Text(' Item 2 '),
      Text(' Item 3 '),
        ],
      ).separator(VerticalDivider());''',
            ).p(),
            Text('Basic Layout').h2().keyed(basicLayoutKey),
            WidgetUsageExample(
              builder: (context) {
                return Basic(
                  title: Text('Title'),
                  leading: Icon(Icons.star),
                  trailing: Icon(Icons.arrow_forward),
                  subtitle: Text('Subtitle'),
                  content: Text('Lorem ipsum dolor sit amet'),
                );
              },
              code: '''
      Basic(
        title: Text('Title'),
        leading: Icon(Icons.star),
        trailing: Icon(Icons.arrow_forward),
        subtitle: Text('Subtitle'),
        content: Text('Lorem ipsum dolor sit amet'),
      );''',
            ).p(),
          ]),
    );
  }
}
