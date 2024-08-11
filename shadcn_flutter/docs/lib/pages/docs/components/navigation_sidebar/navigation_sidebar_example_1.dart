import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationSidebarExample1 extends StatefulWidget {
  const NavigationSidebarExample1({Key? key}) : super(key: key);

  @override
  State<NavigationSidebarExample1> createState() =>
      _NavigationSidebarExample1State();
}

class _NavigationSidebarExample1State extends State<NavigationSidebarExample1> {
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
    return SizedBox(
      height: 400,
      child: OutlinedContainer(
        child: NavigationSidebar(
          children: [
            NavigationLabel(child: Text('Discover')),
            buildButton(0, 'Listen Now', BootstrapIcons.playCircle),
            buildButton(1, 'Browse', BootstrapIcons.grid),
            buildButton(2, 'Radio', BootstrapIcons.broadcast),
            SliverGap(24),
            NavigationDivider(),
            NavigationLabel(child: Text('Library')),
            buildButton(3, 'Playlist', BootstrapIcons.musicNoteList),
            buildButton(4, 'Songs', BootstrapIcons.musicNote),
            buildButton(5, 'For You', BootstrapIcons.person),
            buildButton(6, 'Artists', BootstrapIcons.mic),
            buildButton(7, 'Albums', BootstrapIcons.record2),
            SliverGap(24),
            NavigationDivider(),
            NavigationLabel(child: Text('Playlists')),
            buildButton(8, 'Recently Added', BootstrapIcons.musicNoteList),
            buildButton(9, 'Recently Played', BootstrapIcons.musicNoteList),
            buildButton(10, 'Top Songs', BootstrapIcons.musicNoteList),
            buildButton(11, 'Top Albums', BootstrapIcons.musicNoteList),
            buildButton(12, 'Top Artists', BootstrapIcons.musicNoteList),
            buildButton(13, 'Logic Discography', BootstrapIcons.musicNoteList),
            buildButton(14, 'Bedtime Beats', BootstrapIcons.musicNoteList),
            buildButton(15, 'Feeling Happy', BootstrapIcons.musicNoteList),
            buildButton(16, 'I miss Y2K Pop', BootstrapIcons.musicNoteList),
            buildButton(17, 'Runtober', BootstrapIcons.musicNoteList),
          ],
        ),
      ),
    );
  }
}
