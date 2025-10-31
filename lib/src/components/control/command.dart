import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// A builder function that produces command search results as a stream.
///
/// ## Parameters
///
/// * [context] - The build context.
/// * [query] - The current search query string, or `null` for initial state.
///
/// ## Returns
///
/// A `Stream` of widget lists representing filtered/matched results.
///
/// ## Example
///
/// ```dart
/// CommandBuilder myBuilder = (context, query) async* {
///   final results = await fetchResults(query);
///   yield results.map((r) => CommandItem(title: Text(r))).toList();
/// };
/// ```
typedef CommandBuilder = Stream<List<Widget>> Function(
    BuildContext context, String? query);

/// A builder function for error widgets in command palettes.
///
/// ## Parameters
///
/// * [context] - The build context.
/// * [error] - The error object that was caught.
/// * [stackTrace] - Optional stack trace for debugging.
///
/// ## Returns
///
/// A widget to display when an error occurs.
///
/// ## Example
///
/// ```dart
/// ErrorWidgetBuilder errorBuilder = (context, error, stackTrace) {
///   return Text('Error: $error');
/// };
/// ```
typedef ErrorWidgetBuilder = Widget Function(
    BuildContext context, Object error, StackTrace? stackTrace);

/// A default widget displayed when command search returns no results.
///
/// Displays a localized "No results" message with standard styling.
class CommandEmpty extends StatelessWidget {
  /// Creates a [CommandEmpty] widget.
  ///
  /// Displays a standard empty state message when no command results are found.
  const CommandEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Center(
        child:
            Text(localizations.commandEmpty).withPadding(vertical: 24).small());
  }
}

/// Shows a command palette in a modal dialog.
///
/// Displays a [Command] widget in a modal dialog with customizable constraints,
/// backdrop effects, and search behavior.
///
/// ## Parameters
///
/// * [context] - The build context.
/// * [builder] - The command builder for search results.
/// * [constraints] - Optional size constraints. Defaults to 510x349.
/// * [autofocus] - Whether to auto-focus the search field. Defaults to `true`.
/// * [debounceDuration] - Search debounce delay. Defaults to 500ms.
/// * [emptyBuilder] - Custom widget for empty results.
/// * [errorBuilder] - Custom widget for error states.
/// * [loadingBuilder] - Custom widget for loading states.
/// * [surfaceOpacity] - Modal surface opacity.
/// * [surfaceBlur] - Modal surface blur amount.
///
/// ## Returns
///
/// A `Future` that completes with the dialog result of type [T], or `null` if dismissed.
///
/// ## Example
///
/// ```dart
/// final result = await showCommandDialog<String>(
///   context: context,
///   builder: (context, query) async* {
///     yield commands.where((c) => c.contains(query ?? '')).toList();
///   },
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
///       onTap: () => handleCommand(item),
///       title: Text(item.title),
///     )).toList();
///   },
///   emptyBuilder: (context) => Text('No results found'),
/// );
/// ```
class Command extends StatefulWidget {
  /// Whether the search input should be auto-focused when the command palette opens.
  ///
  /// Defaults to `true` for convenient keyboard-driven interaction.
  final bool autofocus;

  /// Async builder function that provides search results based on the query.
  ///
  /// Receives the current search query string and should return a stream of
  /// widget lists representing the filtered command results.
  final CommandBuilder builder;

  /// Debounce duration for search input to prevent excessive rebuilds.
  ///
  /// The builder is called only after the user stops typing for this duration,
  /// reducing unnecessary API calls or computations. Defaults to 500ms.
  final Duration
      debounceDuration; // debounce is used to prevent too many requests

  /// Custom widget builder for displaying empty search results.
  ///
  /// If `null`, displays a default "No results" message via [CommandEmpty].
  final WidgetBuilder? emptyBuilder;

  /// Custom widget builder for displaying error states.
  ///
  /// Receives the error object and stack trace for custom error presentation.
  final ErrorWidgetBuilder? errorBuilder;

  /// Custom widget builder for displaying loading state while fetching results.
  ///
  /// If `null`, displays a default loading spinner.
  final WidgetBuilder? loadingBuilder;

  /// Optional opacity override for the command palette surface.
  ///
  /// When provided, overrides the theme's default surface opacity.
  final double? surfaceOpacity;

  /// Optional blur amount override for the command palette surface backdrop.
  ///
  /// When provided, overrides the theme's default surface blur.
  final double? surfaceBlur;

  /// Optional custom placeholder widget for the search input field.
  ///
  /// If `null`, displays default localized placeholder text.
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
  ///       title: Text(cmd.name),
  ///       onTap: () => cmd.execute(),
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
    return SubFocusScope(
        autofocus: true,
        builder: (context, state) {
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
                LogicalKeySet(LogicalKeyboardKey.arrowDown):
                    const NextItemIntent(),
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
                              Text(ShadcnLocalizations.of(context)
                                  .commandSearch),
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
                                      .withPadding(
                                          vertical: theme.scaling * 24),
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
                                      activator: SingleActivator(
                                          LogicalKeyboardKey.enter))
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

/// A category grouping for command items in a command palette.
///
/// Groups related command items under an optional category title. Items within
/// a category are visually grouped and can be navigated as a unit.
///
/// ## Example
///
/// ```dart
/// CommandCategory(
///   title: Text('File'),
///   children: [
///     CommandItem(title: Text('New File'), onTap: () {}),
///     CommandItem(title: Text('Open File'), onTap: () {}),
///     CommandItem(title: Text('Save'), onTap: () {}),
///   ],
/// )
/// ```
class CommandCategory extends StatelessWidget {
  /// The list of command items in this category.
  final List<Widget> children;

  /// Optional title widget displayed above the category items.
  final Widget? title;

  /// Creates a [CommandCategory] to group related command items.
  ///
  /// Parameters:
  /// - [children] (`List<Widget>`, required): The command items in this category
  /// - [title] (Widget?, optional): Optional category header text
  ///
  /// Example:
  /// ```dart
  /// CommandCategory(
  ///   title: Text('Edit'),
  ///   children: [
  ///     CommandItem(title: Text('Cut'), onTap: () => cut()),
  ///     CommandItem(title: Text('Copy'), onTap: () => copy()),
  ///   ],
  /// )
  /// ```
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

/// An individual selectable item in a command palette.
///
/// Represents a single command or option that can be selected via click or
/// keyboard navigation. Supports optional leading and trailing widgets for
/// icons, shortcuts, or other decorations.
///
/// ## Example
///
/// ```dart
/// CommandItem(
///   leading: Icon(Icons.save),
///   title: Text('Save File'),
///   trailing: Text('Ctrl+S'),
///   onTap: () => saveFile(),
/// )
/// ```
class CommandItem extends StatefulWidget {
  /// Optional widget displayed before the title (e.g., an icon).
  final Widget? leading;

  /// The main title/label of the command item.
  final Widget title;

  /// Optional widget displayed after the title (e.g., keyboard shortcut).
  final Widget? trailing;

  /// Called when the item is selected/tapped.
  final VoidCallback? onTap;

  /// Creates a [CommandItem] for display in a command palette.
  ///
  /// Parameters:
  /// - [title] (Widget, required): The main label for this command
  /// - [leading] (Widget?, optional): Widget displayed before the title (e.g., icon)
  /// - [trailing] (Widget?, optional): Widget displayed after the title (e.g., shortcut)
  /// - [onTap] (VoidCallback?, optional): Callback when the item is selected
  ///
  /// Example:
  /// ```dart
  /// CommandItem(
  ///   leading: Icon(Icons.file_copy),
  ///   title: Text('Duplicate'),
  ///   trailing: Text('Ctrl+D'),
  ///   onTap: () => duplicate(),
  /// )
  /// ```
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
