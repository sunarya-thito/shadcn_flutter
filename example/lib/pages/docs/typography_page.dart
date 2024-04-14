import 'package:example/main.dart';
import 'package:example/pages/docs_page.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'typography_page/typography_page_example_1.dart';
import 'typography_page/typography_page_example_10.dart';
import 'typography_page/typography_page_example_11.dart';
import 'typography_page/typography_page_example_12.dart';
import 'typography_page/typography_page_example_13.dart';
import 'typography_page/typography_page_example_14.dart';
import 'typography_page/typography_page_example_15.dart';
import 'typography_page/typography_page_example_16.dart';
import 'typography_page/typography_page_example_17.dart';
import 'typography_page/typography_page_example_18.dart';
import 'typography_page/typography_page_example_19.dart';
import 'typography_page/typography_page_example_2.dart';
import 'typography_page/typography_page_example_20.dart';
import 'typography_page/typography_page_example_21.dart';
import 'typography_page/typography_page_example_22.dart';
import 'typography_page/typography_page_example_23.dart';
import 'typography_page/typography_page_example_24.dart';
import 'typography_page/typography_page_example_25.dart';
import 'typography_page/typography_page_example_26.dart';
import 'typography_page/typography_page_example_27.dart';
import 'typography_page/typography_page_example_28.dart';
import 'typography_page/typography_page_example_29.dart';
import 'typography_page/typography_page_example_3.dart';
import 'typography_page/typography_page_example_30.dart';
import 'typography_page/typography_page_example_31.dart';
import 'typography_page/typography_page_example_32.dart';
import 'typography_page/typography_page_example_33.dart';
import 'typography_page/typography_page_example_34.dart';
import 'typography_page/typography_page_example_35.dart';
import 'typography_page/typography_page_example_36.dart';
import 'typography_page/typography_page_example_37.dart';
import 'typography_page/typography_page_example_4.dart';
import 'typography_page/typography_page_example_5.dart';
import 'typography_page/typography_page_example_6.dart';
import 'typography_page/typography_page_example_7.dart';
import 'typography_page/typography_page_example_8.dart';
import 'typography_page/typography_page_example_9.dart';

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
            child: TypographyPageExample1(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_1.dart',
          ).p(),
          Text('Headline 2').h2().keyed(headline2Key),
          WidgetUsageExample(
            child: TypographyPageExample2(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_2.dart',
          ).p(),
          Text('Headline 3').h2().keyed(headline3Key),
          WidgetUsageExample(
            child: TypographyPageExample3(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_3.dart',
          ).p(),
          Text('Headline 4').h2().keyed(headline4Key),
          WidgetUsageExample(
            child: TypographyPageExample4(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_4.dart',
          ).p(),
          Text('Paragraph').h2().keyed(paragraphKey),
          WidgetUsageExample(
            child: TypographyPageExample5(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_5.dart',
          ).p(),
          Text('Blockquote').h2().keyed(blockquoteKey),
          WidgetUsageExample(
            child: TypographyPageExample6(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_6.dart',
          ).p(),
          Text('List').h2().keyed(listKey),
          WidgetUsageExample(
            child: TypographyPageExample7(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_7.dart',
          ).p(),
          Text('Inline code').h2().keyed(inlineCodeKey),
          WidgetUsageExample(
            child: TypographyPageExample8(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_8.dart',
          ).p(),
          Text('Lead').h2().keyed(leadKey),
          WidgetUsageExample(
            child: TypographyPageExample9(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_9.dart',
          ).p(),
          Text('Large text').h2().keyed(largeTextKey),
          WidgetUsageExample(
            child: TypographyPageExample10(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_10.dart',
          ).p(),
          Text('Small text').h2().keyed(smallTextKey),
          WidgetUsageExample(
            child: TypographyPageExample11(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_11.dart',
          ).p(),
          Text('Muted text').h2().keyed(mutedTextKey),
          WidgetUsageExample(
            child: TypographyPageExample12(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_12.dart',
          ).p(),
          Text('Sans').h2().keyed(sansKey),
          WidgetUsageExample(
            child: TypographyPageExample13(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_13.dart',
          ).p(),
          Text('Mono').h2().keyed(monoKey),
          WidgetUsageExample(
            child: TypographyPageExample14(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_14.dart',
          ).p(),
          Text('Extra small').h2().keyed(xSmallKey),
          WidgetUsageExample(
            child: TypographyPageExample15(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_15.dart',
          ).p(),
          Text('Small').h2().keyed(smallKey),
          WidgetUsageExample(
            child: TypographyPageExample16(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_16.dart',
          ).p(),
          Text('Base').h2().keyed(baseKey),
          WidgetUsageExample(
            child: TypographyPageExample17(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_17.dart',
          ).p(),
          Text('Large').h2().keyed(largeKey),
          WidgetUsageExample(
            child: TypographyPageExample18(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_18.dart',
          ).p(),
          Text('Extra large').h2().keyed(xLargeKey),
          WidgetUsageExample(
            child: TypographyPageExample19(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_19.dart',
          ).p(),
          Text('Extra 2x large').h2().keyed(x2LargeKey),
          WidgetUsageExample(
            child: TypographyPageExample20(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_20.dart',
          ).p(),
          Text('Extra 3x large').h2().keyed(x3LargeKey),
          WidgetUsageExample(
            child: TypographyPageExample21(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_21.dart',
          ),
          Text('Extra 4x large').h2().keyed(x4LargeKey),
          WidgetUsageExample(
            child: TypographyPageExample22(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_22.dart',
          ).p(),
          Text('Extra 5x large').h2().keyed(x5LargeKey),
          WidgetUsageExample(
            child: TypographyPageExample23(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_23.dart',
          ).p(),
          Text('Extra 6x large').h2().keyed(x6LargeKey),
          WidgetUsageExample(
            child: TypographyPageExample24(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_24.dart',
          ).p(),
          Text('Extra 7x large').h2().keyed(x7LargeKey),
          WidgetUsageExample(
            child: TypographyPageExample25(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_25.dart',
          ).p(),
          Text('Extra 8x large').h2().keyed(x8LargeKey),
          WidgetUsageExample(
            child: TypographyPageExample26(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_26.dart',
          ).p(),
          Text('Extra 9x large').h2().keyed(x9LargeKey),
          WidgetUsageExample(
            child: TypographyPageExample27(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_27.dart',
          ).p(),
          Text('Thin').h2().keyed(thinKey),
          WidgetUsageExample(
            child: TypographyPageExample28(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_28.dart',
          ).p(),
          Text('Extra light').h2().keyed(extraLightKey),
          WidgetUsageExample(
            child: TypographyPageExample29(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_29.dart',
          ).p(),
          Text('Light').h2().keyed(lightKey),
          WidgetUsageExample(
            child: TypographyPageExample30(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_30.dart',
          ).p(),
          Text('Normal').h2().keyed(normalKey),
          WidgetUsageExample(
            child: TypographyPageExample31(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_31.dart',
          ).p(),
          Text('Medium').h2().keyed(mediumKey),
          WidgetUsageExample(
            child: TypographyPageExample32(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_32.dart',
          ).p(),
          Text('Semi bold').h2().keyed(semiBoldKey),
          WidgetUsageExample(
            child: TypographyPageExample33(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_33.dart',
          ).p(),
          Text('Bold').h2().keyed(boldKey),
          WidgetUsageExample(
            child: TypographyPageExample34(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_34.dart',
          ).p(),
          Text('Extra bold').h2().keyed(extraBoldKey),
          WidgetUsageExample(
            child: TypographyPageExample35(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_35.dart',
          ).p(),
          Text('Black').h2().keyed(blackKey),
          WidgetUsageExample(
            child: TypographyPageExample36(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_36.dart',
          ).p(),
          Text('Italic').h2().keyed(italicKey),
          WidgetUsageExample(
            child: TypographyPageExample37(),
            path:
                'lib/pages/docs/typography_page/typography_page_example_37.dart',
          ).p(),
        ],
      ),
    );
  }
}
