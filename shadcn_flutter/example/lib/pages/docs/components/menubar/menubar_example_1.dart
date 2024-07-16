import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Menubar(
      children: [
        MenuButton(child: Text('File'), subMenu: [
          MenuButton(child: Text('New')),
          MenuButton(child: Text('Open')),
          MenuButton(child: Text('Save')),
        ]),
        MenuButton(
          child: Text('Edit'),
          subMenu: [
            MenuButton(child: Text('Cut')),
            MenuButton(child: Text('Copy')),
            MenuButton(child: Text('Paste')),
          ],
        ),
        MenuButton(
          child: Text('Help'),
          subMenu: [
            MenuButton(child: Text('About')),
          ],
        ),
      ],
    );
  }
}
