import 'package:shadcn_flutter/shadcn_flutter.dart';

class HoverCardExample1 extends StatelessWidget {
  const HoverCardExample1({super.key});

  @override
  Widget build(BuildContext context) {
    // HoverCard shows a floating panel when the user hovers over the child.
    // - hoverBuilder builds the content of the floating card.
    // - child is the anchor widget users point at/hover to reveal the card.
    return HoverCard(
      hoverBuilder: (context) {
        // SurfaceCard provides an elevated container with default padding and
        // surface styling. We constrain the width so the text wraps nicely.
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
        // The LinkButton acts as the hover target. onPressed is provided for
        // completeness but not used in this example.
        onPressed: () {},
        child: const Text('@flutter'),
      ),
    );
  }
}
