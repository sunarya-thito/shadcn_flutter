# Menubar

A horizontal menubar widget for displaying application menus and menu items.

## Usage

### Menubar Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/menubar/menubar_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarExample extends StatelessWidget {
  const MenubarExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'menubar',
      description:
          'A bar of buttons that provies quick access to common actions.',
      displayName: 'Menubar',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/menubar/menubar_example_1.dart',
          child: MenubarExample1(),
        ),
      ],
    );
  }
}

```

### Menubar Example 1
```dart
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

```

### Menubar Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenubarTile extends StatelessWidget implements IComponentPage {
  const MenubarTile({super.key});

  @override
  String get title => 'Menubar';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      title: 'Menubar',
      name: 'menubar',
      scale: 1,
      example: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedContainer(
              borderColor: theme.colorScheme.border,
              backgroundColor: theme.colorScheme.background,
              borderRadius: theme.borderRadiusMd,
              child: Padding(
                padding: const EdgeInsets.all(4),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('File'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar().copyWith(
                          decoration: (context, states, value) {
                            return (value as BoxDecoration).copyWith(
                              color: theme.colorScheme.accent,
                              borderRadius:
                                  BorderRadius.circular(theme.radiusSm),
                            );
                          },
                        ),
                        child: const Text('Edit'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('View'),
                      ),
                      Button(
                        onPressed: () {},
                        style: const ButtonStyle.menubar(),
                        child: const Text('Help'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(4),
            Container(
              width: 192,
              margin: const EdgeInsets.only(left: 48),
              child: MenuPopup(children: [
                Button(
                  style: const ButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyZ, control: true),
                  ),
                  child: const Text('Undo'),
                ),
                Button(
                  style: const ButtonStyle.menu().copyWith(
                      decoration: (context, states, value) {
                    return (value as BoxDecoration).copyWith(
                      color: theme.colorScheme.accent,
                      borderRadius: BorderRadius.circular(theme.radiusSm),
                    );
                  }),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyY, control: true),
                  ),
                  child: const Text('Redo'),
                ),
                const MenuDivider(),
                Button(
                  style: const ButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyX, control: true),
                  ),
                  child: const Text('Cut'),
                ),
                Button(
                  style: const ButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyC, control: true),
                  ),
                  child: const Text('Copy'),
                ),
                Button(
                  style: const ButtonStyle.menu(),
                  onPressed: () {},
                  trailing: const MenuShortcut(
                    activator:
                        SingleActivator(LogicalKeyboardKey.keyV, control: true),
                  ),
                  child: const Text('Paste'),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

```



## Features
- Responsive design
- Customizable styling
- Accessibility support

## Properties

| Property | Type | Description |
| :--- | :--- | :--- |
| `children` | `List<MenuItem>` | List of menu items to display in the menubar.  Type: `List<MenuItem>`. Each MenuItem represents a top-level menu that can contain nested menu items for dropdown functionality. Items are displayed horizontally in the order provided. |
| `popoverOffset` | `Offset?` | Positioning offset for submenu popovers when items are opened.  Type: `Offset?`. If null, uses theme defaults or calculated values based on border presence. Controls where dropdown menus appear relative to their parent menu items. |
| `border` | `bool` | Whether to draw a border around the menubar container.  Type: `bool`, default: `true`. When true, the menubar is wrapped with an outlined container using theme colors and border radius. |
