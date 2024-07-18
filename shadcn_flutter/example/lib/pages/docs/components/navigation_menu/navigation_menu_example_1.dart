import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationMenuExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NavigationMenu(
      children: [
        NavigationItem(
          content: Center(
            child: Text('Test'),
          ).sized(width: 300, height: 200),
          child: Text('Getting started'),
        ),
        NavigationItem(
          child: Text('Components'),
          content: Center(
            child: Text('Test'),
          ).sized(width: 500, height: 300),
        ),
        NavigationItem(
          child: Text('Components'),
          content: Center(
            child: Text('Test'),
          ).sized(width: 400, height: 200),
        ),
        NavigationItem(
          child: Text('Documentation'),
        ),
      ],
    );
  }
}
