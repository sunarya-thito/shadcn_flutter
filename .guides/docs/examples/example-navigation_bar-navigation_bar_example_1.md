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
  Key? selected = const ValueKey(0);

  NavigationBarAlignment alignment = NavigationBarAlignment.spaceAround;
  NavigationLabelType labelType = NavigationLabelType.none;
  bool customButtonStyle = true;
  bool expanded = true;

  NavigationItem buildButton(String label, IconData icon, Key key) {
    return NavigationItem(
      key: key,
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
            onSelected: (key) {
              setState(() {
                selected = key;
              });
            },
            selectedKey: selected,
            children: [
              buildButton('Home', BootstrapIcons.house, const ValueKey(0)),
              buildButton('Explore', BootstrapIcons.compass, const ValueKey(1)),
              buildButton(
                  'Library', BootstrapIcons.musicNoteList, const ValueKey(2)),
              buildButton('Profile', BootstrapIcons.person, const ValueKey(3)),
              buildButton(
                  'App', BootstrapIcons.appIndicator, const ValueKey(4)),
            ],
          ),
        ],
```
