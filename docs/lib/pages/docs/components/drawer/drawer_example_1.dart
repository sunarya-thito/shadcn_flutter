import 'package:shadcn_flutter/shadcn_flutter.dart';

class DrawerExample1 extends StatefulWidget {
  const DrawerExample1({super.key});

  @override
  State<DrawerExample1> createState() => _DrawerExample1State();
}

class _DrawerExample1State extends State<DrawerExample1> {
  List<OverlayPosition> positions = [
    OverlayPosition.left,
    OverlayPosition.left,
    OverlayPosition.bottom,
    OverlayPosition.bottom,
    OverlayPosition.top,
    OverlayPosition.top,
    OverlayPosition.right,
    OverlayPosition.right,
  ];
  void open(BuildContext context, int count) {
    openDrawer(
      context: context,
      expands: true,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Drawer ${count + 1} at ${positions[count % positions.length].name}'),
              const Gap(16),
              PrimaryButton(
                onPressed: () {
                  open(context, count + 1);
                },
                child: const Text('Open Another Drawer'),
              ),
            ],
          ),
        );
      },
      position: positions[count % positions.length],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        open(context, 0);
      },
      child: const Text('Open Drawer'),
    );
  }
}
