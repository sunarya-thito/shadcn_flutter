import 'package:shadcn_flutter/shadcn_flutter.dart';

class DrawerExample1 extends StatefulWidget {
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
      // transformBackdrop: false,
      expands: true,
      builder: (context) {
        return Container(
          alignment: Alignment.center,
          padding: EdgeInsets.all(48),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  'Drawer ${count + 1} at ${positions[count % positions.length].name}'),
              gap(16),
              PrimaryButton(
                onPressed: () {
                  open(context, count + 1);
                },
                child: Text('Open Another Drawer'),
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
      child: Text('Open Drawer'),
    );
  }
}
