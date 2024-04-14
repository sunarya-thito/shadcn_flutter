import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample10 extends StatelessWidget {
  const ButtonExample10({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      trailing: CircularProgressIndicator(),
      child: Text('Loading'),
    );
  }
}
