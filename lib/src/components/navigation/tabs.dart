import 'package:shadcn_flutter/shadcn_flutter.dart';

class Tabs extends StatefulWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final List<Widget> tabs;
  final EdgeInsetsGeometry? padding;
  final Color? hoverColor;
  final double? marginBetweenItems;

  const Tabs({
    super.key,
    required this.index,
    required this.onChanged,
    required this.tabs,
    this.padding,
    this.hoverColor,
    this.marginBetweenItems,
  });

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  int? hoveredIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scaling = theme.scaling;
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.muted,
        borderRadius: BorderRadius.circular(theme.radiusLg),
      ),
      padding: const EdgeInsets.all(4) * scaling,
      child: IntrinsicHeight(
        child: IntrinsicWidth(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var i = 0; i < widget.tabs.length; i++)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      widget.onChanged(i);
                    },
                    child: MouseRegion(
                      hitTestBehavior: HitTestBehavior.translucent,
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => setState(() => hoveredIndex = i),
                      onExit: (_) => setState(() => hoveredIndex = null),
                      child: AnimatedContainer(
                        margin: EdgeInsets.only(
                            right: widget.marginBetweenItems ?? 1),
                        duration: const Duration(milliseconds: 50),
                        alignment: Alignment.center,
                        padding: widget.padding ??
                            const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 4,
                                ) *
                                scaling,
                        decoration: BoxDecoration(
                          color: i == widget.index
                              ? theme.colorScheme.background
                              : hoveredIndex == i
                                  ? widget.hoverColor ??
                                      theme.colorScheme.primaryForeground
                                  : null,
                          borderRadius: BorderRadius.circular(
                            theme.radiusMd,
                          ),
                        ),
                        child: (i == widget.index
                                ? widget.tabs[i].foreground()
                                : widget.tabs[i].muted())
                            .small()
                            .medium(),
                      ),
                    ),
                  ),
                ),
            ],
          ).muted(),
        ),
      ),
    );
  }
}
