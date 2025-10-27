---
title: "Example: components/drawer/drawer_example_1.dart"
description: "Component example"
---

Source preview
```dart
import 'package:shadcn_flutter/shadcn_flutter.dart';

/// Drawer overlay opened from different screen edges.
///
/// Repeatedly opens nested drawers cycling through positions to showcase
/// [openDrawer] and how to close using [closeOverlay].
class DrawerExample1 extends StatefulWidget {
  const DrawerExample1({super.key});

  @override
  State<DrawerExample1> createState() => _DrawerExample1State();
}

class _DrawerExample1State extends State<DrawerExample1> {
  // Sequence of positions to cycle through as drawers are stacked.
  List<OverlayPosition> positions = [
    OverlayPosition.end,
    OverlayPosition.end,
    OverlayPosition.bottom,
    OverlayPosition.bottom,
    OverlayPosition.top,
    OverlayPosition.top,
    OverlayPosition.start,
    OverlayPosition.start,
  ];
  // Open a drawer and optionally open another from within it.
  void open(BuildContext context, int count) {
    openDrawer(
      context: context,
      expands: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(48),
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                    'Drawer ${count + 1} at ${positions[count % positions.length].name}'),
                const Gap(16),
                PrimaryButton(
                  onPressed: () {
                    // Open another drawer on top.
                    open(context, count + 1);
                  },
                  child: const Text('Open Another Drawer'),
                ),
                const Gap(8),
                SecondaryButton(
                  onPressed: () {
                    // Close the current top-most overlay.
                    closeOverlay(context);
                  },
                  child: const Text('Close Drawer'),
                ),
              ],
            ),
          ),
        );
```
