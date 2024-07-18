import 'package:shadcn_flutter/shadcn_flutter.dart';

class DividerExample3 extends StatelessWidget {
  const DividerExample3({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Item 1'),
          Divider(
            child: Text('Divider'),
          ),
          Text('Item 2'),
          Divider(
            child: Text('Divider'),
          ),
          Text('Item 3'),
        ],
      ),
    );
  }
}
