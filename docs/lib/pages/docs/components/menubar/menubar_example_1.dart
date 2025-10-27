import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarExample1 extends StatefulWidget {
  const MenubarExample1({super.key});

  @override
  State<MenubarExample1> createState() => _MenubarExample1State();
}

class _MenubarExample1State extends State<MenubarExample1> {
  bool _showBookmarksBar = false;
  bool _showFullURLs = true;
  int _selectedProfile = 1;
  @override
  Widget build(BuildContext context) {
    // Typical desktop-style menubar with nested submenus, shortcuts,
    // checkboxes (non-closing), and a radio group.
    return Menubar(
      children: [
        const MenuButton(
          subMenu: [
            MenuButton(
              leading: Icon(RadixIcons.filePlus),
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyT,
                  control: true,
                ),
              ),
              child: Text('New Tab'),
            ),
            MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyN,
                  control: true,
                ),
              ),
              child: Text('New Window'),
            ),
            MenuButton(
              enabled: false,
              child: Text('New Incognito Window'),
            ),
            MenuDivider(),
            MenuButton(
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
              child: Text('Share'),
            ),
            MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyP,
                  control: true,
                ),
              ),
              child: Text('Print'),
            ),
            MenuButton(
              subMenu: [
                MenuButton(
                  child: Text('Save and Exit'),
                ),
                MenuButton(
                  child: Text('Discard and Exit'),
                ),
              ],
              child: Text('Exit'),
            ),
          ],
          child: Text('File'),
        ),
        const MenuButton(
          subMenu: [
            MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyZ,
                  control: true,
                ),
              ),
              child: Text('Undo'),
            ),
            MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyZ,
                  control: true,
                  shift: true,
                ),
              ),
              child: Text('Redo'),
            ),
            MenuDivider(),
            MenuButton(
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
              child: Text('Find'),
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
          child: Text('Edit'),
        ),
        MenuButton(
          subMenu: [
            MenuCheckbox(
              value: _showBookmarksBar,
              onChanged: (context, value) {
                setState(() {
                  _showBookmarksBar = value;
                });
              },
              // Keep the submenu open while toggling for quicker multi-actions.
              autoClose: false,
              child: const Text('Always Show Bookmarks Bar'),
            ),
            MenuCheckbox(
              value: _showFullURLs,
              onChanged: (context, value) {
                setState(() {
                  _showFullURLs = value;
                });
              },
              // Also keep open here to demonstrate autoClose control.
              autoClose: false,
              child: const Text('Always Show Full URLs'),
            ),
            const MenuDivider(),
            const MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyR,
                  control: true,
                ),
              ),
              child: Text('Reload'),
            ),
            const MenuButton(
              enabled: false,
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyR,
                  control: true,
                  shift: true,
                ),
              ),
              child: Text('Force Reload'),
            ),
            const MenuDivider(),
            const MenuButton(
              child: Text('Toggle Full Screen'),
            ),
            const MenuDivider(),
            const MenuButton(
              child: Text('Hide Sidebar'),
            ),
          ],
          child: const Text('View'),
        ),
        MenuButton(
          subMenu: [
            MenuRadioGroup<int>(
              value: _selectedProfile,
              onChanged: (context, value) {
                setState(() {
                  _selectedProfile = value;
                });
              },
              children: const [
                MenuRadio<int>(
                  value: 0,
                  // Disable auto-close to let users quickly toggle multiple options.
                  autoClose: false,
                  child: Text('Andy'),
                ),
                MenuRadio<int>(
                  value: 1,
                  autoClose: false,
                  child: Text('Benoit'),
                ),
                MenuRadio<int>(
                  value: 2,
                  autoClose: false,
                  child: Text('Luis'),
                ),
              ],
            ),
            const MenuDivider(),
            const MenuButton(
              child: Text('Edit...'),
            ),
            const MenuDivider(),
            const MenuButton(
              child: Text('Add Profile...'),
            ),
          ],
          child: const Text('Profiles'),
        ),
      ],
    );
  }
}
