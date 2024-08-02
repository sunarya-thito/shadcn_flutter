import 'package:shadcn_flutter/shadcn_flutter.dart';

class AlertExample2 extends StatelessWidget {
  const AlertExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Alert.destructive(
      title: Text('Alert title'),
      content: Text('This is alert content.'),
      trailing: Icon(Icons.dangerous_outlined),
    );
  }
}
