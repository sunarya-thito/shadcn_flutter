import 'package:shadcn_flutter/shadcn_flutter.dart';

class InputExample2 extends StatelessWidget {
  const InputExample2({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      initialValue: 'Hello World!',
      placeholder: Text('Enter your message'),
    );
  }
}
