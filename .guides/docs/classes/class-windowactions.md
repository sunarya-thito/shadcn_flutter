---
title: "Class: WindowActions"
description: "Default window actions widget providing minimize, maximize, and close buttons."
---

```dart
/// Default window actions widget providing minimize, maximize, and close buttons.
///
/// This widget provides the standard set of window control buttons typically
/// found in window title bars. The buttons automatically adapt based on the
/// window's capabilities (minimizable, maximizable, closable).
///
/// The widget retrieves window state from the build context using the Data
/// inheritance mechanism, accessing [WindowHandle] and [WindowViewport] data.
///
/// Buttons included:
/// - Minimize button: Collapses the window (if minimizable)
/// - Maximize/Restore button: Toggles between maximized and normal states (if maximizable)
/// - Close button: Closes the window (if closable)
///
/// Example:
/// ```dart
/// Window(
///   title: Text('My Window'),
///   actions: WindowActions(), // Default window controls
///   content: MyContent(),
/// )
/// ```
class WindowActions extends StatelessWidget {
  /// Creates a default window actions widget.
  ///
  /// This widget automatically displays appropriate control buttons based on
  /// the window's configuration and capabilities.
  const WindowActions({super.key});
  Widget build(BuildContext context);
}
```
