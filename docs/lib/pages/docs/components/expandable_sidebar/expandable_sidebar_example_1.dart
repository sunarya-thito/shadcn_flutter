import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates an "expandable" navigation rail that can collapse/expand labels
// while keeping the same selection model. The left rail hosts sections and items;
// the right side is just an empty content area for demo framing.

class ExpandableSidebarExample1 extends StatefulWidget {
  const ExpandableSidebarExample1({super.key});

  @override
  State<ExpandableSidebarExample1> createState() =>
      _ExpandableSidebarExample1State();
}

class _ExpandableSidebarExample1State extends State<ExpandableSidebarExample1> {
  // When true, the rail expands to show labels; when false, it collapses to
  // an icon-only sidebar.
  bool expanded = false;

  // Currently selected navigation index. This feeds NavigationRail.index and is
  // set via onSelected below.
  int selected = 0;

  NavigationItem buildButton(String text, IconData icon) {
    // Convenience factory for a selectable navigation item with left alignment
    // and a primary icon style when selected.
    return NavigationItem(
      label: Text(text),
      alignment: Alignment.centerLeft,
      selectedStyle: const ButtonStyle.primaryIcon(),
      child: Icon(icon),
    );
  }

  NavigationLabel buildLabel(String label) {
    // Section header used to group related navigation items.
    return NavigationLabel(
      alignment: Alignment.centerLeft,
      child: Text(label).semiBold().muted(),
      // padding: EdgeInsets.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedContainer(
      // Frame the example and fix a size so expansion is obvious.
      height: 600,
      width: 800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationRail(
            backgroundColor: theme.colorScheme.card,
            // Expand/collapse behavior is handled by the `expanded` boolean.
            // With labelType.expanded, labels are hidden when collapsed.
            labelType: NavigationLabelType.expanded,
            labelPosition: NavigationLabelPosition.end,
            alignment: NavigationRailAlignment.start,
            expanded: expanded,
            // Bind the selected index to update highlights and semantics.
            index: selected,
            onSelected: (value) {
              setState(() {
                selected = value;
              });
            },
            children: [
              NavigationButton(
                alignment: Alignment.centerLeft,
                label: const Text('Menu'),
                onPressed: () {
                  setState(() {
                    // Toggle between expanded and collapsed rail.
                    expanded = !expanded;
                  });
                },
                child: const Icon(Icons.menu),
              ),
              const NavigationDivider(),
              buildLabel('You'),
              buildButton('Home', Icons.home_filled),
              buildButton('Trending', Icons.trending_up),
              buildButton('Subscription', Icons.subscriptions),
              const NavigationDivider(),
              buildLabel('History'),
              buildButton('History', Icons.history),
              buildButton('Watch Later', Icons.access_time_rounded),
              const NavigationDivider(),
              buildLabel('Movie'),
              buildButton('Action', Icons.movie_creation_outlined),
              buildButton('Horror', Icons.movie_creation_outlined),
              buildButton('Thriller', Icons.movie_creation_outlined),
              const NavigationDivider(),
              buildLabel('Short Films'),
              buildButton('Action', Icons.movie_creation_outlined),
              buildButton('Horror', Icons.movie_creation_outlined),
            ],
          ),
          const VerticalDivider(),
          // Placeholder for the main content area.
          const Flexible(child: SizedBox()),
        ],
      ),
    );
  }
}
