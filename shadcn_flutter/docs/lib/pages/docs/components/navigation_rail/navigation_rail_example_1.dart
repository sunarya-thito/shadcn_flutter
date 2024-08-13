import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationRailExample1 extends StatefulWidget {
  const NavigationRailExample1({super.key});

  @override
  State<NavigationRailExample1> createState() => _NavigationRailExample1State();
}

class _NavigationRailExample1State extends State<NavigationRailExample1> {
  int selected = 0;

  Widget buildButton(int i, String label, IconData icon) {
    return NavigationButton(
      onChanged: (value) {
        setState(() {
          selected = i;
        });
      },
      selected: selected == i,
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NavigationRail(
            children: [
              buildButton(0, 'Home', BootstrapIcons.house),
              buildButton(1, 'Explore', BootstrapIcons.compass),
              buildButton(2, 'Library', BootstrapIcons.musicNoteList),
              NavigationDivider(),
              NavigationLabel(child: Text('Settings')),
              buildButton(3, 'Profile', BootstrapIcons.person),
              buildButton(4, 'App', BootstrapIcons.appIndicator),
              NavigationDivider(),
              NavigationGap(12),
              FlutterLogo(),
            ],
          ),
          const VerticalDivider(),
          Expanded(
              child: Container(
            color: Colors.primaries[Colors.primaries.length - selected - 1],
          )),
        ],
      ),
    );
  }
}
