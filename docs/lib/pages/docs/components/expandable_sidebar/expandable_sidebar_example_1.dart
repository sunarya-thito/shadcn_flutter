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
      child: Icon(icon),
      selectedStyle: ButtonStyle.primaryIcon(),
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
                child: Icon(Icons.menu),
                alignment: Alignment.centerLeft,
                label: Text('Menu'),
                onPressed: () {
                  setState(() {
                    expanded = !expanded;
                  });
                },
              ),
              NavigationDivider(),
              buildLabel('You'),
              buildButton('Home', Icons.home_filled),
              buildButton('Trending', Icons.trending_up),
              buildButton('Subscription', Icons.subscriptions),
              NavigationDivider(),
              buildLabel('History'),
              buildButton('History', Icons.history),
              buildButton('Watch Later', Icons.access_time_rounded),
              NavigationDivider(),
              buildLabel('Movie'),
              buildButton('Action', Icons.movie_creation_outlined),
              buildButton('Horror', Icons.movie_creation_outlined),
              buildButton('Thriller', Icons.movie_creation_outlined),
              NavigationDivider(),
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
