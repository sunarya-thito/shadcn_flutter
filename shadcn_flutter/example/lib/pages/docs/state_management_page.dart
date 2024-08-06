import 'package:example/pages/docs/state/data_example_1.dart';
import 'package:example/pages/docs/state/data_example_2.dart';
import 'package:example/pages/docs/state/data_example_3.dart';
import 'package:example/pages/docs/state/data_example_4.dart';
import 'package:example/pages/docs/state/data_example_5.dart';
import 'package:example/pages/docs/state/data_example_6.dart';
import 'package:example/pages/docs/state/data_example_7.dart';
import 'package:example/pages/docs_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StateManagementPage extends StatefulWidget {
  const StateManagementPage({Key? key}) : super(key: key);
  @override
  State<StateManagementPage> createState() => _StateManagementPageState();
}

class _StateManagementPageState extends State<StateManagementPage> {
  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'state',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('State Management').h1(),
          const Text(
                  'A comprehensive guide to managing state in shadcn_flutter.')
              .lead(),
          const Text(
                  'In Flutter, everything is a widget, including where your data is stored. '
                  'This means that you can use widgets to manage your application state.')
              .p(),
          const Text(
                  'Internally, shadcn_flutter has its own state management system. '
                  'This system is based on the concept of "Data". '
                  'Although if you are already using a state management system, '
                  'you can continue to use it with shadcn_flutter.')
              .p(),
          const Text('Passing Data to the Children').h2(),
          const Text('You can pass data to children using the Data widget. '
                  'Any changes that occur in the data will cause the child to rebuild. '
                  'This is similar to the Provider package in Flutter.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_1.dart',
            child: DataExample1(),
          ).p(),
          const Alert(
            leading: Icon(Icons.info_outline),
            title: Text('Did you notice the difference in the rebuild count?'),
            content: Text(
                'The MostInnerWidget rebuilds when the data changes while the InnerWidget does not. '
                'This is because the InnerWidget is not listening to the data.'),
          ).p(),
          const Text('Setting Data Boundary').h3().p(),
          const Text(
                  'You can set a boundary so that the child cannot access the data.')
              .p(),
          const WidgetUsageExample(
            child: DataExample4(),
            path: 'lib/pages/docs/state/data_example_4.dart',
          ).p(),
          const Text('Data.maybeOf/Data.of vs Data.maybeFind/Data.find')
              .h3()
              .p(),
          const Text('')
              .thenInlineCode('Data.maybeOf(context)')
              .thenText(' and ')
              .thenInlineCode('Data.of(context)')
              .thenText(
                  ' listens to the data and rebuilds the widget when the data changes. Meanwhile ')
              .thenInlineCode('Data.maybeFind(context)')
              .thenText(' and ')
              .thenInlineCode('Data.find(context)')
              .thenText(
                  ' does not listen to the data and only returns the data.')
              .p(),
          const WidgetUsageExample(
            child: DataExample5(),
            path: 'lib/pages/docs/state/data_example_5.dart',
          ).p(),
          const Text('Getting Data from the Child').h2(),
          const Text('You can get data from the child using the ')
              .thenInlineCode('Data.maybeFindMessenger(context)')
              .thenText(
                  ' method. This method does not listen to any changes that occur in the data. ')
              .p(),
          const Text(
                  'Listening to child data might cause infinite rebuild loops. '
                  'Move the data to the parent widget if you need to listen to it.')
              .p(),
          const WidgetUsageExample(
            child: DataExample2(),
            path: 'lib/pages/docs/state/data_example_2.dart',
          ).p(),
          const Alert(
            leading: Icon(Icons.info_outline),
            title: Text('Did you notice the root data?'),
            content: Text(
                'It uses the data from the left most inner data, because parent can only take data from the first attached child.'),
          ).p(),
          const Text('Setting DataMessenger Boundary').h3().p(),
          const Text(
                  'You can set a boundary so that child data cannot be obtained from specific parent.')
              .p(),
          const WidgetUsageExample(
            child: DataExample3(),
            path: 'lib/pages/docs/state/data_example_3.dart',
          ).p(),
          const Text('MultiData Widget').h2(),
          const Text(
                  'The MultiData widget allows you to pass multiple data to the children. Take a look at the following example:')
              .p(),
          const CodeSnippet(
            code: 'Data<int>(\n'
                '\tdata: counter,\n'
                '\tchild: Data<String>(\n'
                '\t\tdata: name,\n'
                '\t\tchild: Data<bool>.boundary(\n'
                '\t\t\tchild: child,\n'
                '\t\t),\n'
                '\t),\n'
                ')',
            mode: 'dart',
          ).p(),
          const Text('You can avoid nesting by using the MultiData widget.')
              .p(),
          const CodeSnippet(
            code: 'MultiData(\n'
                '\tdataList: [\n'
                '\t\tData<int>(counter),\n'
                '\t\tData<String>(name),\n'
                '\t\tData<bool>.boundary(),\n'
                '\t],\n'
                '\tchild: child,\n'
                ')',
            mode: 'dart',
          ).p(),
          const Text('Example').h3().p(),
          const WidgetUsageExample(
            child: DataExample6(),
            path: 'lib/pages/docs/state/data_example_6.dart',
          ).p(),
          const Text('Passing State as a Controller').h2(),
          const Text('You can pass state as a controller to the children.').p(),
          const WidgetUsageExample(
            child: DataExample7(),
            path: 'lib/pages/docs/state/data_example_7.dart',
          ).p(),
        ],
      ),
    );
  }
}
