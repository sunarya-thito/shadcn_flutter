import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

/// Builder function for generating command search results.
///
/// This function is called whenever the search query changes and should return
/// a stream of widgets representing the filtered command results. The stream
/// allows for asynchronous filtering and dynamic result updates.
///
/// Parameters:
/// - [context] (BuildContext): The build context for accessing theme and localization
/// - [query] (String?): The current search query, null when no search is active
///
/// Returns: Stream<List<Widget>> - A stream of command result widgets
///
/// Example:
/// ```dart
/// CommandBuilder myBuilder = (context, query) async* {
///   final filteredCommands = query == null 
///     ? allCommands 
///     : allCommands.where((cmd) => cmd.name.contains(query));
///   
///   yield filteredCommands.map((cmd) => 
///     CommandItem(
///       onTap: () => executeCommand(cmd),
///       child: Text(cmd.name),
///     )
///   ).toList();
/// };
/// ```
typedef CommandBuilder = Stream<List<Widget>> Function(
    BuildContext context, String? query);

/// Builder function for creating error display widgets.
///
/// Called when the command system encounters an error during search or execution.
/// Should return a widget that appropriately displays the error to the user.
///
/// Parameters:
/// - [context] (BuildContext): The build context for accessing theme and styling
/// - [error] (Object): The error object that occurred
/// - [stackTrace] (StackTrace?): Optional stack trace for debugging
///
/// Returns: Widget - A widget that displays the error state
///
/// Example:
/// ```dart
/// ErrorWidgetBuilder errorBuilder = (context, error, stackTrace) {
///   return Container(
///     padding: EdgeInsets.all(16),
///     child: Column(
///       children: [
///         Icon(Icons.error, color: Colors.red),
///         Text('Search failed: ${error.toString()}'),
///       ],
///     ),
///   );
/// };
/// ```
typedef ErrorWidgetBuilder = Widget Function(
    BuildContext context, Object error, StackTrace? stackTrace);

/// Default empty state widget for command interfaces.
///
/// [CommandEmpty] displays a localized message when no command results are found.
/// It provides a consistent empty state across all command interfaces in the application.
///
/// The widget shows centered text with appropriate padding and styling that matches
/// the theme's small text style. The message is automatically localized using
/// [ShadcnLocalizations].
///
/// Used internally by [Command] when search results are empty, but can also be
/// used directly in custom command implementations.
///
/// Example usage in custom command builders:
/// ```dart
/// CommandBuilder builder = (context, query) async* {
///   final results = await searchCommands(query);
///   if (results.isEmpty) {
///     yield [CommandEmpty()];
///   } else {
///     yield results.map((cmd) => CommandItem(...)).toList();
///   }
/// };
/// ```
class CommandEmpty extends StatelessWidget {
  /// Creates a [CommandEmpty] widget.
  ///
  /// This widget requires no configuration as it uses localized text and
  /// theme-appropriate styling automatically.
  const CommandEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Center(
        child:
            Text(localizations.commandEmpty).withPadding(vertical: 24).small());
  }
}

/// Displays a modal command palette dialog for application-wide command execution.
///
/// [showCommandDialog] creates a centered modal dialog containing a command interface
/// that allows users to search and execute application commands. The dialog is
/// commonly triggered by keyboard shortcuts (like Cmd+K) for quick access to functionality.
///
/// The dialog supports real-time search with debouncing, asynchronous command loading,
/// and customizable error/loading states. It provides a modern command palette
/// experience similar to those found in VS Code, Sublime Text, and other applications.
///
/// Parameters:
/// - [context] (BuildContext, required): The build context for displaying the dialog
/// - [builder] (CommandBuilder, required): Function that generates command results based on search query
/// - [constraints] (BoxConstraints?, optional): Size constraints for the dialog. Defaults to 510x349 scaled
/// - [autofocus] (bool, optional): Whether the search field should auto-focus. Defaults to true
/// - [debounceDuration] (Duration, optional): Delay before triggering search after typing. Defaults to 500ms
/// - [emptyBuilder] (WidgetBuilder?, optional): Custom widget for empty search results
/// - [errorBuilder] (ErrorWidgetBuilder?, optional): Custom widget for error states
/// - [loadingBuilder] (WidgetBuilder?, optional): Custom widget for loading states
/// - [surfaceOpacity] (double?, optional): Opacity of the modal backdrop
/// - [surfaceBlur] (double?, optional): Blur amount for the modal backdrop
///
/// Returns: Future<T?> - Resolves when the dialog closes, with optional result value
///
/// Example:
/// ```dart
/// // Show command dialog with custom commands
/// showCommandDialog<String>(
///   context: context,
///   builder: (context, query) async* {
///     final commands = [
///       Command('Open Settings', () => openSettings()),
///       Command('Create New File', () => createFile()),
///       Command('Toggle Theme', () => toggleTheme()),
///     ];
///     
///     final filtered = query == null ? commands : 
///       commands.where((cmd) => cmd.name.toLowerCase().contains(query.toLowerCase()));
///     
///     yield filtered.map((cmd) => 
///       CommandItem(
///         onTap: () {
///           Navigator.pop(context, cmd.name);
///           cmd.action();
///         },
///         child: Text(cmd.name),
///       )
///     ).toList();
///   },
///   constraints: BoxConstraints.tightFor(width: 600, height: 400),
///   debounceDuration: Duration(milliseconds: 300),
/// );
/// ```
Future<T?> showCommandDialog<T>({
  required BuildContext context,
  required CommandBuilder builder,
  BoxConstraints? constraints,
  bool autofocus = true,
  Duration debounceDuration = const Duration(milliseconds: 500),
  WidgetBuilder? emptyBuilder,
  ErrorWidgetBuilder? errorBuilder,
  WidgetBuilder? loadingBuilder,
  double? surfaceOpacity,
  double? surfaceBlur,
}) {
  return showDialog<T>(
    context: context,
    builder: (context) {
      final theme = Theme.of(context);
      final scaling = theme.scaling;
      surfaceOpacity ??= theme.surfaceOpacity;
      surfaceBlur ??= theme.surfaceBlur;
      return ConstrainedBox(
        constraints: constraints ??
            const BoxConstraints.tightFor(width: 510, height: 349) * scaling,
        child: ModalBackdrop(
          borderRadius: subtractByBorder(theme.borderRadiusXxl, 1 * scaling),
          surfaceClip: ModalBackdrop.shouldClipSurface(surfaceOpacity),
          child: Command(
            autofocus: autofocus,
            builder: builder,
            debounceDuration: debounceDuration,
            emptyBuilder: emptyBuilder,
            errorBuilder: errorBuilder,
            loadingBuilder: loadingBuilder,
            surfaceOpacity: surfaceOpacity,
            surfaceBlur: surfaceBlur,
          ),
        ),
      );
    },
  );
}

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
  final Duration
      debounceDuration; // debounce is used to prevent too many requests
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
  const Command({
    super.key,
    required this.builder,
    this.autofocus = true,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
    this.surfaceOpacity,
    this.surfaceBlur,
    this.searchPlaceholder,
  });

  @override
  State<Command> createState() => _CommandState();
}

class _Query {
  final Stream<List<Widget>> stream;
  final String? query;

  _Query({required this.stream, this.query});
}

class _CommandState extends State<Command> {
  final TextEditingController _controller = TextEditingController();
  late _Query _currentRequest;

  int requestCount = 0;

  Stream<List<Widget>> _request(BuildContext context, String? query) async* {
    int currentRequest = ++requestCount;
    yield [];
    await Future.delayed(widget.debounceDuration);
    if (!context.mounted || currentRequest != requestCount) return;
    List<Widget> resultItems = [];
    await for (final items in widget.builder(context, query)) {
      if (currentRequest != requestCount) continue;
      // append items
      resultItems.addAll(items);
      yield resultItems;
    }
  }

  @override
  void initState() {
    super.initState();
    _currentRequest = _Query(stream: _request(context, null));
    _controller.addListener(() {
      String? newQuery = _controller.text;
      if (newQuery.isEmpty) newQuery = null;
      if (newQuery != _currentRequest.query) {
        setState(() {
          _currentRequest =
              _Query(stream: _request(context, newQuery), query: newQuery);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool canPop = Navigator.of(context).canPop();
    final localization = ShadcnLocalizations.of(context);
    return SubFocusScope(builder: (context, state) {
      return Actions(
        actions: {
          NextItemIntent: CallbackAction<NextItemIntent>(
            onInvoke: (intent) {
              state.nextFocus();
              return null;
            },
          ),
          PreviousItemIntent: CallbackAction<PreviousItemIntent>(
            onInvoke: (intent) {
              state.nextFocus(TraversalDirection.up);
              return null;
            },
          ),
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) {
              state.invokeActionOnFocused(intent);
              return null;
            },
          ),
        },
        child: Shortcuts(
          shortcuts: {
            LogicalKeySet(LogicalKeyboardKey.arrowUp):
                const PreviousItemIntent(),
            LogicalKeySet(LogicalKeyboardKey.arrowDown): const NextItemIntent(),
            LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
          },
          child: IntrinsicWidth(
            child: OutlinedContainer(
              clipBehavior: Clip.hardEdge,
              surfaceBlur: widget.surfaceBlur ?? theme.surfaceBlur,
              surfaceOpacity: widget.surfaceOpacity ?? theme.surfaceOpacity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ComponentTheme(
                    data: const FocusOutlineTheme(
                      border: Border.fromBorderSide(BorderSide.none),
                    ),
                    child: TextField(
                      autofocus: widget.autofocus,
                      border: const Border.fromBorderSide(BorderSide.none),
                      borderRadius: BorderRadius.zero,
                      controller: _controller,
                      placeholder: widget.searchPlaceholder ??
                          Text(ShadcnLocalizations.of(context).commandSearch),
                      features: [
                        InputFeature.leading(const Icon(LucideIcons.search)
                            .iconSmall()
                            .iconMutedForeground()),
                        if (canPop)
                          InputFeature.trailing(GhostButton(
                            density: ButtonDensity.iconDense,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(
                              LucideIcons.x,
                            ).iconSmall(),
                          ))
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: StreamBuilder(
                      stream: _currentRequest.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<Widget> items = List.of(snapshot.data!);
                          if (snapshot.connectionState ==
                              ConnectionState.active) {
                            items.add(IconTheme.merge(
                              data: IconThemeData(
                                color: theme.colorScheme.mutedForeground,
                              ),
                              child: const Center(
                                      child: CircularProgressIndicator())
                                  .withPadding(vertical: theme.scaling * 24),
                            ));
                          } else if (items.isEmpty) {
                            return widget.emptyBuilder?.call(context) ??
                                const CommandEmpty();
                          }
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const Divider(),
                            padding: EdgeInsets.symmetric(
                              vertical: theme.scaling * 2,
                            ),
                            shrinkWrap: true,
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return items[index];
                            },
                          );
                        }
                        return widget.loadingBuilder?.call(context) ??
                            const Center(child: CircularProgressIndicator())
                                .withPadding(vertical: theme.scaling * 24);
                      },
                    ),
                  ),
                  const Divider(),
                  Container(
                    color: theme.colorScheme.card,
                    padding: EdgeInsets.symmetric(
                      horizontal: theme.scaling * 12,
                      vertical: theme.scaling * 6,
                    ),
                    child: IntrinsicHeight(
                      child: Row(
                        spacing: theme.scaling * 8,
                        children: [
                          const KeyboardDisplay.fromActivator(
                                  activator: SingleActivator(
                                      LogicalKeyboardKey.arrowUp))
                              .xSmall,
                          Text(localization.commandMoveUp).muted.small,
                          const VerticalDivider(),
                          const KeyboardDisplay.fromActivator(
                                  activator: SingleActivator(
                                      LogicalKeyboardKey.arrowDown))
                              .xSmall,
                          Text(localization.commandMoveDown).muted.small,
                          const VerticalDivider(),
                          const KeyboardDisplay.fromActivator(
                                  activator:
                                      SingleActivator(LogicalKeyboardKey.enter))
                              .xSmall,
                          Text(localization.commandActivate).muted.small,
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}

class CommandCategory extends StatelessWidget {
  final List<Widget> children;
  final Widget? title;

  const CommandCategory({
    super.key,
    required this.children,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          title!
              .withPadding(
                  horizontal: theme.scaling * 8, vertical: theme.scaling * 6)
              .medium()
              .xSmall()
              .muted(),
        ...children,
      ],
    ).withPadding(all: theme.scaling * 4);
  }
}

class CommandItem extends StatefulWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CommandItem({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  State<CommandItem> createState() => _CommandItemState();
}

class _CommandItemState extends State<CommandItem> {
  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Actions(
      actions: {
        ActivateIntent: CallbackAction<Intent>(
          onInvoke: (intent) {
            widget.onTap?.call();
            return null;
          },
        ),
      },
      child: SubFocus(
        builder: (context, state) {
          return Clickable(
            onPressed: widget.onTap,
            onHover: (hovered) {
              setState(() {
                if (hovered) {
                  state.requestFocus();
                }
              });
            },
            child: AnimatedContainer(
              duration: kDefaultDuration,
              decoration: BoxDecoration(
                color: state.isFocused
                    ? themeData.colorScheme.accent
                    : themeData.colorScheme.accent.withValues(alpha: 0),
                borderRadius: BorderRadius.circular(themeData.radiusSm),
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: themeData.scaling * 8,
                  vertical: themeData.scaling * 6),
              child: IconTheme(
                data: themeData.iconTheme.small.copyWith(
                  color: widget.onTap != null
                      ? themeData.colorScheme.accentForeground
                      : themeData.colorScheme.accentForeground.scaleAlpha(0.5),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: widget.onTap != null
                        ? themeData.colorScheme.accentForeground
                        : themeData.colorScheme.accentForeground
                            .scaleAlpha(0.5),
                  ),
                  child: Row(
                    children: [
                      if (widget.leading != null) widget.leading!,
                      if (widget.leading != null) Gap(themeData.scaling * 8),
                      Expanded(child: widget.title),
                      if (widget.trailing != null) Gap(themeData.scaling * 8),
                      if (widget.trailing != null)
                        widget.trailing!.muted().xSmall(),
                    ],
                  ).small(),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
