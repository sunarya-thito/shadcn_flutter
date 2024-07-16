import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class MenuButton extends StatefulWidget {
  final Widget child;
  final List<Widget>? subMenu;
  final VoidCallback? onPressed;
  final Widget? trailing;
  final Widget? leading;
  final bool enabled;
  final FocusScopeNode? focusScopeNode;

  MenuButton({
    required this.child,
    this.subMenu,
    this.onPressed,
    this.trailing,
    this.leading,
    this.enabled = true,
    this.focusScopeNode,
  });

  @override
  State<MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<MenuButton> {
  late FocusScopeNode? _focusScopeNode;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = widget.focusScopeNode ?? FocusScopeNode();
  }

  @override
  void didUpdateWidget(covariant MenuButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.focusScopeNode != oldWidget.focusScopeNode) {
      _focusScopeNode = widget.focusScopeNode ?? FocusScopeNode();
    }
  }

  @override
  Widget build(BuildContext context) {
    final menuBarData = Data.maybeOf<MenubarData>(context);
    final menuData = Data.maybeOf<MenuData>(context);
    assert(menuData != null || menuBarData != null,
        'MenuButton must be a descendant of Menubar or Menu');
    var focusNode = menuBarData?.focusScopeNode ?? menuData!.focusScopeNode;
    var parentFocusNode =
        menuBarData?.parentFocusScopeNode ?? menuData!.parentFocusScopeNode;
    return Popover(
      builder: (context) {
        return Button(
          style: (menuBarData == null
                  ? ButtonVariance.menu
                  : ButtonVariance.menubar)
              .copyWith(
            margin: (context, states, value) {
              return value;
            },
          ),
          trailing: widget.trailing,
          leading: widget.leading,
          disableTransition: true,
          enabled: widget.enabled,
          focusNode: focusNode,
          onHover: (value) {
            if (value && parentFocusNode.hasFocus) {
              context.showPopover();
            }
          },
          onPressed: () {
            widget.onPressed?.call();
            if (widget.subMenu != null) {
              context.showPopover();
            }
          },
          child: widget.child,
        );
      },
      popoverBuilder: (context) {
        if (widget.subMenu != null) {
          return FocusScope(
            node: _focusScopeNode!,
            child: MenuGroup(
              dataBuilder: () {
                return MenuData(
                  parentFocusScopeNode: _focusScopeNode!,
                );
              },
              children: widget.subMenu!,
              builder: (context, children) {
                return MenuPopup(
                  children: children,
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
      alignment: Alignment.topLeft,
      anchorAlignment: Alignment.bottomLeft,
    );
  }
}

class MenubarData extends MenuData {
  MenubarData({required super.parentFocusScopeNode});
}

class MenuData {
  final GlobalKey itemKey = GlobalKey();
  final GlobalKey popupKey = GlobalKey();
  final FocusScopeNode focusScopeNode = FocusScopeNode();
  final FocusScopeNode parentFocusScopeNode;

  late int _index;
  late int _length;

  MenuData({required this.parentFocusScopeNode});
}

class MenuGroup<T extends MenuData> extends StatefulWidget {
  final List<Widget> children;
  final T Function() dataBuilder;
  final Widget Function(BuildContext context, List<Widget> children) builder;

  MenuGroup({
    super.key,
    required this.dataBuilder,
    required this.children,
    required this.builder,
  });

  @override
  State<MenuGroup<T>> createState() => _MenuGroupState<T>();
}

class _MenuGroupState<T extends MenuData> extends State<MenuGroup<T>> {
  late List<T> _data;

  @override
  void initState() {
    super.initState();
    _data = List.generate(widget.children.length, (i) {
      return widget.dataBuilder()
        .._index = i
        .._length = widget.children.length;
    });
  }

  @override
  void didUpdateWidget(covariant MenuGroup<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(oldWidget.children, widget.children)) {
      _data =
          List.generate(widget.children.length, (i) => widget.dataBuilder());
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    for (int i = 0; i < widget.children.length; i++) {
      final child = widget.children[i];
      final data = _data[i];
      children.add(
        Data<T>(
          data: data,
          child: child,
        ),
      );
    }
    return widget.builder(context, children);
  }
}
