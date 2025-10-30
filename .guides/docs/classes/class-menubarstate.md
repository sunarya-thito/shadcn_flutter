---
title: "Class: MenubarState"
description: "State class for [Menubar] widget."
---

```dart
/// State class for [Menubar] widget.
///
/// Manages the rendering and theming of the menubar container.
class MenubarState extends State<Menubar> {
  Widget build(BuildContext context);
  /// Builds the container widget for the menubar.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): build context
  /// - [theme] (`ThemeData`, required): theme data  
  /// - [subMenuOffset] (`Offset?`, optional): offset for submenu positioning
  /// - [border] (`bool`, required): whether to show border
  ///
  /// Returns: `Widget` — container with menu items
  Widget buildContainer(BuildContext context, ThemeData theme, Offset? subMenuOffset, bool border);
}
```
