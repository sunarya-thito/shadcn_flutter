---
title: "Class: Chip"
description: "Compact interactive element for tags, labels, and selections."
---

```dart
/// Compact interactive element for tags, labels, and selections.
///
/// A versatile chip widget that combines button functionality with a compact
/// form factor. Ideal for representing tags, categories, filters, or selected
/// items in a space-efficient manner with optional interactive elements.
///
/// ## Features
///
/// - **Compact design**: Space-efficient layout perfect for tags and labels
/// - **Interactive elements**: Optional leading and trailing widgets (icons, buttons)
/// - **Customizable styling**: Flexible button styling with theme integration
/// - **Touch feedback**: Optional press handling with visual feedback
/// - **Accessibility**: Full screen reader support and keyboard navigation
/// - **Consistent theming**: Integrated with the component theme system
///
/// The chip renders as a rounded button with optional leading and trailing
/// elements, making it perfect for filter tags, contact chips, or selection
/// indicators.
///
/// Example:
/// ```dart
/// Chip(
///   leading: Icon(Icons.star),
///   child: Text('Favorites'),
///   trailing: ChipButton(
///     onPressed: () => removeFilter('favorites'),
///     child: Icon(Icons.close),
///   ),
///   onPressed: () => toggleFilter('favorites'),
///   style: ButtonStyle.secondary(),
/// );
/// ```
class Chip extends StatelessWidget {
  /// The main content of the chip.
  final Widget child;
  /// Optional widget displayed before the child.
  final Widget? leading;
  /// Optional widget displayed after the child.
  final Widget? trailing;
  /// Callback invoked when the chip is pressed.
  final VoidCallback? onPressed;
  /// Custom button style for the chip.
  final AbstractButtonStyle? style;
  /// Creates a [Chip].
  ///
  /// The chip displays [child] content with optional [leading] and [trailing]
  /// widgets. When [onPressed] is provided, the entire chip becomes interactive.
  ///
  /// Parameters:
  /// - [child] (Widget, required): main content displayed in the chip center
  /// - [leading] (Widget?, optional): widget displayed before the main content
  /// - [trailing] (Widget?, optional): widget displayed after the main content
  /// - [onPressed] (VoidCallback?, optional): callback when chip is pressed
  /// - [style] (AbstractButtonStyle?, optional): override chip button styling
  ///
  /// Example:
  /// ```dart
  /// Chip(
  ///   leading: Avatar(user: currentUser),
  ///   child: Text(currentUser.name),
  ///   trailing: ChipButton(
  ///     onPressed: () => removeUser(currentUser),
  ///     child: Icon(Icons.close, size: 16),
  ///   ),
  ///   style: ButtonStyle.primary(),
  /// )
  /// ```
  const Chip({super.key, required this.child, this.leading, this.trailing, this.onPressed, this.style});
  Widget build(BuildContext context);
}
```
