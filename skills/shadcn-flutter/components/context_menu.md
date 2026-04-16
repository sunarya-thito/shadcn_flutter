# ContextMenuTheme

Theme for [ContextMenuPopup] and context menu widgets.

## Usage

### Context Menu Example
```dart
import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/context_menu/context_menu_example_1.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ContextMenuExample extends StatelessWidget {
  const ContextMenuExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'context_menu',
      description:
          'A context menu is a menu in a graphical user interface that appears upon user interaction, such as a right-click mouse operation.',
      displayName: 'Context Menu',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path:
              'lib/pages/docs/components/context_menu/context_menu_example_1.dart',
          child: ContextMenuExample1(),
        ),
      ],
    );
  }
}

```

### Context Menu Example 1
```dart
import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Context menu with shortcuts, submenu, checkboxes, and radio group.
///
/// Right-click (or long-press) the dashed area to open the menu. This
/// demonstrates:
/// - [MenuButton] items with keyboard [MenuShortcut]s.
/// - Nested submenu via [MenuButton.subMenu].
/// - [MenuCheckbox] with `autoClose: false` to keep menu open while toggling.
/// - [MenuRadioGroup] for mutually exclusive choices.
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
          // Simple command with Ctrl+[ shortcut.
          const MenuButton(
            trailing: MenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.bracketLeft,
                control: true,
              ),
            ),
            child: Text('Back'),
          ),
          // Disabled command example with Ctrl+] shortcut.
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
          // Enabled command with Ctrl+R shortcut.
          const MenuButton(
            trailing: MenuShortcut(
              activator: SingleActivator(
                LogicalKeyboardKey.keyR,
                control: true,
              ),
            ),
            child: Text('Reload'),
          ),
          // Submenu with additional tools and a divider.
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
          // Checkbox item; keep menu open while toggling for quick changes.
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
          // Radio group; only one person can be selected at a time.
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
          // Right-click target with a dashed border and rounded corners.
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

```

### Context Menu Tile
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

class ContextMenuTile extends StatelessWidget implements IComponentPage {
  const ContextMenuTile({super.key});

  @override
  String get title => 'Context Menu';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Context Menu',
      name: 'context_menu',
      scale: 1.2,
      example: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CustomPaint(
            painter: CursorPainter(),
          ),
          const Gap(24),
          SizedBox(
            width: 192,
            child: MenuPopup(children: [
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
              const MenuDivider(),
              Button(
                style: const ButtonStyle.menu(),
                onPressed: () {},
                trailing: const MenuShortcut(
                  activator: SingleActivator(LogicalKeyboardKey.delete),
                ),
                child: const Text('Delete'),
              ),
              Button(
                style: const ButtonStyle.menu(),
                onPressed: () {},
                trailing: const MenuShortcut(
                  activator:
                      SingleActivator(LogicalKeyboardKey.keyA, control: true),
                ),
                child: const Text('Select All'),
              ),
            ]),
          ),
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
| `surfaceOpacity` | `double?` | Surface opacity for the popup container. |
| `surfaceBlur` | `double?` | Surface blur for the popup container. |
