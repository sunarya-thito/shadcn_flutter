import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Dropdown menu anchored to a button.
///
/// Uses [showDropdown] to present a [DropdownMenu] overlay with labels,
/// dividers, buttons, and a nested submenu.
class DropdownMenuExample1 extends StatelessWidget {
  const DropdownMenuExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      onPressed: () {
        // Show the dropdown relative to the button.
        showDropdown(
          context: context,
          builder: (context) {
            return const DropdownMenu(
              children: [
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
                  // Demonstrates a nested submenu.
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
          },
        ).future.then((_) {
          // Called when the dropdown is closed.
          if (kDebugMode) {
            print('Closed');
          }
        });
      },
      child: const Text('Open'),
    );
  }
}
