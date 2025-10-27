---
title: "Class: Alert"
description: "A versatile alert component for displaying important messages or notifications."
---

```dart
/// A versatile alert component for displaying important messages or notifications.
///
/// The Alert widget provides a flexible layout for presenting information to users
/// with optional leading icons, title text, content description, and trailing actions.
/// Supports both normal and destructive styling modes for different message types.
///
/// The component uses a [Basic] layout internally and wraps content in an
/// [OutlinedContainer] for consistent visual presentation. Text and icon colors
/// automatically adapt based on the destructive mode and current theme.
///
/// Key features:
/// - Flexible content layout with optional elements
/// - Destructive styling for error/warning messages
/// - Theme integration with customizable styling
/// - Responsive scaling based on theme configuration
/// - Automatic color adaptation for text and icons
///
/// Example:
/// ```dart
/// Alert(
///   leading: Icon(Icons.info),
///   title: Text('Information'),
///   content: Text('This is an informational alert message.'),
///   trailing: IconButton(
///     icon: Icon(Icons.close),
///     onPressed: () {},
///   ),
/// );
/// ```
class Alert extends StatelessWidget {
  /// Optional leading widget, typically an icon.
  ///
  /// Type: `Widget?`. Displayed at the start of the alert layout.
  /// In destructive mode, inherits the destructive color from the theme.
  final Widget? leading;
  /// Optional title widget for the alert header.
  ///
  /// Type: `Widget?`. Usually contains the main alert message or heading.
  /// Positioned after the leading widget in the layout flow.
  final Widget? title;
  /// Optional content widget for detailed alert information.
  ///
  /// Type: `Widget?`. Provides additional context or description below the title.
  /// Can contain longer text or complex content layouts.
  final Widget? content;
  /// Optional trailing widget, typically for actions or dismissal.
  ///
  /// Type: `Widget?`. Displayed at the end of the alert layout.
  /// Common use cases include close buttons or action controls.
  final Widget? trailing;
  /// Whether to apply destructive styling to the alert.
  ///
  /// Type: `bool`, default: `false`. When true, applies destructive color
  /// scheme to text and icons for error or warning messages.
  final bool destructive;
  /// Creates an [Alert] with standard styling.
  ///
  /// All content parameters are optional, allowing for flexible layouts
  /// from simple text alerts to complex multi-element notifications.
  ///
  /// Parameters:
  /// - [leading] (Widget?, optional): Icon or widget at the start
  /// - [title] (Widget?, optional): Main heading or message
  /// - [content] (Widget?, optional): Detailed description or body
  /// - [trailing] (Widget?, optional): Action buttons or dismissal controls
  /// - [destructive] (bool, default: false): Whether to use destructive styling
  ///
  /// Example:
  /// ```dart
  /// Alert(
  ///   title: Text('Success'),
  ///   content: Text('Operation completed successfully.'),
  /// );
  /// ```
  const Alert({super.key, this.leading, this.title, this.content, this.trailing, this.destructive = false});
  /// Creates an [Alert] with destructive styling pre-configured.
  ///
  /// This is a convenience constructor that sets [destructive] to true,
  /// applying error/warning colors to text and icons automatically.
  ///
  /// Parameters:
  /// - [leading] (Widget?, optional): Icon or widget at the start
  /// - [title] (Widget?, optional): Main heading or message  
  /// - [content] (Widget?, optional): Detailed description or body
  /// - [trailing] (Widget?, optional): Action buttons or dismissal controls
  ///
  /// Example:
  /// ```dart
  /// Alert.destructive(
  ///   leading: Icon(Icons.error),
  ///   title: Text('Error'),
  ///   content: Text('Something went wrong. Please try again.'),
  /// );
  /// ```
  const Alert.destructive({super.key, this.leading, this.title, this.content, this.trailing});
  Widget build(BuildContext context);
}
```
