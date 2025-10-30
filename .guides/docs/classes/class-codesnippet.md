---
title: "Class: CodeSnippet"
description: "A syntax-highlighted code display widget with copy functionality."
---

```dart
/// A syntax-highlighted code display widget with copy functionality.
///
/// [CodeSnippet] provides a professional code display component with automatic
/// syntax highlighting, copy-to-clipboard functionality, and customizable theming.
/// It supports multiple programming languages and provides a smooth user experience
/// with loading states and responsive scrolling.
///
/// ## Supported Languages
/// - **Core Languages**: Dart, JSON, YAML, SQL
/// - **Aliases**: JavaScript/TypeScript (mapped to Dart highlighting)
/// - **Fallback**: Plain text display for unsupported languages
///
/// ## Key Features
/// - **Syntax Highlighting**: Automatic language detection and coloring
/// - **Copy to Clipboard**: Built-in copy button with toast confirmation
/// - **Custom Actions**: Support for additional action buttons
/// - **Responsive Design**: Horizontal and vertical scrolling for long code
/// - **Theme Integration**: Automatic light/dark theme adaptation
/// - **Loading States**: Smooth loading indicators during initialization
///
/// ## Performance
/// The widget uses lazy initialization for syntax highlighters and caches
/// them for improved performance across multiple instances. Language
/// initialization occurs asynchronously to prevent UI blocking.
///
/// Example:
/// ```dart
/// CodeSnippet(
///   code: '''
/// void main() {
///   print('Hello, World!');
/// }
/// ''',
///   mode: 'dart',
///   constraints: BoxConstraints(maxHeight: 200),
///   actions: [
///     IconButton(
///       icon: Icon(Icons.share),
///       onPressed: () => shareCode(),
///     ),
///   ],
/// );
/// ```
class CodeSnippet extends StatefulWidget {
  /// Optional constraints for the code display area.
  ///
  /// Type: `BoxConstraints?`. Controls the maximum/minimum size of the
  /// scrollable code container. Useful for limiting height in layouts.
  final BoxConstraints? constraints;
  /// The code widget to display (typically Text or RichText with syntax highlighting).
  final Widget code;
  /// Additional action widgets displayed in the top-right corner.
  ///
  /// Type: `List<Widget>`. Custom action buttons shown alongside the
  /// default copy button. Useful for share, edit, or other operations.
  final List<Widget> actions;
  /// Creates a [CodeSnippet] widget.
  ///
  /// Displays syntax-highlighted code with automatic language detection,
  /// copy functionality, and optional custom actions.
  ///
  /// Parameters:
  /// - [code] (String, required): The source code to display
  /// - [mode] (String, required): Programming language for highlighting
  /// - [constraints] (BoxConstraints?, optional): Size constraints for display area
  /// - [actions] (`List<Widget>`, default: []): Additional action buttons
  ///
  /// Example:
  /// ```dart
  /// CodeSnippet(
  ///   code: Text('print("Hello, World!");'),
  ///   mode: 'dart',
  ///   constraints: BoxConstraints(maxHeight: 150),
  /// );
  /// ```
  const CodeSnippet({super.key, this.constraints, this.actions = const [], required this.code});
  State<CodeSnippet> createState();
}
```
