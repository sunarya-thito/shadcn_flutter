---
title: "Class: Command"
description: "Interactive command palette with search functionality and dynamic results."
---

```dart
/// Interactive command palette with search functionality and dynamic results.
///
/// A powerful search and command interface that provides real-time filtering
/// of commands or items based on user input. Features debounced search,
/// keyboard navigation, and customizable result presentation.
///
/// ## Features
///
/// - **Real-time search**: Dynamic filtering with configurable debounce timing
/// - **Keyboard navigation**: Full arrow key and Enter/Escape support
/// - **Async data loading**: Stream-based results with loading and error states
/// - **Customizable states**: Custom builders for empty, loading, and error states
/// - **Auto-focus**: Optional automatic focus on the search input
/// - **Accessibility**: Screen reader friendly with proper focus management
///
/// The command palette is commonly used for:
/// - Quick action selection (Cmd+K style interfaces)
/// - Searchable option lists
/// - Dynamic content filtering
/// - Command-driven workflows
///
/// Example:
/// ```dart
/// Command(
///   autofocus: true,
///   debounceDuration: Duration(milliseconds: 300),
///   builder: (context, query) async* {
///     final results = await searchService.search(query);
///     yield results.map((item) => CommandItem(
///       onSelected: () => handleCommand(item),
///       child: Text(item.title),
///     )).toList();
///   },
///   emptyBuilder: (context) => Text('No results found'),
/// );
/// ```
class Command extends StatefulWidget {
  final bool autofocus;
  final CommandBuilder builder;
  final Duration debounceDuration;
  final WidgetBuilder? emptyBuilder;
  final ErrorWidgetBuilder? errorBuilder;
  final WidgetBuilder? loadingBuilder;
  final double? surfaceOpacity;
  final double? surfaceBlur;
  final Widget? searchPlaceholder;
  /// Creates a [Command] palette.
  ///
  /// The [builder] function receives the current search query and should return
  /// a stream of widgets representing the filtered results.
  ///
  /// Parameters:
  /// - [builder] (CommandBuilder, required): async builder for search results
  /// - [autofocus] (bool, default: true): whether to auto-focus search input
  /// - [debounceDuration] (Duration, default: 500ms): debounce delay for search
  /// - [emptyBuilder] (WidgetBuilder?, optional): custom widget for empty state
  /// - [errorBuilder] (ErrorWidgetBuilder?, optional): custom error display
  /// - [loadingBuilder] (WidgetBuilder?, optional): custom loading indicator
  /// - [surfaceOpacity] (double?, optional): surface opacity override
  /// - [surfaceBlur] (double?, optional): surface blur override
  /// - [searchPlaceholder] (Widget?, optional): placeholder text for search input
  ///
  /// Example:
  /// ```dart
  /// Command(
  ///   autofocus: false,
  ///   debounceDuration: Duration(milliseconds: 200),
  ///   searchPlaceholder: Text('Search commands...'),
  ///   builder: (context, query) async* {
  ///     final filtered = commands.where((cmd) => 
  ///       cmd.name.toLowerCase().contains(query?.toLowerCase() ?? '')
  ///     );
  ///     yield filtered.map((cmd) => CommandItem(
  ///       child: Text(cmd.name),
  ///       onSelected: () => cmd.execute(),
  ///     )).toList();
  ///   },
  /// )
  /// ```
  const Command({super.key, required this.builder, this.autofocus = true, this.debounceDuration = const Duration(milliseconds: 500), this.emptyBuilder, this.errorBuilder, this.loadingBuilder, this.surfaceOpacity, this.surfaceBlur, this.searchPlaceholder});
  State<Command> createState();
}
```
