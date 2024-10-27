import 'package:shadcn_flutter/shadcn_flutter.dart';

class Tabs extends StatelessWidget {
  final int index;
  final ValueChanged<int> onChanged;
  final List<Widget> tabs;

  const Tabs({
    super.key,
    required this.index,
    required this.onChanged,
    required this.tabs,
  });

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
              for (var i = 0; i < tabs.length; i++)
                Expanded(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      onChanged(i);
                    },
                    child: MouseRegion(
                      hitTestBehavior: HitTestBehavior.translucent,
                      cursor: SystemMouseCursors.click,
                      child: ShadcnAnimatedContainer(
                        duration: const Duration(
                            milliseconds:
                                50), // slightly faster than kDefaultDuration
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 4,
                            ) *
                            scaling,
                        decoration: BoxDecoration(
                          color:
                              i == index ? theme.colorScheme.background : null,
                          borderRadius: BorderRadius.circular(
                            theme.radiusMd,
                          ),
                        ),
                        child: (i == index
                                ? tabs[i].foreground()
                                : tabs[i].muted())
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
