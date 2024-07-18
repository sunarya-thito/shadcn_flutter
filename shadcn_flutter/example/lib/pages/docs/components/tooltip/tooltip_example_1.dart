import 'package:shadcn_flutter/shadcn_flutter.dart';

class TooltipExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      child: PrimaryButton(
        onPressed: () {},
        child: Text('Hover over me'),
      ),
      tooltip: TooltipContainer(
        child: Text('This is a tooltip.'),
      ),
    );
  }
}
