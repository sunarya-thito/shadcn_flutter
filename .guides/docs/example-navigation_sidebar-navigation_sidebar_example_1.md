---
title: "Example: components/navigation_sidebar/navigation_sidebar_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a vertical NavigationSidebar with labels, dividers, and gaps.
// Selection is index-based and controlled by local state.

class NavigationSidebarExample1 extends StatefulWidget {
  const NavigationSidebarExample1({super.key});

  @override
  State<NavigationSidebarExample1> createState() =>
      _NavigationSidebarExample1State();
}

class _NavigationSidebarExample1State extends State<NavigationSidebarExample1> {
  // Currently selected item index in the sidebar.
  int selected = 0;

  NavigationBarItem buildButton(String label, IconData icon) {
    // Helper for a standard navigation item with text label and icon.
    return NavigationItem(
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: OutlinedContainer(
        child: NavigationSidebar(
          // Wire selection to local state.
          index: selected,
          onSelected: (index) {
            setState(() {
              selected = index;
            });
          },
          children: [
            // A mix of labels, gaps, dividers, and items can be used to
            // structure the navigation list into logical sections.
            const NavigationLabel(child: Text('Discovery')),
            buildButton('Listen Now', BootstrapIcons.playCircle),
            buildButton('Browse', BootstrapIcons.grid),
            buildButton('Radio', BootstrapIcons.broadcast),
            const NavigationGap(24),
            const NavigationDivider(),
            const NavigationLabel(child: Text('Library')),
            buildButton('Playlist', BootstrapIcons.musicNoteList),
            buildButton('Songs', BootstrapIcons.musicNote),
            buildButton('For You', BootstrapIcons.person),
            buildButton('Artists', BootstrapIcons.mic),
            buildButton('Albums', BootstrapIcons.record2),
            const NavigationGap(24),
            const NavigationDivider(),
            const NavigationLabel(child: Text('Playlists')),
            buildButton('Recently Added', BootstrapIcons.musicNoteList),
            buildButton('Recently Played', BootstrapIcons.musicNoteList),
            buildButton('Top Songs', BootstrapIcons.musicNoteList),
            buildButton('Top Albums', BootstrapIcons.musicNoteList),
```
