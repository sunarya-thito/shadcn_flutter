import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample9 extends StatelessWidget {
  const ButtonExample9({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {},
      trailing: Icon(Icons.add),
      child: Text('Add'),
    );
  }
}
