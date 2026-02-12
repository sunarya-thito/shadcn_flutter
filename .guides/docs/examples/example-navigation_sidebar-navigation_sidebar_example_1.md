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
  Key? selected = const ValueKey(0);

  Widget buildButton(String label, IconData icon, Key key) {
    // Helper for a standard navigation item with text label and icon.
    return NavigationItem(
      key: key,
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
          selectedKey: selected,
          onSelected: (key) {
            setState(() {
              selected = key;
            });
          },
          children: [
            // A mix of labels, gaps, dividers, and items can be used to
            // structure the navigation list into logical sections.
            NavigationGroup(
              label: const Text('Discovery'),
              children: [
                buildButton(
                    'Listen Now', BootstrapIcons.playCircle, const ValueKey(0)),
                buildButton('Browse', BootstrapIcons.grid, const ValueKey(1)),
                buildButton(
                    'Radio', BootstrapIcons.broadcast, const ValueKey(2)),
              ],
            ),
            const NavigationGap(24),
            const NavigationDivider(),
            NavigationGroup(
              label: const Text('Library'),
              children: [
                buildButton('Playlist', BootstrapIcons.musicNoteList,
                    const ValueKey(3)),
                buildButton(
```
