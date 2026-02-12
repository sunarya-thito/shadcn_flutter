import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a vertical NavigationSidebar with labels, dividers, and gaps.
// Selection is index-based and controlled by local state.

class NavigationSidebarExample1 extends StatefulWidget {
  const NavigationSidebarExample1({super.key});

  @override
  State<NavigationSidebarExample1> createState() =>
      _NavigationSidebarExample1State();
}

class _NavigationSidebarExample1State extends State<NavigationSidebarExample1> {
  // Currently selected item index in the sidebar.
  Key? selected = const ValueKey(0);

  Widget buildButton(String label, IconData icon, Key key) {
    // Helper for a standard navigation item with text label and icon.
    return NavigationItem(
      key: key,
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
          // Wire selection to local state.
          selectedKey: selected,
          onSelected: (key) {
            setState(() {
              selected = key;
            });
          },
          children: [
            // A mix of labels, gaps, dividers, and items can be used to
            // structure the navigation list into logical sections.
            const NavigationGroup(label: Text('Discovery')),
            buildButton(
                'Listen Now', BootstrapIcons.playCircle, const ValueKey(0)),
            buildButton('Browse', BootstrapIcons.grid, const ValueKey(1)),
            buildButton('Radio', BootstrapIcons.broadcast, const ValueKey(2)),
            const NavigationGap(24),
            const NavigationDivider(),
            const NavigationGroup(label: Text('Library')),
            buildButton(
                'Playlist', BootstrapIcons.musicNoteList, const ValueKey(3)),
            buildButton('Songs', BootstrapIcons.musicNote, const ValueKey(4)),
            buildButton('For You', BootstrapIcons.person, const ValueKey(5)),
            buildButton('Artists', BootstrapIcons.mic, const ValueKey(6)),
            buildButton('Albums', BootstrapIcons.record2, const ValueKey(7)),
            const NavigationGap(24),
            const NavigationDivider(),
            const NavigationGroup(label: Text('Playlists')),
            buildButton('Recently Added', BootstrapIcons.musicNoteList,
                const ValueKey(8)),
            buildButton('Recently Played', BootstrapIcons.musicNoteList,
                const ValueKey(9)),
            buildButton(
                'Top Songs', BootstrapIcons.musicNoteList, const ValueKey(10)),
            buildButton(
                'Top Albums', BootstrapIcons.musicNoteList, const ValueKey(11)),
            buildButton('Top Artists', BootstrapIcons.musicNoteList,
                const ValueKey(12)),
            buildButton('Logic Discography With Some Spice',
                BootstrapIcons.musicNoteList, const ValueKey(13)),
            buildButton('Bedtime Beats', BootstrapIcons.musicNoteList,
                const ValueKey(14)),
            buildButton('Feeling Happy', BootstrapIcons.musicNoteList,
                const ValueKey(15)),
            buildButton('I miss Y2K Pop', BootstrapIcons.musicNoteList,
                const ValueKey(16)),
            buildButton(
                'Runtober', BootstrapIcons.musicNoteList, const ValueKey(17)),
          ],
        ),
      ),
    );
  }
}
