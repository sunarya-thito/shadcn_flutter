# DropdownMenu

A dropdown menu widget that displays a list of menu items in a popup.

## Usage

### Dropdown Menu Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import '../../widget_usage_example.dart';
import 'dropdown_menu/dropdown_menu_example_1.dart';

class DropdownMenuExample extends StatelessWidget {
  const DropdownMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'dropdown_menu',
      description:
          'Dropdown menu is a menu that appears when you click a button or other control.',
      displayName: 'Dropdown Menu',
      children: [
        WidgetUsageExample(
          title: 'Dropdown Menu Example',
          path:
              'lib/pages/docs/components/dropdown_menu/dropdown_menu_example_1.dart',
          child: DropdownMenuExample1(),
        ),
      ],
    );
  }
}

```

### Dropdown Menu Example 1
```dart
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

```

### Dropdown Menu Tile
```dart
import 'package:docs/pages/docs/components_page.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

// paint a cursor
class CursorPainter extends CustomPainter {
  // <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24">
  // <path d="M4 0l16 12.279-6.951 1.17 4.325 8.817-3.596 1.734-4.35-8.879-5.428 4.702z"/></svg>
  const CursorPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = material.Colors.white
      ..style = PaintingStyle.fill;
    final path = Path()
      ..moveTo(4, 0)
      ..lineTo(20, 12.279)
      ..lineTo(13.049, 13.449)
      ..lineTo(17.374, 22.266)
      ..lineTo(13.778, 24)
      ..lineTo(9.428, 15.121)
      ..lineTo(4, 19.823)
      ..close();
    canvas.drawPath(path, paint);
    paint
      ..color = material.Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DropdownMenuTile extends StatelessWidget implements IComponentPage {
  const DropdownMenuTile({super.key});

  @override
  String get title => 'Dropdown Menu';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ComponentCard(
      title: 'Dropdown Menu',
      name: 'dropdown_menu',
      scale: 1,
      example: Stack(
        children: [
          Card(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OutlineButton(
                  onPressed: () {},
                  child: const Text('Options'),
                ),
                const Gap(8),
                SizedBox(
                  width: 192,
                  child: MenuPopup(children: [
                    Button(
                      style: const ButtonStyle.menu(),
                      onPressed: () {},
                      child: const Text('Profile'),
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
                      child: const Text('Billing'),
                    ),
                    const MenuDivider(),
                    Button(
                      style: const ButtonStyle.menu(),
                      onPressed: () {},
                      child: const Text('Settings'),
                    ),
                    Button(
                      style: const ButtonStyle.menu(),
                      onPressed: () {},
                      trailing: const MenuShortcut(
                        activator: SingleActivator(LogicalKeyboardKey.keyC,
                            control: true),
                      ),
                      child: const Text('Copy'),
                    ),
                    Button(
                      style: const ButtonStyle.menu(),
                      onPressed: () {},
                      trailing: const MenuShortcut(
                        activator: SingleActivator(LogicalKeyboardKey.keyV,
                            control: true),
                      ),
                      child: const Text('Paste'),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          const Positioned(
            top: 105,
            left: 170,
            child: CustomPaint(
              painter: CursorPainter(),
            ),
          )
        ],
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
| `surfaceOpacity` | `double?` | Opacity of the surface blur effect.  If `null`, uses theme default. |
| `surfaceBlur` | `double?` | Amount of blur to apply to the surface.  If `null`, uses theme default. |
| `children` | `List<MenuItem>` | Menu items to display in the dropdown.  Each item should be a [MenuItem] or similar menu component. |
