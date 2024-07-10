import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample9 extends StatelessWidget {
  const ButtonExample9({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          onPressed: () {},
          trailing: Icon(Icons.add),
          child: Text('Add'),
        ),
        SecondaryButton(
          onPressed: () {},
          trailing: Icon(Icons.add),
          child: Text('Add'),
        ),
        OutlineButton(
          onPressed: () {},
          trailing: Icon(Icons.add),
          child: Text('Add'),
        ),
        GhostButton(
          onPressed: () {},
          trailing: Icon(Icons.add),
          child: Text('Add'),
        ),
        TextButton(
          onPressed: () {},
          trailing: Icon(Icons.add),
          child: Text('Add'),
        ),
        DestructiveButton(
          onPressed: () {},
          trailing: Icon(Icons.add),
          child: Text('Add'),
        ),
      ],
    );
  }
}
