---
title: "Class: ScaffoldState"
description: "State class for [Scaffold] widget."
---

```dart
/// State class for [Scaffold] widget.
///
/// Manages the scaffold's layout state and provides methods for building
/// header, footer, and body sections with proper theming and constraints.
class ScaffoldState extends State<Scaffold> {
  /// Builds the header section of the scaffold.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  ///
  /// Returns: Widget tree for the header.
  Widget buildHeader(BuildContext context);
  /// Builds the footer section of the scaffold.
  ///
  /// Parameters:
  /// - [context] (`BuildContext`, required): Build context.
  /// - [viewInsets] (`EdgeInsets`, required): View insets (e.g., keyboard).
  ///
  /// Returns: Widget tree for the footer.
  Widget buildFooter(BuildContext context, EdgeInsets viewInsets);
  Widget build(BuildContext context);
}
```
