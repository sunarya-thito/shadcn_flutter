import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Menubar(
      children: [
        MenuButton(
          child: Text('File'),
          subMenu: [
            MenuButton(
              trailing: ShortcutActivatorDisplay(
                activator: CharacterActivator(
                  'T',
                  control: true,
                ),
              ),
              child: Text('New Tab'),
            ),
            MenuButton(
              trailing: ShortcutActivatorDisplay(
                activator: CharacterActivator(
                  'N',
                  control: true,
                ),
              ),
              child: Text('New Window'),
            ),
            MenuButton(
              enabled: false,
              trailing: ShortcutActivatorDisplay(
                activator: CharacterActivator(
                  'Shift',
                  control: true,
                ),
              ),
              child: Text('New Incognito Window'),
            ),
            MenuDivider(),
            MenuButton(
              child: Text('Share'),
              subMenu: [
                MenuButton(
                  child: Text('Email Link'),
                ),
                MenuButton(
                  child: Text('Messages'),
                ),
                MenuButton(
                  child: Text('Notes'),
                ),
              ],
            ),
            MenuButton(
              trailing: ShortcutActivatorDisplay(
                activator: CharacterActivator(
                  'P',
                  control: true,
                ),
              ),
              child: Text('Print'),
            ),
          ],
        ),
        MenuButton(
          child: Text('Edit'),
          subMenu: [
            MenuButton(
              trailing: ShortcutActivatorDisplay(
                activator: CharacterActivator(
                  'Z',
                  control: true,
                ),
              ),
              child: Text('Undo'),
            ),
            MenuButton(
              trailing: ShortcutActivatorDisplay(
                activator: CharacterActivator(
                  'Z',
                  control: true,
                  meta: true,
                ),
              ),
              child: Text('Redo'),
            ),
            MenuDivider(),
            MenuButton(
              child: Text('Find'),
              subMenu: [
                MenuButton(
                  child: Text('Search the Web'),
                ),
                MenuDivider(),
                MenuButton(
                  child: Text('Find...'),
                ),
                MenuButton(
                  child: Text('Find Next'),
                ),
                MenuButton(
                  child: Text('Find Previous'),
                ),
              ],
            ),
            MenuDivider(),
            MenuButton(
              child: Text('Cut'),
            ),
            MenuButton(
              child: Text('Copy'),
            ),
            MenuButton(
              child: Text('Paste'),
            ),
          ],
        ),
        MenuButton(
          child: Text('View'),
          subMenu: [
            MenuButton(
              child: Text('Always Show Bookmarks Bar'),
            ),
            MenuButton(
              leading: Icon(RadixIcons.check),
              child: Text('Always Show Full URLs'),
            ),
            MenuDivider(),
            MenuButton(
              trailing: ShortcutActivatorDisplay(
                activator: CharacterActivator(
                  'R',
                  control: true,
                ),
              ),
              child: Text('Reload'),
            ),
            MenuButton(
              enabled: false,
              trailing: ShortcutActivatorDisplay(
                activator: CharacterActivator(
                  'R',
                  control: true,
                  meta: true,
                ),
              ),
              child: Text('Force Reload'),
            ),
            MenuDivider(),
            MenuButton(
              child: Text('Toggle Full Screen'),
            ),
            MenuDivider(),
            MenuButton(
              child: Text('Hide Sidebar'),
            ),
          ],
        ),
        MenuButton(
          child: Text('Profiles'),
          subMenu: [
            MenuButton(
              child: Text('Andy'),
            ),
            MenuButton(
              leading: Icon(RadixIcons.dotFilled),
              child: Text('Benoit'),
            ),
            MenuButton(
              child: Text('Luis'),
            ),
            MenuDivider(),
            MenuButton(
              child: Text('Edit...'),
            ),
            MenuDivider(),
            MenuButton(
              child: Text('Add Profile...'),
            ),
          ],
        ),
      ],
    );
  }
}
