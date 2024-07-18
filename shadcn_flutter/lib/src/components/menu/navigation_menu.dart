import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationItem extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget? content;
  final Widget child;

  const NavigationItem({this.onPressed, this.content, required this.child});

  @override
  State<NavigationItem> createState() => NavigationItemState();
}

class NavigationItemState extends State<NavigationItem> {
  NavigationMenuState? _menuState;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var newMenuState = Data.maybeOf<NavigationMenuState>(context);
    assert(newMenuState != null,
        'NavigationItem must be a descendant of NavigationMenu');
    if (_menuState != newMenuState) {
      _menuState = newMenuState;
      if (widget.content != null) {
        _menuState!._attachContentBuilder(
          this,
          (context) {
            return widget.content!;
          },
        );
      }
    }
  }

  @override
  void didUpdateWidget(covariant NavigationItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.content != oldWidget.content) {
      if (widget.content != null) {
        _menuState!._attachContentBuilder(
          this,
          (context) {
            return widget.content!;
          },
        );
      } else {
        _menuState!._contentBuilders.remove(this);
      }
    }
  }

  @override
  void dispose() {
    if (widget.content != null) {
      _menuState!._contentBuilders.remove(this);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AnimatedBuilder(
        animation: Listenable.merge(
            [_menuState!._activeIndex, _menuState!._popoverController]),
        builder: (context, child) {
          return Button(
            style: const ButtonStyle.ghost().copyWith(
              decoration: (context, states, value) {
                if (_menuState!.isActive(this)) {
                  return (value as BoxDecoration).copyWith(
                    borderRadius: BorderRadius.circular(theme.radiusMd),
                    color: theme.colorScheme.muted.withOpacity(0.8),
                  );
                }
                return value;
              },
            ),
            child: widget.child,
            trailing: widget.content != null
                ? AnimatedRotation(
                    duration: kDefaultDuration,
                    turns: _menuState!.isActive(this) ? 0.5 : 0,
                    child: const Icon(
                      RadixIcons.chevronDown,
                      size: 12,
                    ),
                  )
                : null,
            onHover: (hovered) {
              if (hovered) {
                _menuState!._activate(this);
              }
            },
            onPressed: widget.onPressed != null || widget.content != null
                ? () {
                    if (widget.onPressed != null) {
                      widget.onPressed!();
                    }
                    if (widget.content != null) {
                      _menuState!._activate(this);
                    }
                  }
                : null,
          );
        });
  }
}

class NavigationContent extends StatelessWidget {
  final Widget title;
  final Widget? content;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;

  const NavigationContent({
    required this.title,
    this.content,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Button(
      style: ButtonVariance.ghost.copyWith(
        padding: (context, states, value) {
          return const EdgeInsets.all(12);
        },
      ),
      onPressed: onPressed,
      alignment: Alignment.topLeft,
      child: Basic(
        title: title.medium(),
        content: content?.muted(),
        trailing: trailing,
        leading: leading,
        mainAxisAlignment: MainAxisAlignment.start,
      ),
    ).constrained(maxWidth: 16 * 16);
  }
}

class NavigationContentList extends StatelessWidget {
  final List<Widget> children;
  final int crossAxisCount;
  final double spacing;
  final double runSpacing;
  final bool reverse;

  const NavigationContentList({
    required this.children,
    this.crossAxisCount = 3,
    this.spacing = 12,
    this.runSpacing = 12,
    this.reverse = false,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> columns = [];
    List<Widget> rows = [];
    for (final child in children) {
      columns.add(Expanded(child: child));
      if (columns.length == crossAxisCount) {
        rows.add(IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: columns.joinSeparator(SizedBox(height: spacing)),
          ),
        ));
        columns = [];
      }
    }
    if (columns.isNotEmpty) {
      rows.add(IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: columns.joinSeparator(SizedBox(height: runSpacing)),
        ),
      ));
    }
    return IntrinsicWidth(
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: (reverse ? rows.reversed.toList() : rows)
              .joinSeparator(SizedBox(width: spacing)),
        ),
      ),
    );
  }
}

class NavigationMenu extends StatefulWidget {
  final List<Widget> children;

  const NavigationMenu({required this.children});

  @override
  State<NavigationMenu> createState() => NavigationMenuState();
}

class NavigationMenuState extends State<NavigationMenu> {
  static const Duration kDebounceDuration = Duration(milliseconds: 200);
  // final GlobalKey<PopoverAnchorState> _popoverKey = GlobalKey();
  // final ValueNotifier<bool> _visible = ValueNotifier(false);
  final PopoverController _popoverController = PopoverController();
  final ValueNotifier<int> _activeIndex = ValueNotifier(0);
  final Map<NavigationItemState, WidgetBuilder> _contentBuilders = {};

  int _hoverCount = 0;

  void _attachContentBuilder(NavigationItemState key, WidgetBuilder builder) {
    _contentBuilders[key] = builder;
  }

  bool isActive(NavigationItemState item) {
    return _popoverController.hasOpenPopovers &&
        widget.children[_activeIndex.value] == item.widget;
  }

  @override
  void dispose() {
    _activeIndex.dispose();
    _popoverController.dispose();
    super.dispose();
  }

  void _show(BuildContext context) {
    if (_popoverController.hasOpenPopovers) {
      _popoverController.anchorContext = context;
      return;
    }
    _popoverController.show(
      context: context,
      alignment: Alignment.topCenter,
      regionGroupId: this,
      offset: const Offset(0, 4),
      builder: buildPopover,
      modal: false,
      margin: requestMargin() ?? const EdgeInsets.all(8),
      allowInvertHorizontal: false,
      allowInvertVertical: false,
      onTickFollow: (value) {
        value.margin = requestMargin() ?? const EdgeInsets.all(8);
      },
    );
  }

  void _activate(NavigationItemState item) {
    if (item.widget.content == null) {
      close();
      return;
    }
    final index = widget.children.indexOf(item.widget);
    _activeIndex.value = index;
    _show(item.context);
  }

  NavigationItemState? findByWidget(Widget widget) {
    return _contentBuilders.keys
        .where((key) => key.widget == widget)
        .firstOrNull;
  }

  Widget buildContent(int index) {
    NavigationItemState? item = findByWidget(widget.children[index]);
    if (item != null) {
      return Data<NavigationMenuState>.boundary(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: _contentBuilders[item]!(context),
        ),
      );
    }
    return Container();
  }

  void close() {
    _popoverController.close();
  }

  Widget buildPopover(BuildContext context) {
    final theme = Theme.of(context);
    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      onEnter: (_) {
        _hoverCount++;
      },
      onExit: (event) {
        int currentHoverCount = ++_hoverCount;
        Future.delayed(kDebounceDuration, () {
          if (currentHoverCount == _hoverCount && mounted) {
            close();
          }
        });
      },
      child: AnimatedBuilder(
          animation: _activeIndex,
          builder: (context, child) {
            return AnimatedValueBuilder<double>(
              value: _activeIndex.value.toDouble(),
              duration: kDefaultDuration,
              builder: (context, value, child) {
                int currentIndex = _activeIndex.value;
                return OutlinedContainer(
                  clipBehavior: Clip.antiAlias,
                  borderRadius: theme.radiusMd,
                  child: FractionalTranslation(
                    translation: Offset(-value + currentIndex, 0),
                    child: buildContent(currentIndex),
                  ),
                );
              },
            );
          }),
    );
  }

  EdgeInsets? requestMargin() {
    RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      Offset globalPosition = box.localToGlobal(Offset.zero);
      Size size = box.size;
      return EdgeInsets.only(
          left: globalPosition.dx,
          top: globalPosition.dy + size.height,
          right: 8,
          bottom: 8);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      groupId: this,
      child: MouseRegion(
        hitTestBehavior: HitTestBehavior.translucent,
        onEnter: (_) {
          _hoverCount++;
        },
        onExit: (_) {
          int currentHoverCount = ++_hoverCount;
          Future.delayed(kDebounceDuration, () {
            if (currentHoverCount == _hoverCount && mounted) {
              close();
            }
          });
        },
        child: IntrinsicHeight(
          child: Data(
            data: this,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.children,
            ),
          ),
        ),
      ),
    );
  }
}
