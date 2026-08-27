import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample9 extends StatelessWidget {
  const LayoutPageExample9({super.key});

  @override
  Widget build(BuildContext context) {
    return const Basic(
      title: Text('Title'),
      leading: Icon(LucideIcons.star),
      trailing: Icon(LucideIcons.arrowRight),
      subtitle: Text('Subtitle'),
      content: Text('Lorem ipsum dolor sit amet'),
    );
  }
}
