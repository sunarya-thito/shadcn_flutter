import 'package:flutter/services.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter/src/components/layout/focus_outline.dart';

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

class _Query {
  final Stream<List<Widget>> stream;
  final String? query;

  _Query({required this.stream, this.query});
}

class _CommandState extends State<Command> {
  final TextEditingController _controller = TextEditingController();
  late _Query _currentRequest;

  int requestCount = 0;
  final List<_CommandItemState> _attached = [];
  _CommandItemState? _currentItem;
  bool _disposed = false;

  bool _attach(_CommandItemState item) {
    _attached.add(item);
    _currentItem ??= item;
    return _currentItem == item;
  }

  void _detach(_CommandItemState item) {
    if (_disposed) return;
    _attached.remove(item);
    if (_currentItem == item) {
      _currentItem = null;
    }
  }

  void _next() {
    if (!context.mounted) return;
    if (_currentItem != null) {
      RenderBox currentBox =
          _currentItem!.context.findRenderObject() as RenderBox;
      RenderBox parentBox = context.findRenderObject() as RenderBox;
      Offset currentOffset =
          currentBox.localToGlobal(Offset.zero, ancestor: parentBox);
      (_CommandItemState, double)? nearestNextItem;
      for (var item in _attached) {
        if (item == _currentItem) continue;
        RenderBox box = item.context.findRenderObject() as RenderBox;
        Offset offset = box.localToGlobal(Offset.zero, ancestor: parentBox);
        double distance = offset.dy - currentOffset.dy;
        if (distance < 0) continue;
        if (nearestNextItem == null || distance < nearestNextItem.$2) {
          nearestNextItem = (item, distance);
        }
      }
      if (nearestNextItem != null) {
        _setCurrentItem(nearestNextItem.$1, true);
      }
    }
  }

  void _previous() {
    if (!context.mounted) return;
    if (_currentItem != null) {
      RenderBox currentBox =
          _currentItem!.context.findRenderObject() as RenderBox;
      RenderBox parentBox = context.findRenderObject() as RenderBox;
      Offset currentOffset =
          currentBox.localToGlobal(Offset.zero, ancestor: parentBox);
      (_CommandItemState, double)? nearestPrevItem;
      for (var item in _attached) {
        if (item == _currentItem) continue;
        RenderBox box = item.context.findRenderObject() as RenderBox;
        Offset offset = box.localToGlobal(Offset.zero, ancestor: parentBox);
        double distance = currentOffset.dy - offset.dy;
        if (distance < 0) continue;
        if (nearestPrevItem == null || distance < nearestPrevItem.$2) {
          nearestPrevItem = (item, distance);
        }
      }
      if (nearestPrevItem != null) {
        _setCurrentItem(nearestPrevItem.$1, false);
      }
    }
  }

  void _setCurrentItem(_CommandItemState item, bool? forward) {
    final currentItem = _currentItem;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      currentItem?.focus(false);
      item.focus(true);
      Scrollable.ensureVisible(
        item.context,
        alignmentPolicy: forward == null
            ? ScrollPositionAlignmentPolicy.explicit
            : forward
                ? ScrollPositionAlignmentPolicy.keepVisibleAtEnd
                : ScrollPositionAlignmentPolicy.keepVisibleAtStart,
      );
    });
    _currentItem = item;
  }

  Stream<List<Widget>> _request(BuildContext context, String? query) async* {
    _currentItem = null;
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
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    bool canPop = Navigator.of(context).canPop();
    final localization = ShadcnLocalizations.of(context);
    return Data.inherit(
      data: this,
      child: Actions(
        actions: {
          NextItemIntent: CallbackAction<NextItemIntent>(
            onInvoke: (intent) {
              _next();
              return null;
            },
          ),
          PreviousItemIntent: CallbackAction<PreviousItemIntent>(
            onInvoke: (intent) {
              _previous();
              return null;
            },
          ),
          ActivateIntent: CallbackAction<ActivateIntent>(
            onInvoke: (intent) {
              _currentItem?.select();
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
  bool _hasFocus = false;
  _CommandState? _state;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newState = Data.maybeOf<_CommandState>(context);
    if (_state != newState) {
      _state?._detach(this);
      _state = newState;
      _hasFocus = _state?._attach(this) ?? false;
    }
  }

  void focus(bool focus) {
    setState(() {
      _hasFocus = focus;
    });
  }

  void select() {
    widget.onTap?.call();
  }

  @override
  void dispose() {
    _state?._detach(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themeData = Theme.of(context);
    return Clickable(
      onPressed: widget.onTap,
      onHover: (hovered) {
        setState(() {
          if (hovered) {
            _state?._currentItem?.focus(false);
            _state?._currentItem = this;
            _hasFocus = true;
          }
        });
      },
      child: AnimatedContainer(
        duration: kDefaultDuration,
        decoration: BoxDecoration(
          color: _hasFocus
              ? themeData.colorScheme.accent
              : themeData.colorScheme.accent.withValues(alpha: 0),
          borderRadius: BorderRadius.circular(themeData.radiusSm),
        ),
        padding: EdgeInsets.symmetric(
            horizontal: themeData.scaling * 8, vertical: themeData.scaling * 6),
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
                if (widget.trailing != null) widget.trailing!.muted().xSmall(),
              ],
            ).small(),
          ),
        ),
      ),
    );
  }
}
