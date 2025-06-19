import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ContextMenuExample1 extends StatefulWidget {
  const ContextMenuExample1({super.key});

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
        items: [
          const MenuButton(
            trailing: MenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.bracketLeft,
                control: true,
              ),
            ),
            child: Text('Back'),
          ),
          const MenuButton(
            trailing: MenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.bracketRight,
                control: true,
              ),
            ),
            enabled: false,
            child: Text('Forward'),
          ),
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
          const MenuDivider(),
          MenuCheckbox(
            value: showBookmarksBar,
            onChanged: (context, value) {
              setState(() {
                showBookmarksBar = value;
              });
            },
            autoClose: false,
            trailing: const MenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.keyB,
                control: true,
                shift: true,
              ),
            ),
            child: const Text('Show Bookmarks Bar'),
          ),
          MenuCheckbox(
            value: showFullUrls,
            onChanged: (context, value) {
              setState(() {
                showFullUrls = value;
              });
            },
            autoClose: false,
            child: const Text('Show Full URLs'),
          ),
          const MenuDivider(),
          const MenuLabel(child: Text('People')),
          const MenuDivider(),
          MenuRadioGroup(
            value: people,
            onChanged: (context, value) {
              setState(() {
                people = value;
              });
            },
            children: const [
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
        child: DashedContainer(
          borderRadius: BorderRadius.circular(theme.radiusMd),
          strokeWidth: 2,
          gap: 2,
          child: const Text('Right click here').center(),
        ).constrained(
          maxWidth: 300,
          maxHeight: 200,
        ));
  }
}
