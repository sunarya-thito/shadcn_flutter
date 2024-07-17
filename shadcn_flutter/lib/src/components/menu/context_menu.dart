import 'package:shadcn_flutter/shadcn_flutter.dart';

class ContextMenu extends StatelessWidget {
  final Offset position;
  final List<MenuItem> children;
  final CapturedThemes? themes;
  const ContextMenu({
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
