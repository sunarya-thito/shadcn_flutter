---
title: "Class: Scaffold"
description: "A fundamental layout widget that provides the basic structure for screen layouts."
---

```dart
/// A fundamental layout widget that provides the basic structure for screen layouts.
///
/// [Scaffold] serves as the foundation for most screen layouts in the shadcn_flutter
/// design system. It provides a structured approach to organizing content with
/// dedicated areas for headers, main content, and footers. The scaffold manages
/// layout responsibilities, loading states, and provides a consistent framework
/// for building complex interfaces.
///
/// Key features:
/// - Flexible header and footer management with multiple widget support
/// - Main content area with automatic layout management
/// - Loading progress indication with optional sparks animation
/// - Floating header/footer modes for overlay positioning
/// - Independent background color control for each section
/// - Keyboard avoidance behavior for input accessibility
/// - Responsive layout adjustments
/// - Integration with the shadcn_flutter theme system
///
/// Layout structure:
/// - Headers: Optional top section for navigation, titles, toolbars
/// - Main content: Central area containing the primary interface
/// - Footers: Optional bottom section for actions, navigation, status
///
/// The scaffold supports both fixed and floating positioning modes:
/// - Fixed mode: Headers/footers take layout space and push content
/// - Floating mode: Headers/footers overlay content without affecting layout
///
/// Loading states are elegantly handled with:
/// - Progress indication through [loadingProgress]
/// - Optional animated sparks for enhanced visual feedback
/// - Indeterminate loading support for unknown duration tasks
///
/// Example:
/// ```dart
/// Scaffold(
///   headers: [
///     AppBar(title: Text('My App')),
///   ],
///   child: Center(
///     child: Text('Main content area'),
///   ),
///   footers: [
///     BottomNavigationBar(
///       items: [
///         BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
///         BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
///       ],
///     ),
///   ],
///   loadingProgress: isLoading ? null : 0.0, // null for indeterminate
///   showLoadingSparks: true,
/// );
/// ```
class Scaffold extends StatefulWidget {
  /// Header widgets displayed at the top of the scaffold.
  final List<Widget> headers;
  /// Footer widgets displayed at the bottom of the scaffold.
  final List<Widget> footers;
  /// Main content widget.
  final Widget child;
  /// Loading progress value (0.0 to 1.0).
  final double? loadingProgress;
  /// Whether loading indicator shows indeterminate progress.
  final bool loadingProgressIndeterminate;
  /// Whether header floats above content (takes no layout space).
  final bool floatingHeader;
  /// Whether footer floats above content (takes no layout space).
  final bool floatingFooter;
  /// Background color for header section.
  final Color? headerBackgroundColor;
  /// Background color for footer section.
  final Color? footerBackgroundColor;
  /// Background color for the scaffold.
  final Color? backgroundColor;
  /// Whether to show loading sparks effect.
  final bool? showLoadingSparks;
  /// Whether to resize when keyboard appears.
  final bool? resizeToAvoidBottomInset;
  /// Creates a [Scaffold].
  const Scaffold({super.key, required this.child, this.headers = const [], this.footers = const [], this.loadingProgress, this.loadingProgressIndeterminate = false, this.floatingHeader = false, this.floatingFooter = false, this.backgroundColor, this.headerBackgroundColor, this.footerBackgroundColor, this.showLoadingSparks, this.resizeToAvoidBottomInset});
  State<Scaffold> createState();
}
```
