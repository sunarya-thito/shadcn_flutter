---
title: "Example: components/menubar/menubar_example_1.dart"
description: "Component example"
---

Source preview
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
```
