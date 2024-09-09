import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationSidebarExample1 extends StatefulWidget {
  const NavigationSidebarExample1({super.key});

  @override
  State<NavigationSidebarExample1> createState() =>
      _NavigationSidebarExample1State();
}

class _NavigationSidebarExample1State extends State<NavigationSidebarExample1> {
  int selected = 0;

  NavigationBarItem buildButton(String label, IconData icon) {
    return NavigationButton(
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: OutlinedContainer(
        child: NavigationSidebar(
          index: selected,
          onSelected: (index) {
            setState(() {
              selected = index;
            });
          },
          children: [
            const NavigationLabel(child: Text('Discovery')),
            buildButton('Listen Now', BootstrapIcons.playCircle),
            buildButton('Browse', BootstrapIcons.grid),
            buildButton('Radio', BootstrapIcons.broadcast),
            const NavigationGap(24),
            const NavigationDivider(),
            const NavigationLabel(child: Text('Library')),
            buildButton('Playlist', BootstrapIcons.musicNoteList),
            buildButton('Songs', BootstrapIcons.musicNote),
            buildButton('For You', BootstrapIcons.person),
            buildButton('Artists', BootstrapIcons.mic),
            buildButton('Albums', BootstrapIcons.record2),
            const NavigationGap(24),
            const NavigationDivider(),
            const NavigationLabel(child: Text('Playlists')),
            buildButton('Recently Added', BootstrapIcons.musicNoteList),
            buildButton('Recently Played', BootstrapIcons.musicNoteList),
            buildButton('Top Songs', BootstrapIcons.musicNoteList),
            buildButton('Top Albums', BootstrapIcons.musicNoteList),
            buildButton('Top Artists', BootstrapIcons.musicNoteList),
            buildButton('Logic Discography With Some Spice',
                BootstrapIcons.musicNoteList),
            buildButton('Bedtime Beats', BootstrapIcons.musicNoteList),
            buildButton('Feeling Happy', BootstrapIcons.musicNoteList),
            buildButton('I miss Y2K Pop', BootstrapIcons.musicNoteList),
            buildButton('Runtober', BootstrapIcons.musicNoteList),
          ],
        ),
      ),
    );
  }
}
