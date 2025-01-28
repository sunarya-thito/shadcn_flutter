import 'package:shadcn_flutter/shadcn_flutter.dart';

class ExpandableSidebarExample1 extends StatefulWidget {
  const ExpandableSidebarExample1({super.key});

  @override
  State<ExpandableSidebarExample1> createState() =>
      _ExpandableSidebarExample1State();
}

class _ExpandableSidebarExample1State extends State<ExpandableSidebarExample1> {
  NavigationButton buildButton(String text, IconData icon) {
    return NavigationButton(
      label: Text(text),
      alignment: Alignment.centerLeft,
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      children: [
        buildButton('Home', Icons.home_filled),
        buildButton('Trending', Icons.trending_up),
        buildButton('Subscription', Icons.subscriptions),
        NavigationLabel(child: Text('You')),
        buildButton('History', Icons.history),
        buildButton('Watch Later', Icons.access_time_rounded),
        NavigationLabel(child: Text('Movie')),
        buildButton('Action', Icons.movie_creation_outlined),
        buildButton('Horror', Icons.movie_creation_outlined),
        buildButton('Thriller', Icons.movie_creation_outlined),
        NavigationLabel(child: Text('Short Films')),
        buildButton('Action', Icons.movie_creation_outlined),
        buildButton('Horror', Icons.movie_creation_outlined),
        buildButton('Thriller', Icons.movie_creation_outlined),
      ],
    );
  }
}
