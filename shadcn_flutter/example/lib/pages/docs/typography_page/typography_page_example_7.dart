import 'package:shadcn_flutter/shadcn_flutter.dart';

class TypographyPageExample7 extends StatelessWidget {
  const TypographyPageExample7({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('List item 1').li(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nested list:'),
            const Text('Nested list item 1').li(),
            const Text('Nested list item 2').li(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Nested list:'),
                const Text('Nested list item 1').li(),
                const Text('Nested list item 2').li(),
              ],
            ).li(),
          ],
        ).li(),
        const Text('List item 3').li(),
      ],
    );
  }
}
