import 'package:shadcn_flutter/shadcn_flutter.dart';

class DividerExample1 extends StatelessWidget {
  const DividerExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          Divider(),
          Text('Item 2'),
          Divider(),
          Text('Item 3'),
        ],
      ),
    );
  }
}
