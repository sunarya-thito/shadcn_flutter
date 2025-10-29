import 'package:docs/code_highlighter.dart';
import 'package:docs/pages/docs/state/data_example_1.dart';
import 'package:docs/pages/docs/state/data_example_10.dart';
import 'package:docs/pages/docs/state/data_example_11.dart';
import 'package:docs/pages/docs/state/data_example_12.dart';
import 'package:docs/pages/docs/state/data_example_13.dart';
import 'package:docs/pages/docs/state/data_example_14.dart';
import 'package:docs/pages/docs/state/data_example_15.dart';
import 'package:docs/pages/docs/state/data_example_2.dart';
import 'package:docs/pages/docs/state/data_example_3.dart';
import 'package:docs/pages/docs/state/data_example_4.dart';
import 'package:docs/pages/docs/state/data_example_5.dart';
import 'package:docs/pages/docs/state/data_example_6.dart';
import 'package:docs/pages/docs/state/data_example_7.dart';
import 'package:docs/pages/docs/state/data_example_8.dart';
import 'package:docs/pages/docs/state/data_example_9.dart';
import 'package:docs/pages/docs_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class StateManagementPage extends StatefulWidget {
  const StateManagementPage({super.key});
  @override
  State<StateManagementPage> createState() => _StateManagementPageState();
}

class _StateManagementPageState extends State<StateManagementPage> {
  final keyPassingDataToChildren = OnThisPage();
  final keyGettingDataFromTheChild = OnThisPage();
  final keyMultiDataWidget = OnThisPage();
  final keyPassingStateAsAController = OnThisPage();
  final keyDataBuilder = OnThisPage();
  final keyDataNotifier = OnThisPage();
  final keyModel = OnThisPage();
  final keyModelNotifier = OnThisPage();
  final keyModelListenable = OnThisPage();
  final keyModelBuilder = OnThisPage();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'state',
      onThisPage: {
        'Passing Data to the Children': keyPassingDataToChildren,
        'Getting Data from the Child': keyGettingDataFromTheChild,
        'MultiData Widget': keyMultiDataWidget,
        'Passing State as a Controller': keyPassingStateAsAController,
        'DataBuilder': keyDataBuilder,
        'DataNotifier': keyDataNotifier,
        'Passing Variable to Children': keyModel,
        'ModelNotifier': keyModelNotifier,
        'ModelListenable': keyModelListenable,
        'ModelBuilder': keyModelBuilder,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SelectableText('State Management').h1(),
          const SelectableText(
                  'A comprehensive guide to managing state in shadcn_flutter.')
              .lead(),
          const SelectableText(
                  'In Flutter, everything is a widget, including where your data is stored.')
              .p(),
          const SelectableText(
                  'Internally, shadcn_flutter has its own state management system. '
                  'Although if you are already using a state management system, '
                  'you can continue to use it with shadcn_flutter.')
              .p(),
          const SelectableText('Passing Data to the Children')
              .h2()
              .anchored(keyPassingDataToChildren),
          const SelectableText(
                  'You can pass data to children using the Data widget. '
                  'Any changes that occur in the data will cause the child to rebuild.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_1.dart',
            summarize: false,
            child: DataExample1(),
          ).p(),
          const Alert(
            leading: Icon(Icons.info_outline),
            title: SelectableText(
                'Did you notice the difference in the rebuild count?'),
            content: SelectableText(
                'The MostInnerWidget rebuilds when the data changes while the InnerWidget does not. '
                'This is because the InnerWidget is not listening to the data.'),
          ).p(),
          const SelectableText('Setting Data Boundary').h3().p(),
          const SelectableText(
                  'You can set a boundary so that the child cannot access the data.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_4.dart',
            summarize: false,
            child: DataExample4(),
          ).p(),
          const SelectableText(
                  'Data.maybeOf/Data.of vs Data.maybeFind/Data.find')
              .h3()
              .p(),
          const SelectableText('')
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
            path: 'lib/pages/docs/state/data_example_5.dart',
            summarize: false,
            child: DataExample5(),
          ).p(),
          // Data.find and Data.maybeFind are great to use inside onPressed, onLongPressed, etc where the method is called once
          // whereas Data.of and Data.maybeOf are great to use inside build method where the widget needs to rebuild when the data changes
          const SelectableText('')
              .thenInlineCode('Data.find(context)')
              .thenText(' and ')
              .thenInlineCode('Data.maybeFind(context)')
              .thenText(
                  ' are great to use inside onPressed, onLongPressed, etc where the method is called once. ')
              .p(),
          const SelectableText('')
              .thenInlineCode('Data.of(context)')
              .thenText(' and ')
              .thenInlineCode('Data.maybeOf(context)')
              .thenText(
                  ' are great to use inside build method where the widget needs to rebuild when the data changes.')
              .p(),
          const SelectableText('Getting Data from the Child')
              .h2()
              .anchored(keyGettingDataFromTheChild),
          const SelectableText('You can get data from the child using the ')
              .thenInlineCode('Data.maybeFindMessenger(context)')
              .thenText(
                  ' method. This method does not listen to any changes that occur in the data. ')
              .p(),
          const SelectableText(
                  'Listening to child data might cause infinite rebuild loops. '
                  'Move the data to the parent widget if you need to listen to it.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_2.dart',
            summarize: false,
            child: DataExample2(),
          ).p(),
          const Alert(
            leading: Icon(Icons.info_outline),
            title: SelectableText('Did you notice the root data?'),
            content: SelectableText(
                'It uses the data from the left most inner data, because parent can only take data from the first attached child.'),
          ).p(),
          const SelectableText('Setting DataMessenger Boundary').h3().p(),
          const SelectableText(
                  'You can set a boundary so that child data cannot be obtained from specific parent.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_3.dart',
            summarize: false,
            child: DataExample3(),
          ).p(),
          const SelectableText('MultiData Widget')
              .h2()
              .anchored(keyMultiDataWidget),
          const SelectableText(
                  'The MultiData widget allows you to pass multiple data to the children. Take a look at the following example:')
              .p(),
          const CodeBlock(
            code: 'Data<int>.inherit(\n'
                '\tdata: counter,\n'
                '\tchild: Data<String>.inherit(\n'
                '\t\tdata: name,\n'
                '\t\tchild: Data<bool>.boundary(\n'
                '\t\t\tchild: child,\n'
                '\t\t),\n'
                '\t),\n'
                ')',
            mode: 'dart',
          ).p(),
          const SelectableText(
                  'You can avoid nesting by using the MultiData widget.')
              .p(),
          const CodeBlock(
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
          const SelectableText('Example').h3().p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_6.dart',
            summarize: false,
            child: DataExample6(),
          ).p(),
          const SelectableText('Passing State as a Controller')
              .h2()
              .anchored(keyPassingStateAsAController),
          const SelectableText(
                  'You can pass state as a controller to the children. This way you can call method in parent widget from child widgets.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_7.dart',
            summarize: false,
            child: DataExample7(),
          ).p(),
          const SelectableText('DataBuilder').h2().anchored(keyDataBuilder),
          const SelectableText(
                  'You can use the DataBuilder widget to rebuild the widget when the data changes. '
                  'This also avoids rebuilding the entire widget.')
              .p(),
          // example 8
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_8.dart',
            summarize: false,
            child: DataExample8(),
          ).p(),
          const SelectableText('DataNotifier').h2().anchored(keyDataNotifier),
          const SelectableText(
                  'Data notifier allows you to pass value to children from a ValueListenable.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_9.dart',
            summarize: false,
            child: DataExample9(),
          ).p(),
          const SelectableText('Example with MultiData').h3().p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_10.dart',
            summarize: false,
            child: DataExample10(),
          ).p(),
          const SelectableText('Passing Object as Data').h3().p(),
          const SelectableText(
                  'There are several things you need to consider when passing an object as data:')
              .p(),
          const SelectableText('1. Override == and hashCode').h4().p(),
          const SelectableText(
                  'Children will be notified when the old object is not equal to the new object. '
                  'If you do not override == and hashCode, the object will always be considered '
                  'different every time the object is instantiated even if the object has the same '
                  'field values.')
              .p(),
          const CodeBlockFutureBuilder(
            path: 'lib/pages/docs/state/data_example_16.dart',
            summarize: false,
          ).p(),
          const SelectableText('2. Use DistinctData').h4().p(),
          const SelectableText(
                  'DistinctData is a mixin that allows you to notify children when specific fields change.')
              .p(),
          const CodeBlockFutureBuilder(
            path: 'lib/pages/docs/state/data_example_17.dart',
            summarize: false,
          ).p(),
          const SelectableText('3. Passing Mutable Object to Children')
              .h4()
              .p(),
          const SelectableText(
                  'It is recommended to pass an immutable object to the children. Mutable '
                  'object (e.g. List, Map, Set, Widget State) will not notify the children when the object is mutated '
                  'because the object reference does not change. ')
              .p(),
          const SelectableText('Passing Variable to Children')
              .h2()
              .anchored(keyModel),
          const SelectableText(
                  'To pass a variable to children, you can use the Model widget. It is similar to Data widget, but it is type-strict and also labeled.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_11.dart',
            summarize: false,
            child: DataExample11(),
          ).p(),

          const SelectableText('Change Variable from Children').h3().p(),
          const SelectableText(
                  'There are 2 ways to change model value from children:')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_12.dart',
            summarize: false,
            child: DataExample12(),
          ).p(),
          const SelectableText('ModelNotifier').h2().anchored(keyModelNotifier),
          const SelectableText(
                  'ModelNotifier allows you to pass value to children from a ValueNotifier. It prevents the need to use setState on the parent widget.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_13.dart',
            summarize: false,
            child: DataExample13(),
          ).p(),
          const SelectableText('ModelListenable')
              .h2()
              .anchored(keyModelListenable),
          const SelectableText(
                  'ModelListenable is a read-only ModelNotifier. Children can only listen to the value. Attempting to change the value will throw an error.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_14.dart',
            summarize: false,
            child: DataExample14(),
          ).p(),
          const SelectableText('ModelBuilder').h2().anchored(keyModelBuilder),
          const SelectableText(
                  'ModelBuilder listens and rebuilds the widget when the value changes. It is similar to DataBuilder, but it is type-strict and also labeled.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_15.dart',
            summarize: false,
            child: DataExample15(),
          ).p(),
        ],
      ),
    );
  }
}
