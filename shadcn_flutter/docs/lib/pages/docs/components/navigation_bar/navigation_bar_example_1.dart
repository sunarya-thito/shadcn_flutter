import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationBarExample1 extends StatefulWidget {
  @override
  State<NavigationBarExample1> createState() => _NavigationBarExample1State();
}

class _NavigationBarExample1State extends State<NavigationBarExample1> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            color: Colors.primaries[Colors.primaries.length - selected - 1],
          )),
          const Divider(),
          NavigationBar(
            children: [
              buildButton(0, 'Home', BootstrapIcons.house),
              buildButton(1, 'Explore', BootstrapIcons.compass),
              buildButton(2, 'Library', BootstrapIcons.musicNoteList),
            ],
          ),
        ],
      ),
    );
  }
}
