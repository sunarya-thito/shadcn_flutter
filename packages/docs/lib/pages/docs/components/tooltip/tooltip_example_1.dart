import 'package:shadcn_flutter/shadcn_flutter.dart';

// Demonstrates a Tooltip wrapping a button; shows tooltip content on
// hover/focus.

class TooltipExample1 extends StatelessWidget {
  const TooltipExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      // Tooltip wraps a target widget and shows TooltipContainer on hover/focus.
      tooltip: const TooltipContainer(
        child: Text('This is a tooltip.'),
      ),
      child: PrimaryButton(
        onPressed: () {},
        child: const Text('Hover over me'),
      ),
    );
  }
}
