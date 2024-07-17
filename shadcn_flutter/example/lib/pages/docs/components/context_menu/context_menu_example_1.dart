import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ContextMenuExample1 extends StatefulWidget {
  @override
  State<ContextMenuExample1> createState() => _ContextMenuExample1State();
}

class _ContextMenuExample1State extends State<ContextMenuExample1> {
  int people = 0;
  bool showBookmarksBar = false;
  bool showFullUrls = true;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ContextMenu(
      child: Dashed(
        borderRadius: BorderRadius.circular(theme.radiusMd),
        width: 2,
        gap: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 72, vertical: 48),
          child: const Text('Right click here'),
        ),
      ),
      items: [
        MenuButton(
          trailing: MenuShortcut(
            activator: SingleActivator(
              LogicalKeyboardKey.bracketLeft,
              control: true,
            ),
          ),
          child: Text('Back'),
        ),
        MenuButton(
          trailing: MenuShortcut(
            activator: SingleActivator(
              LogicalKeyboardKey.bracketRight,
              control: true,
            ),
          ),
          enabled: false,
          child: Text('Forward'),
        ),
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
          subMenu: [
            MenuButton(
              trailing: MenuShortcut(
                activator: SingleActivator(
                  LogicalKeyboardKey.keyS,
                  control: true,
                ),
              ),
              child: Text('Save Page As...'),
            ),
            MenuButton(
              child: Text('Create Shortcut...'),
            ),
            MenuButton(
              child: Text('Name Window...'),
            ),
            MenuDivider(),
            MenuButton(
              child: Text('Developer Tools'),
            ),
          ],
          child: Text('More Tools'),
        ),
        MenuDivider(),
        MenuCheckbox(
          value: showBookmarksBar,
          onChanged: (context, value) {
            setState(() {
              showBookmarksBar = value;
            });
          },
          autoClose: false,
          trailing: MenuShortcut(
            activator: SingleActivator(
              LogicalKeyboardKey.keyB,
              control: true,
              shift: true,
            ),
          ),
          child: Text('Show Bookmarks Bar'),
        ),
        MenuCheckbox(
          value: showFullUrls,
          onChanged: (context, value) {
            setState(() {
              showFullUrls = value;
            });
          },
          autoClose: false,
          child: Text('Show Full URLs'),
        ),
        MenuDivider(),
        MenuLabel(child: Text('People')),
        MenuDivider(),
        MenuRadioGroup(
          value: people,
          onChanged: (context, value) {
            setState(() {
              people = value;
            });
          },
          children: [
            MenuRadio(
              value: 0,
              autoClose: false,
              child: Text('Pedro Duarte'),
            ),
            MenuRadio(
              value: 1,
              autoClose: false,
              child: Text('Colm Tuite'),
            ),
          ],
        ),
      ],
    );
  }
}
