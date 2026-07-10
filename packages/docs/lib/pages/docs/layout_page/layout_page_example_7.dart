import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample7 extends StatelessWidget {
  const LayoutPageExample7({super.key});

  @override
  Widget build(BuildContext context) {
    return const Basic(
      title: Text('Title'),
      leading: Icon(Icons.star),
      trailing: Icon(Icons.arrow_forward),
      subtitle: Text('Subtitle'),
      content: Text('Lorem ipsum dolor sit amet'),
    );
  }
}
