---
title: "Class: WindowNavigator"
description: "A widget that manages multiple floating windows."
---

```dart
/// A widget that manages multiple floating windows.
///
/// Provides a desktop-style window management system where multiple windows
/// can be displayed, dragged, resized, minimized, and maximized.
///
/// Example:
/// ```dart
/// WindowNavigator(
///   initialWindows: [
///     Window(
///       controller: WindowController(bounds: Rect.fromLTWH(100, 100, 400, 300)),
///       child: Text('Window Content'),
///     ),
///   ],
/// )
/// ```
class WindowNavigator extends StatefulWidget {
  /// Initial list of windows to display.
  final List<Window> initialWindows;
  /// Optional background child widget.
  final Widget? child;
  /// Whether to show the top snap bar for window snapping.
  final bool showTopSnapBar;
  /// Creates a [WindowNavigator].
  ///
  /// Parameters:
  /// - [initialWindows] (`List<Window>`, required): Windows to display initially.
  /// - [child] (`Widget?`, optional): Background widget.
  /// - [showTopSnapBar] (`bool`, default: `true`): Show snap bar.
  const WindowNavigator({super.key, required this.initialWindows, this.child, this.showTopSnapBar = true});
  State<WindowNavigator> createState();
}
```
