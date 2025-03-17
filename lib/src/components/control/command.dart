import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef CommandBuilder = Stream<List<Widget>> Function(
    BuildContext context, String? query);

typedef ErrorWidgetBuilder = Widget Function(
    BuildContext context, Object error, StackTrace? stackTrace);

class CommandEmpty extends StatelessWidget {
  const CommandEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = ShadcnLocalizations.of(context);
    return Center(
        child:
            Text(localizations.commandEmpty).withPadding(vertical: 24).small());
  }
}

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

class _CommandState extends State<Command> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<String?> query = ValueNotifier<String?>(null);

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
    _controller.addListener(() {
      String? newQuery = _controller.text;
      if (newQuery.isEmpty) newQuery = null;
      if (newQuery != query.value) {
        query.value = newQuery;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool canPop = Navigator.of(context).canPop();
    return FocusScope(
      child: IntrinsicWidth(
        child: OutlinedContainer(
          clipBehavior: Clip.hardEdge,
          surfaceBlur: widget.surfaceBlur ?? theme.surfaceBlur,
          surfaceOpacity: widget.surfaceOpacity ?? theme.surfaceOpacity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(
                    LucideIcons.search,
                  ).iconSmall().iconMutedForeground(),
                  Expanded(
                    child: TextField(
                      autofocus: true,
                      controller: _controller,
                      border: false,
                      // focusNode: _textFieldFocus,
                      placeholder: widget.searchPlaceholder ??
                          Text(ShadcnLocalizations.of(context).commandSearch),
                    ),
                  ),
                  if (canPop)
                    GhostButton(
                      density: ButtonDensity.iconDense,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(
                        LucideIcons.x,
                      ).iconSmall(),
                    ),
                ],
              ).withPadding(horizontal: theme.scaling * 12),
              const Divider(),
              Expanded(
                child: ValueListenableBuilder(
                    valueListenable: query,
                    builder: (context, value, child) {
                      return StreamBuilder(
                        stream: _request(context, value),
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
                              shrinkWrap: true,
                              itemCount: items.length,
                              itemBuilder: (context, index) => items[index],
                            );
                          }
                          return widget.loadingBuilder?.call(context) ??
                              const Center(child: CircularProgressIndicator())
                                  .withPadding(vertical: theme.scaling * 24);
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
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
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: FocusableActionDetector(
        autofocus: true,
        enabled: widget.onTap != null,
        mouseCursor: SystemMouseCursors.click,
        focusNode: _focusNode,
        onShowHoverHighlight: (value) {
          if (value && widget.onTap != null) {
            if (!_focusNode.hasFocus) {
              _focusNode.requestFocus();
            }
          }
        },
        actions: {
          ActivateIntent: CallbackAction(
            onInvoke: (e) {
              if (widget.onTap != null) {
                widget.onTap!();
                return true;
              }
              return false;
            },
          ),
        },
        shortcuts: {
          LogicalKeySet(LogicalKeyboardKey.enter): const ActivateIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp):
              const DirectionalFocusIntent(TraversalDirection.up),
          LogicalKeySet(LogicalKeyboardKey.arrowDown):
              const DirectionalFocusIntent(TraversalDirection.down),
          LogicalKeySet(LogicalKeyboardKey.arrowLeft):
              const DirectionalFocusIntent(TraversalDirection.left),
          LogicalKeySet(LogicalKeyboardKey.arrowRight):
              const DirectionalFocusIntent(TraversalDirection.right),
        },
        child: AnimatedContainer(
          duration: kDefaultDuration,
          decoration: BoxDecoration(
            color: _focusNode.hasFocus
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
                    : themeData.colorScheme.accentForeground.scaleAlpha(0.5),
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
      ),
    );
  }
}
