import 'package:shadcn_flutter/shadcn_flutter.dart';

class ExpandableSidebarExample1 extends StatefulWidget {
  const ExpandableSidebarExample1({super.key});

  @override
  State<ExpandableSidebarExample1> createState() =>
      _ExpandableSidebarExample1State();
}

class _ExpandableSidebarExample1State extends State<ExpandableSidebarExample1> {
  bool expanded = false;
  int selected = 0;

  NavigationItem buildButton(String text, IconData icon) {
    return NavigationItem(
      label: Text(text),
      alignment: Alignment.centerLeft,
      selectedStyle: const ButtonStyle.primaryIcon(),
      child: Icon(icon),
    );
  }

  NavigationLabel buildLabel(String label) {
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
      height: 600,
      width: 800,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationRail(
            backgroundColor: theme.colorScheme.card,
            labelType: NavigationLabelType.expanded,
            labelPosition: NavigationLabelPosition.end,
            alignment: NavigationRailAlignment.start,
            expanded: expanded,
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
          const Flexible(child: SizedBox()),
        ],
      ),
    );
  }
}
