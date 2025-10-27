---
title: "Example: components/navigation_rail/navigation_rail_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationRailExample1 extends StatefulWidget {
  const NavigationRailExample1({super.key});

  @override
  State<NavigationRailExample1> createState() => _NavigationRailExample1State();
}

class _NavigationRailExample1State extends State<NavigationRailExample1> {
  int selected = 0;

  NavigationRailAlignment alignment = NavigationRailAlignment.start;
  NavigationLabelType labelType = NavigationLabelType.none;
  NavigationLabelPosition labelPosition = NavigationLabelPosition.bottom;
  bool customButtonStyle = false;
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
    return Scaffold(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationRail(
            alignment: alignment,
            labelType: labelType,
            index: selected,
            labelPosition: labelPosition,
            expanded: expanded,
            onSelected: (index) {
              setState(() {
                selected = index;
              });
            },
            children: [
              buildButton('Home', BootstrapIcons.house),
              buildButton('Explore', BootstrapIcons.compass),
              buildButton('Library', BootstrapIcons.musicNoteList),
              const NavigationDivider(),
              const NavigationLabel(child: Text('Settings')),
              buildButton('Profile', BootstrapIcons.person),
              buildButton('App', BootstrapIcons.appIndicator),
              const NavigationDivider(),
              const NavigationGap(12),
              const NavigationWidget(
                child: FlutterLogo(),
```
