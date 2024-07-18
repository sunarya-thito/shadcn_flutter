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

  void _show() {
    if (_popoverController.hasOpenPopovers) {
      return;
    }
    _popoverController.show(
      context: context,
      builder: buildPopover,
      alignment: Alignment.topLeft,
      anchorAlignment: Alignment.bottomLeft,
      regionGroupId: this,
      transitionAlignment: Alignment.center,
      offset: const Offset(0, 6),
    );
  }

  void _activate(NavigationItemState item) {
    if (item.widget.content == null) {
      _popoverController.closeLater();
      return;
    }
    final index = widget.children.indexOf(item.widget);
    _activeIndex.value = index;
    _show();
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
        child: Data<NavigationMenuMarginData>.boundary(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: _contentBuilders[item]!(context),
          ),
        ),
      );
    }
    return Container();
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
            _popoverController.close();
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

  @override
  Widget build(BuildContext context) {
    Offset? margin;
    RenderBox? box = context.findRenderObject() as RenderBox?;
    if (box != null) {
      Offset globalPosition = box.localToGlobal(Offset.zero);
      Size size = box.size;
      margin = globalPosition + Offset(0, size.height);
    }
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
              _popoverController.close();
            }
          });
        },
        child: IntrinsicHeight(
          child: Data(
            data: this,
            child: Data(
              data: NavigationMenuMarginData(margin),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widget.children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationMenuMarginData {
  final Offset? offset;

  NavigationMenuMarginData(this.offset);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NavigationMenuMarginData && other.offset == offset;
  }

  @override
  int get hashCode => offset.hashCode;
}
