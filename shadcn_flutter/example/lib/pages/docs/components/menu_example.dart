import 'package:example/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenuExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: name,
      description: description,
      displayName: displayName,
      children: children,
    );
  }
}
