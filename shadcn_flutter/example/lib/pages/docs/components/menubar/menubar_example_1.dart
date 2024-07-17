import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarExample1 extends StatefulWidget {
  @override
  State<MenubarExample1> createState() => _MenubarExample1State();
}

class _MenubarExample1State extends State<MenubarExample1> {
  bool _showBookmarksBar = false;
  bool _showFullURLs = true;
  @override
  Widget build(BuildContext context) {
    return Menubar(
      children: [
        MenuButton(
          child: Text('File'),
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
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyP,
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
            MenuCheckbox(
              value: _showBookmarksBar,
              onChanged: (context, value) {
                setState(() {
                  _showBookmarksBar = value;
                });
              },
              autoClose: false,
              child: Text('Always Show Bookmarks Bar'),
            ),
            MenuCheckbox(
              value: _showFullURLs,
              onChanged: (context, value) {
                setState(() {
                  _showFullURLs = value;
                });
              },
              autoClose: false,
              child: Text('Always Show Full URLs'),
            ),
            MenuDivider(),
            MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyR,
                  control: true,
                ),
              ),
              child: Text('Reload'),
            ),
            MenuButton(
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
