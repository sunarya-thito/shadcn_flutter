import 'package:example/main.dart';
import 'package:example/pages/docs_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:flutter/widgets.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class TypographyPage extends StatefulWidget {
  const TypographyPage({Key? key}) : super(key: key);

  @override
  State<TypographyPage> createState() => _TypographyPageState();
}

class _TypographyPageState extends State<TypographyPage> {
  GlobalKey headline1Key = GlobalKey();
  GlobalKey headline2Key = GlobalKey();
  GlobalKey headline3Key = GlobalKey();
  GlobalKey headline4Key = GlobalKey();
  GlobalKey paragraphKey = GlobalKey();
  GlobalKey blockquoteKey = GlobalKey();
  GlobalKey listKey = GlobalKey();
  GlobalKey inlineCodeKey = GlobalKey();
  GlobalKey leadKey = GlobalKey();
  GlobalKey largeTextKey = GlobalKey();
  GlobalKey smallTextKey = GlobalKey();
  GlobalKey mutedTextKey = GlobalKey();
  GlobalKey sansKey = GlobalKey();
  GlobalKey monoKey = GlobalKey();
  GlobalKey xSmallKey = GlobalKey();
  GlobalKey smallKey = GlobalKey();
  GlobalKey baseKey = GlobalKey();
  GlobalKey largeKey = GlobalKey();
  GlobalKey xLargeKey = GlobalKey();
  GlobalKey x2LargeKey = GlobalKey();
  GlobalKey x3LargeKey = GlobalKey();
  GlobalKey x4LargeKey = GlobalKey();
  GlobalKey x5LargeKey = GlobalKey();
  GlobalKey x6LargeKey = GlobalKey();
  GlobalKey x7LargeKey = GlobalKey();
  GlobalKey x8LargeKey = GlobalKey();
  GlobalKey x9LargeKey = GlobalKey();
  GlobalKey thinKey = GlobalKey();
  GlobalKey extraLightKey = GlobalKey();
  GlobalKey lightKey = GlobalKey();
  GlobalKey normalKey = GlobalKey();
  GlobalKey mediumKey = GlobalKey();
  GlobalKey semiBoldKey = GlobalKey();
  GlobalKey boldKey = GlobalKey();
  GlobalKey extraBoldKey = GlobalKey();
  GlobalKey blackKey = GlobalKey();
  GlobalKey italicKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'typography',
      onThisPage: {
        'Headline 1': headline1Key,
        'Headline 2': headline2Key,
        'Headline 3': headline3Key,
        'Headline 4': headline4Key,
        'Paragraph': paragraphKey,
        'Blockquote': blockquoteKey,
        'List': listKey,
        'Inline code': inlineCodeKey,
        'Lead': leadKey,
        'Large text': largeTextKey,
        'Small text': smallTextKey,
        'Muted text': mutedTextKey,
        'Sans': sansKey,
        'Mono': monoKey,
        'Extra small': xSmallKey,
        'Small': smallKey,
        'Base': baseKey,
        'Large': largeKey,
        'Extra large': xLargeKey,
        'Extra 2x large': x2LargeKey,
        'Extra 3x large': x3LargeKey,
        'Extra 4x large': x4LargeKey,
        'Extra 5x large': x5LargeKey,
        'Extra 6x large': x6LargeKey,
        'Extra 7x large': x7LargeKey,
        'Extra 8x large': x8LargeKey,
        'Extra 9x large': x9LargeKey,
        'Thin': thinKey,
        'Extra light': extraLightKey,
        'Light': lightKey,
        'Normal': normalKey,
        'Medium': mediumKey,
        'Semi bold': semiBoldKey,
        'Bold': boldKey,
        'Extra bold': extraBoldKey,
        'Black': blackKey,
        'Italic': italicKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Typography').h1(),
          Text('Use typography to present your design and content as clearly and efficiently as possible.')
              .lead(),
          Text('Headline 1').h2().keyed(headline1Key),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Headline 1').h1();
                  },
                  code: 'Text(\'Headline 1\').h1();')
              .p(),
          Text('Headline 2').h2().keyed(headline2Key),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Headline 2').h2();
                  },
                  code: 'Text(\'Headline 2\').h2();')
              .p(),
          Text('Headline 3').h2().keyed(headline3Key),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Headline 3').h3();
                  },
                  code: 'Text(\'Headline 3\').h3();')
              .p(),
          Text('Headline 4').h2().keyed(headline4Key),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Headline 4').h4();
                  },
                  code: 'Text(\'Headline 4\').h4();')
              .p(),
          Text('Paragraph').h2().keyed(paragraphKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Paragraph').p();
                  },
                  code: 'Text(\'Paragraph\').p();')
              .p(),
          Text('Blockquote').h2().keyed(blockquoteKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Blockquote').blockQuote();
                  },
                  code: 'Text(\'Blockquote\').blockQuote();')
              .p(),
          Text('List').h2().keyed(listKey),
          WidgetUsageExample(
                  builder: (context) {
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
                  },
                  code: '''
      Column(
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
                  ''')
              .p(),
          Text('Inline code').h2().keyed(inlineCodeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('flutter pub add shadcn_flutter').inlineCode();
                  },
                  code: 'Text(\'Inline code\').inlineCode();')
              .p(),
          Text('Lead').h2().keyed(leadKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lead').lead();
                  },
                  code: 'Text(\'Lead\').lead();')
              .p(),
          Text('Large text').h2().keyed(largeTextKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Large text').textLarge();
                  },
                  code: 'Text(\'Large text\').textLarge();')
              .p(),
          Text('Small text').h2().keyed(smallTextKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Small text').textSmall();
                  },
                  code: 'Text(\'Small text\').textSmall();')
              .p(),
          Text('Muted text').h2().keyed(mutedTextKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Muted text').muted();
                  },
                  code: 'Text(\'Muted text\').muted();')
              .p(),
          Text('Sans').h2().keyed(sansKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').sans();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').sans();')
              .p(),
          Text('Mono').h2().keyed(monoKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').mono();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').mono();')
              .p(),
          Text('Extra small').h2().keyed(xSmallKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').xSmall();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').xSmall();')
              .p(),
          Text('Small').h2().keyed(smallKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').small();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').small();')
              .p(),
          Text('Base').h2().keyed(baseKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').base();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').base();')
              .p(),
          Text('Large').h2().keyed(largeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').large();')
              .p(),
          Text('Extra large').h2().keyed(xLargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').xLarge();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').xLarge();')
              .p(),
          Text('Extra 2x large').h2().keyed(x2LargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').x2Large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').x2Large();')
              .p(),
          Text('Extra 3x large').h2().keyed(x3LargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').x3Large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').x3Large();')
              .p(),
          Text('Extra 4x large').h2().keyed(x4LargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').x4Large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').x4Large();')
              .p(),
          Text('Extra 5x large').h2().keyed(x5LargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').x5Large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').x5Large();')
              .p(),
          Text('Extra 6x large').h2().keyed(x6LargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').x6Large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').x6Large();')
              .p(),
          Text('Extra 7x large').h2().keyed(x7LargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').x7Large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').x7Large();')
              .p(),
          Text('Extra 8x large').h2().keyed(x8LargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').x8Large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').x8Large();')
              .p(),
          Text('Extra 9x large').h2().keyed(x9LargeKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').x9Large();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').x9Large();')
              .p(),
          Text('Thin').h2().keyed(thinKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').thin();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').thin();')
              .p(),
          Text('Extra light').h2().keyed(extraLightKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').extraLight();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').extraLight();')
              .p(),
          Text('Light').h2().keyed(lightKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').light();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').light();')
              .p(),
          Text('Normal').h2().keyed(normalKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').normal();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').normal();')
              .p(),
          Text('Medium').h2().keyed(mediumKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').medium();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').medium();')
              .p(),
          Text('Semi bold').h2().keyed(semiBoldKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').semiBold();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').semiBold();')
              .p(),
          Text('Bold').h2().keyed(boldKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').bold();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').bold();')
              .p(),
          Text('Extra bold').h2().keyed(extraBoldKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').extraBold();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').extraBold();')
              .p(),
          Text('Black').h2().keyed(blackKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').black();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').black();')
              .p(),
          Text('Italic').h2().keyed(italicKey),
          WidgetUsageExample(
                  builder: (context) {
                    return Text('Lorem ipsum dolor sit amet').italic();
                  },
                  code: 'Text(\'Lorem ipsum dolor sit amet\').italic();')
              .p(),
        ],
      ),
    );
  }
}
