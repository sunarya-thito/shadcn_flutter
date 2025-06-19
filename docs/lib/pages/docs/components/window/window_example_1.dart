import 'package:docs/debug.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class WindowExample1 extends StatefulWidget {
  const WindowExample1({super.key});

  @override
  State<WindowExample1> createState() => _WindowExample1State();
}

class _WindowExample1State extends State<WindowExample1> {
  final GlobalKey<WindowNavigatorHandle> navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedContainer(
          height: 600, // for example purpose
          child: WindowNavigator(
            key: navigatorKey,
            initialWindows: [
              Window(
                bounds: const Rect.fromLTWH(0, 0, 200, 200),
                title: const Text('Window 1'),
                content: const RebuildCounter(),
              ),
              Window(
                bounds: const Rect.fromLTWH(200, 0, 200, 200),
                title: const Text('Window 2'),
                content: const RebuildCounter(),
              ),
            ],
            child: const Center(
              child: Text('Desktop'),
            ),
          ),
        ),
        PrimaryButton(
          child: const Text('Add Window'),
          onPressed: () {
            navigatorKey.currentState?.pushWindow(
              Window(
                bounds: const Rect.fromLTWH(0, 0, 200, 200),
                title: Text(
                    'Window ${navigatorKey.currentState!.windows.length + 1}'),
                content: const RebuildCounter(),
              ),
            );
          },
        )
      ],
    );
  }
}
