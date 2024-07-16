import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Menubar(
      focusScopeNode: FocusScopeNode(
        debugLabel: 'Menubar',
      ),
      children: [
        MenuButton(child: Text('File'), subMenu: [
          MenuButton(child: Text('New'), subMenu: [
            MenuButton(child: Text('Project'), subMenu: [
              MenuButton(child: Text('Dart')),
              MenuButton(child: Text('Flutter')),
            ]),
            MenuButton(child: Text('File')),
          ]),
          MenuButton(child: Text('Open')),
          MenuButton(child: Text('Save')),
        ]),
        MenuButton(
          child: Text('Edit'),
          subMenu: [
            MenuButton(child: Text('Cut')),
            MenuButton(child: Text('Copy')),
            MenuButton(child: Text('Paste')),
            MenuDivider(),
            MenuButton(child: Text('Select All')),
            MenuButton(child: Text('Delete')),
            MenuDivider(),
            MenuButton(child: Text('Find')),
            MenuButton(child: Text('Replace')),
            MenuButton(child: Text('Go To')),
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
