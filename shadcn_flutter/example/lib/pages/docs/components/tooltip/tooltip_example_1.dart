import 'package:shadcn_flutter/shadcn_flutter.dart';

class TooltipExample1 extends StatelessWidget {
  const TooltipExample1({super.key});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
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
