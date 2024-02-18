import 'package:example/pages/docs_page.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ComponentPage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return DocsPage(
      name: name,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(displayName).h1(),
          Text(description).lead(),
          ...children.map((e) => e.p()).toList(),
        ],
      ),
    );
  }
}
