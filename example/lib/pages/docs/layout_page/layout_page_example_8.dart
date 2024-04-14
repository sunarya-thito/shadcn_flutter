import 'package:shadcn_flutter/shadcn_flutter.dart';

class LayoutPageExample9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Basic(
                  title: Text('Title'),
                  leading: Icon(Icons.star),
                  trailing: Icon(Icons.arrow_forward),
                  subtitle: Text('Subtitle'),
                  content: Text('Lorem ipsum dolor sit amet'),
                );
  }
}
