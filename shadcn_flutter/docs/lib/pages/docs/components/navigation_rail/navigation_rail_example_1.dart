import 'package:shadcn_flutter/shadcn_flutter.dart';

class NavigationRailExample1 extends StatelessWidget {
  const NavigationRailExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      child: Row(
        children: [
          NavigationRail(
            children: [],
          ),
        ],
      ),
    );
  }
}
