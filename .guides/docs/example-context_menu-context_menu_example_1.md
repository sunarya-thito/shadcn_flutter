---
title: "Example: components/context_menu/context_menu_example_1.dart"
description: "Component example"
---

Source preview
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
```
