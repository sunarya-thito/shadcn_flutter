import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class CardExample extends StatelessWidget {
  const CardExample({super.key});

  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'card',
      description:
          'Cards are surfaces that display content and actions on a single topic.',
      displayName: 'Card',
      children: [
        WidgetUsageExample(
          builder: (context) {
            return Card(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Create project').semiBold(),
                  const SizedBox(height: 4),
                  Text('Deploy your new project in one-click').muted().small(),
                  const SizedBox(height: 24),
                  Text('Name').semiBold().small(),
                  const SizedBox(height: 4),
                  TextField(placeholder: 'Name of your project'),
                  const SizedBox(height: 16),
                  Text('Description').semiBold().small(),
                  const SizedBox(height: 4),
                  TextField(placeholder: 'Description of your project'),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      OutlineButton(
                        child: Text('Cancel'),
                        onPressed: () {},
                      ),
                      Spacer(),
                      PrimaryButton(
                        child: Text('Deploy'),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ).intrinsic();
          },
          code: '''
Card(
  padding: EdgeInsets.all(24),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Create project').semiBold(),
      const SizedBox(height: 4),
      Text('Deploy your new project in one-click').muted().small(),
      const SizedBox(height: 24),
      Text('Name').semiBold().small(),
      const SizedBox(height: 4),
      TextField(placeholder: 'Name of your project'),
      const SizedBox(height: 16),
      Text('Description').semiBold().small(),
      const SizedBox(height: 4),
      TextField(placeholder: 'Description of your project'),
      const SizedBox(height: 24),
      Row(
        children: [
          Button(
            child: Text('Cancel'),
            onPressed: () {},
            type: ButtonType.outline,
          ),
          Spacer(),
          Button(
            child: Text('Deploy'),
            onPressed: () {},
          ),
        ],
      ),
    ],
  ),
).intrinsic()''',
        ),
      ],
    );
  }
}
