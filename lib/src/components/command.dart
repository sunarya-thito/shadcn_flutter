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

class Command extends StatefulWidget {
  final CommandBuilder builder;
  final Duration
      debounceDuration; // debounce is used to prevent too many requests
  final WidgetBuilder? emptyBuilder;
  final ErrorWidgetBuilder? errorBuilder;
  final WidgetBuilder? loadingBuilder;

  const Command({
    Key? key,
    required this.builder,
    this.debounceDuration = const Duration(milliseconds: 500),
    this.emptyBuilder,
    this.errorBuilder,
    this.loadingBuilder,
  }) : super(key: key);

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
    return IntrinsicWidth(
      child: OutlinedContainer(
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  size: 16,
                  color: theme.colorScheme.mutedForeground,
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    border: false,
                    // focusNode: _textFieldFocus,
                    placeholder: ShadcnLocalizations.of(context).commandSearch,
                  ),
                ),
                if (canPop)
                  DenseButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Icon(
                      Icons.close,
                      size: 16,
                    ),
                  ),
              ],
            ).withPadding(horizontal: 12),
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
                            items.add(IconTheme(
                              data: IconThemeData(
                                color: theme.colorScheme.mutedForeground,
                              ),
                              child: const Center(
                                      child: CircularProgressIndicator())
                                  .withPadding(vertical: 24),
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
                                .withPadding(vertical: 24);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CommandCategory extends StatelessWidget {
  final List<Widget> children;
  final Widget? title;

  const CommandCategory({
    Key? key,
    required this.children,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (title != null)
          title!
              .withPadding(horizontal: 8, vertical: 6)
              .medium()
              .xSmall()
              .muted(),
        ...children,
      ],
    ).withPadding(all: 4);
  }
}

class CommandItem extends StatefulWidget {
  final Widget? leading;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CommandItem({
    Key? key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  }) : super(key: key);

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
                : Colors.transparent,
            borderRadius: BorderRadius.circular(themeData.radiusSm),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          child: AnimatedIconTheme(
            duration: kDefaultDuration,
            data: IconThemeData(
              size: 15,
              color: widget.onTap != null
                  ? themeData.colorScheme.accentForeground
                  : themeData.colorScheme.accentForeground.withOpacity(0.5),
            ),
            child: AnimatedDefaultTextStyle(
              style: TextStyle(
                color: widget.onTap != null
                    ? themeData.colorScheme.accentForeground
                    : themeData.colorScheme.accentForeground.withOpacity(0.5),
              ),
              duration: kDefaultDuration,
              child: Row(
                children: [
                  if (widget.leading != null) widget.leading!,
                  if (widget.leading != null) gap(8),
                  Expanded(child: widget.title),
                  if (widget.trailing != null) gap(8),
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
