import 'package:shadcn_flutter/shadcn_flutter.dart';

class TypographyPageExample7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('List item 1').li(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nested list:'),
                            Text('Nested list item 1').li(),
                            Text('Nested list item 2').li(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Nested list:'),
                                Text('Nested list item 1').li(),
                                Text('Nested list item 2').li(),
                              ],
                            ).li(),
                          ],
                        ).li(),
                        Text('List item 3').li(),
                      ],
                    );
  }
}
