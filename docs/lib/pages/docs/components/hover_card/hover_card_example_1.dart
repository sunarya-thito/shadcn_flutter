import 'package:shadcn_flutter/shadcn_flutter.dart';

class HoverCardExample1 extends StatelessWidget {
  const HoverCardExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return HoverCard(
      hoverBuilder: (context) {
        return const SurfaceCard(
          child: Basic(
            leading: FlutterLogo(),
            title: Text('@flutter'),
            content: Text(
                'The Flutter SDK provides the tools to build beautiful apps for mobile, web, and desktop from a single codebase.'),
          ),
        ).sized(width: 300);
      },
      child: LinkButton(
        onPressed: () {},
        child: const Text('@flutter'),
      ),
    );
  }
}
