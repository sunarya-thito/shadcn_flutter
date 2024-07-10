import 'package:shadcn_flutter/shadcn_flutter.dart';

class BreadcrumbExample1 extends StatelessWidget {
  const BreadcrumbExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Breadcrumb(
      separator: Breadcrumb.arrowSeparator,
      children: [
        TextButton(
          child: Text('Home'),
          onPressed: () {},
          density: ButtonDensity.compact,
        ),
        MoreDots(),
        TextButton(
          child: Text('Components'),
          onPressed: () {},
          density: ButtonDensity.compact,
        ),
        Text('Breadcrumb'),
      ],
    );
  }
}
