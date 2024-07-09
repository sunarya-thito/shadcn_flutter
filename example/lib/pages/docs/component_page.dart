import 'package:example/pages/docs_page.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../widget_usage_example.dart';

class ComponentPage extends StatefulWidget {
  final String name;
  final String displayName;
  final String description;

  final List<Widget> children;
  const ComponentPage({
    Key? key,
    required this.name,
    required this.description,
    required this.displayName,
    required this.children,
  }) : super(key: key);

  @override
  State<ComponentPage> createState() => _ComponentPageState();
}

class _ComponentPageState extends State<ComponentPage> {
  final List<GlobalKey> keys = [];
  final Map<String, OnThisPage> onThisPage = {};

  @override
  void initState() {
    super.initState();
    for (final child in widget.children) {
      if (child is! WidgetUsageExample) {
        continue;
      }
      final title = child.title;
      if (title == null) {
        continue;
      }
      final key = GlobalKey();
      keys.add(key);
      onThisPage[title] = OnThisPage();
    }
  }

  @override
  void didUpdateWidget(covariant ComponentPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.children, widget.children)) {
      keys.clear();
      onThisPage.clear();
      for (final child in widget.children) {
        if (child is! WidgetUsageExample) {
          continue;
        }
        final title = child.title;
        if (title == null) {
          continue;
        }
        final key = GlobalKey();
        keys.add(key);
        onThisPage[title] = OnThisPage();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> remappedChildren = [];
    int i = 0;
    for (final child in widget.children) {
      if (child is! WidgetUsageExample) {
        remappedChildren.add(child);
        continue;
      }
      final title = child.title;
      final key = keys[i];
      if (title == null) {
        continue;
      }
      remappedChildren.add(
        PageItemWidget(
          onThisPage: onThisPage[title]!,
          key: key,
          child: child,
        ),
      );
      i++;
    }
    return DocsPage(
      name: widget.name,
      onThisPage: onThisPage,
      navigationItems: [
        TextButton(
          padding: EdgeInsets.zero,
          onPressed: () {
            context.pushNamed('components');
          },
          child: Text('Components'),
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.displayName).h1(),
          Text(widget.description).lead(),
          ...remappedChildren,
        ],
      ),
    );
  }
}
