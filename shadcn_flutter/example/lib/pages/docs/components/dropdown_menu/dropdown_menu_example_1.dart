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
        MenuDivider(),
        MenuButton(
          child: Text('Profile'),
        ),
        MenuButton(
          child: Text('Billing'),
        ),
        MenuButton(
          child: Text('Settings'),
        ),
        MenuButton(
          child: Text('Keyboard shortcuts'),
        ),
        MenuDivider(),
        MenuButton(
          child: Text('Team'),
        ),
        MenuButton(
          subMenu: [
            MenuButton(
              child: Text('Email'),
            ),
            MenuButton(
              child: Text('Message'),
            ),
            MenuDivider(),
            MenuButton(
              child: Text('More...'),
            ),
          ],
          child: Text('Invite users'),
        ),
        MenuButton(
          child: Text('New Team'),
        ),
        MenuDivider(),
        MenuButton(
          child: Text('GitHub'),
        ),
        MenuButton(
          child: Text('Support'),
        ),
        MenuButton(
          enabled: false,
          child: Text('API'),
        ),
        MenuButton(
          child: Text('Log out'),
        ),
      ],
    );
  }
}
