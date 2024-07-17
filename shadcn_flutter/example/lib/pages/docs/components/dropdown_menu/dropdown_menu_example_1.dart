import 'package:shadcn_flutter/shadcn_flutter.dart';

class DropdownMenuExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      builder: (context, control) {
        return OutlineButton(
          onPressed: () {
            control.show();
          },
          child: Text('Open'),
        );
      },
      items: [
        MenuLabel(child: Text('My Account')),
      ],
    );
  }
}
