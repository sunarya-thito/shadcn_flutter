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
  final keyRecommended = OnThisPage();
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
        'Recommended Packages': keyRecommended,
        'Passing Data to Children': keyPassingDataToChildren,
        'Getting Data from a Child': keyGettingDataFromTheChild,
        'MultiData Widget': keyMultiDataWidget,
        'Passing State as a Controller': keyPassingStateAsAController,
        'DataBuilder': keyDataBuilder,
        'DataNotifier': keyDataNotifier,
        'Passing Variables to Children': keyModel,
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
                  'In Flutter, everything is a widget — including where your data lives.')
              .p(),
          const SelectableText(
                  'shadcn_flutter includes its own state management system. If you\'re already using another '
                  'state management approach, you can keep using it — shadcn_flutter works alongside it.')
              .p(),
          const SelectableText('Recommended State Management Packages')
              .h2()
              .anchored(keyRecommended),
          const SelectableText(
                  'shadcn_flutter is state‑management agnostic. These community‑vetted packages work well with '
                  'its builder/listenable patterns — pick what fits your app and team:')
              .p(),
          const SelectableText(
                  'Riverpod (flutter_riverpod): Declarative, provider‑scoped, no BuildContext lookups; great testability.')
              .li(),
          const SelectableText(
                  'Provider: Lightweight, InheritedWidget‑based; solid for simple to medium apps.')
              .li(),
          const SelectableText(
                  'BLoC/Cubit (flutter_bloc): Event‑driven and predictable; good for larger teams and layered architectures.')
              .li(),
          const SelectableText(
                  'ValueNotifier/ChangeNotifier: Built‑in and simple for local/UI state; pairs nicely with Data/Model widgets.')
              .li(),
          const SelectableText(
                  'GetIt: Service locator/DI to compose your app; combine with any of the above for state + DI.')
              .li(),
          const SelectableText(
                  'MobX: Reactive observables/actions; ergonomic for highly reactive UIs.')
              .li(),
          const SelectableText('Passing Data to Children')
              .h2()
              .anchored(keyPassingDataToChildren),
          const SelectableText(
                  'Use the Data widget to pass data to children. When the data changes, the listening child rebuilds.')
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
          const SelectableText('Setting a Data Boundary').h3().p(),
          const SelectableText(
                  'You can set a boundary so that children cannot access the data.')
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
                  ' listen to the data and rebuild the widget when the data changes. Meanwhile ')
              .thenInlineCode('Data.maybeFind(context)')
              .thenText(' and ')
              .thenInlineCode('Data.find(context)')
              .thenText(
                  ' do not listen to the data and only return the current value.')
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
                  ' are great to use inside onPressed, onLongPressed, etc., where the method is called once. ')
              .p(),
          const SelectableText('')
              .thenInlineCode('Data.of(context)')
              .thenText(' and ')
              .thenInlineCode('Data.maybeOf(context)')
              .thenText(
                  ' are great to use inside the build method where the widget needs to rebuild when the data changes.')
              .p(),
          const SelectableText('Getting Data from a Child')
              .h2()
              .anchored(keyGettingDataFromTheChild),
          const SelectableText('Get data from a child using ')
              .thenInlineCode('Data.maybeFindMessenger(context)')
              .thenText(
                  '. This does not listen to subsequent changes in the data. ')
              .p(),
          const SelectableText(
                  'Listening to child data can cause infinite rebuild loops. '
                  'Move the data up to the parent widget if you need to listen to it.')
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
                'It uses the data from the leftmost inner data, because the parent can only take data from the first attached child.'),
          ).p(),
          const SelectableText('Setting a DataMessenger Boundary').h3().p(),
          const SelectableText(
                  'You can set a boundary so that a specific parent cannot obtain child data.')
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
                  'The MultiData widget lets you pass multiple pieces of data to children. For example:')
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
                  'Use the MultiData widget to avoid deep nesting.')
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
                  'You can pass state as a controller to children. This lets child widgets call methods on the parent widget.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_7.dart',
            summarize: false,
            child: DataExample7(),
          ).p(),
          const SelectableText('DataBuilder').h2().anchored(keyDataBuilder),
          const SelectableText(
                  'Use DataBuilder to rebuild only when the data changes, avoiding unnecessary rebuilds of the entire widget tree.')
              .p(),
          // example 8
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_8.dart',
            summarize: false,
            child: DataExample8(),
          ).p(),
          const SelectableText('DataNotifier').h2().anchored(keyDataNotifier),
          const SelectableText(
                  'DataNotifier allows you to pass values to children from a ValueListenable.')
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
          const SelectableText('Passing Objects as Data').h3().p(),
          const SelectableText(
                  'Consider the following when passing objects as data:')
              .p(),
          const SelectableText('1. Override operator == and hashCode').h4().p(),
          const SelectableText(
                  'Children are notified when the new object is not equal to the old one. '
                  'If you don\'t override operator == and hashCode, newly instantiated objects are always considered '
                  'different even when their field values are the same.')
              .p(),
          const CodeBlockFutureBuilder(
            path: 'lib/pages/docs/state/data_example_16.dart',
            summarize: false,
          ).p(),
          const SelectableText('2. Use DistinctData').h4().p(),
          const SelectableText(
                  'DistinctData is a mixin that lets you notify children when specific fields change.')
              .p(),
          const CodeBlockFutureBuilder(
            path: 'lib/pages/docs/state/data_example_17.dart',
            summarize: false,
          ).p(),
          const SelectableText('3. Passing Mutable Objects to Children')
              .h4()
              .p(),
          const SelectableText(
                  'We recommend passing immutable objects to children. Mutable objects (e.g., List, Map, Set, or a '
                  'widget\'s State) won\'t notify children when mutated because the object reference does not change.')
              .p(),
          const SelectableText('Passing Variables to Children')
              .h2()
              .anchored(keyModel),
          const SelectableText(
                  'To pass a variable to children, use the Model widget. It\'s similar to Data, but it\'s type‑safe and labeled.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_11.dart',
            summarize: false,
            child: DataExample11(),
          ).p(),

          const SelectableText('Changing Variables from Children').h3().p(),
          const SelectableText(
                  'There are two ways to change a model\'s value from children:')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_12.dart',
            summarize: false,
            child: DataExample12(),
          ).p(),
          const SelectableText('ModelNotifier').h2().anchored(keyModelNotifier),
          const SelectableText(
                  'ModelNotifier lets you pass values to children from a ValueNotifier, avoiding setState in the parent widget.')
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
                  'ModelListenable is a read‑only version of ModelNotifier. Children can only listen to the value; attempting to change it throws an error.')
              .p(),
          const WidgetUsageExample(
            path: 'lib/pages/docs/state/data_example_14.dart',
            summarize: false,
            child: DataExample14(),
          ).p(),
          const SelectableText('ModelBuilder').h2().anchored(keyModelBuilder),
          const SelectableText(
                  'ModelBuilder listens and rebuilds when the value changes. It\'s similar to DataBuilder, but type‑safe and labeled.')
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
