import 'package:flutter/foundation.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class ContextMenu extends StatefulWidget {
  final Widget child;
  final List<MenuItem> items;
  final HitTestBehavior behavior;

  const ContextMenu({
    Key? key,
    required this.child,
    required this.items,
    this.behavior = HitTestBehavior.translucent,
  }) : super(key: key);

  @override
  State<ContextMenu> createState() => _ContextMenuState();
}

class _ContextMenuState extends State<ContextMenu> {
  late ValueNotifier<List<MenuItem>> _children;

  @override
  void initState() {
    super.initState();
    _children = ValueNotifier(widget.items);
  }

  @override
  void didUpdateWidget(covariant ContextMenu oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!listEquals(widget.items, oldWidget.items)) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _children.value = widget.items;
      });
    }
  }

  @override
  void dispose() {
    _children.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      groupId: this,
      child: GestureDetector(
        behavior: widget.behavior,
        onSecondaryTapDown: (details) {
          _showContextMenu(context, details.globalPosition, _children, this);
        },
        child: widget.child,
      ),
    );
  }
}

Future<void> _showContextMenu(
  BuildContext context,
  Offset position,
  ValueListenable<List<MenuItem>> children,
  Object? regionGroupId,
) async {
  final key = GlobalKey<PopoverAnchorState>();
  return showPopover(
    key: key,
    context: context,
    position: position + const Offset(8, 0),
    alignment: Alignment.topLeft,
    anchorAlignment: Alignment.topRight,
    regionGroupId: regionGroupId,
    modal: false,
    builder: (context) {
      return AnimatedBuilder(
          animation: children,
          builder: (context, child) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 192,
              ),
              child: MenuGroup(
                regionGroupId: regionGroupId,
                children: children.value,
                subMenuOffset: const Offset(8, -4),
                onDismissed: () {
                  Navigator.of(context).pop();
                },
                builder: (context, children) {
                  return MenuPopup(
                    children: children,
                  );
                },
              ),
            );
          });
    },
  );
}

class ContextMenuPopup extends StatelessWidget {
  final Offset position;
  final List<MenuItem> children;
  final CapturedThemes? themes;
  const ContextMenuPopup({
    Key? key,
    required this.position,
    required this.children,
    this.themes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedValueBuilder.animation(
      value: 1.0,
      initialValue: 0.0,
      durationBuilder: (a, b) {
        if (a < b) {
          // forward duration
          return Duration(milliseconds: 100);
        } else {
          // reverse duration
          return kDefaultDuration;
        }
      },
      builder: (context, animation) {
        return PopoverAnchor(
          position: position,
          alignment: Alignment.topLeft,
          themes: themes,
          builder: (context) {
            return ConstrainedBox(
              constraints: const BoxConstraints(
                minWidth: 192,
              ),
              child: MenuGroup(
                children: children,
                builder: (context, children) {
                  return MenuPopup(
                    children: children,
                  );
                },
              ),
            );
          },
          animation: animation,
          anchorAlignment: Alignment.topRight,
        );
      },
    );
  }
}
