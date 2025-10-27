---
title: "Example: components/navigation_bar/navigation_bar_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationBarExample1 extends StatefulWidget {
  const NavigationBarExample1({super.key});

  @override
  State<NavigationBarExample1> createState() => _NavigationBarExample1State();
}

class _NavigationBarExample1State extends State<NavigationBarExample1> {
  int selected = 0;

  NavigationBarAlignment alignment = NavigationBarAlignment.spaceAround;
  bool expands = true;
  NavigationLabelType labelType = NavigationLabelType.none;
  bool customButtonStyle = true;
  bool expanded = true;

  NavigationItem buildButton(String label, IconData icon) {
    return NavigationItem(
      style: customButtonStyle
          ? const ButtonStyle.muted(density: ButtonDensity.icon)
          : null,
      selectedStyle: customButtonStyle
          ? const ButtonStyle.fixed(density: ButtonDensity.icon)
          : null,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedContainer(
      width: 500,
      height: 400,
      child: Scaffold(
        footers: [
          const Divider(),
          NavigationBar(
            alignment: alignment,
            labelType: labelType,
            expanded: expanded,
            expands: expands,
            onSelected: (index) {
              setState(() {
                selected = index;
              });
            },
            index: selected,
            children: [
              buildButton('Home', BootstrapIcons.house),
              buildButton('Explore', BootstrapIcons.compass),
              buildButton('Library', BootstrapIcons.musicNoteList),
              buildButton('Profile', BootstrapIcons.person),
              buildButton('App', BootstrapIcons.appIndicator),
            ],
          ),
        ],
        child: Container(
```
