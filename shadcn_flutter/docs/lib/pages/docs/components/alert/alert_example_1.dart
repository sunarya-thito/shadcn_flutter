import 'package:shadcn_flutter/shadcn_flutter.dart';

class AlertExample1 extends StatelessWidget {
  const AlertExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return const Alert(
      title: Text('Alert title'),
      content: Text('This is alert content.'),
      leading: Icon(Icons.info_outline),
    );
  }
}
