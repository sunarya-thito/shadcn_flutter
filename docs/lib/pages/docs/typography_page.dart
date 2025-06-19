import 'package:docs/pages/docs_page.dart';
import 'package:docs/pages/widget_usage_example.dart';
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
  const TypographyPage({super.key});

  @override
  State<TypographyPage> createState() => _TypographyPageState();
}

class _TypographyPageState extends State<TypographyPage> {
  OnThisPage headline1Key = OnThisPage();
  OnThisPage headline2Key = OnThisPage();
  OnThisPage headline3Key = OnThisPage();
  OnThisPage headline4Key = OnThisPage();
  OnThisPage paragraphKey = OnThisPage();
  OnThisPage blockquoteKey = OnThisPage();
  OnThisPage listKey = OnThisPage();
  OnThisPage inlineCodeKey = OnThisPage();
  OnThisPage leadKey = OnThisPage();
  OnThisPage largeTextKey = OnThisPage();
  OnThisPage smallTextKey = OnThisPage();
  OnThisPage mutedTextKey = OnThisPage();
  OnThisPage sansKey = OnThisPage();
  OnThisPage monoKey = OnThisPage();
  OnThisPage xSmallKey = OnThisPage();
  OnThisPage smallKey = OnThisPage();
  OnThisPage baseKey = OnThisPage();
  OnThisPage largeKey = OnThisPage();
  OnThisPage xLargeKey = OnThisPage();
  OnThisPage x2LargeKey = OnThisPage();
  OnThisPage x3LargeKey = OnThisPage();
  OnThisPage x4LargeKey = OnThisPage();
  OnThisPage x5LargeKey = OnThisPage();
  OnThisPage x6LargeKey = OnThisPage();
  OnThisPage x7LargeKey = OnThisPage();
  OnThisPage x8LargeKey = OnThisPage();
  OnThisPage x9LargeKey = OnThisPage();
  OnThisPage thinKey = OnThisPage();
  OnThisPage extraLightKey = OnThisPage();
  OnThisPage lightKey = OnThisPage();
  OnThisPage normalKey = OnThisPage();
  OnThisPage mediumKey = OnThisPage();
  OnThisPage semiBoldKey = OnThisPage();
  OnThisPage boldKey = OnThisPage();
  OnThisPage extraBoldKey = OnThisPage();
  OnThisPage blackKey = OnThisPage();
  OnThisPage italicKey = OnThisPage();

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
          const Text('Typography').h1(),
          const Text(
                  'Use typography to present your design and content as clearly and efficiently as possible.')
              .lead(),
          const Text('Headline 1').h2().anchored(headline1Key),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_1.dart',
            child: TypographyPageExample1(),
          ).p(),
          const Text('Headline 2').h2().anchored(headline2Key),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_2.dart',
            child: TypographyPageExample2(),
          ).p(),
          const Text('Headline 3').h2().anchored(headline3Key),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_3.dart',
            child: TypographyPageExample3(),
          ).p(),
          const Text('Headline 4').h2().anchored(headline4Key),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_4.dart',
            child: TypographyPageExample4(),
          ).p(),
          const Text('Paragraph').h2().anchored(paragraphKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_5.dart',
            child: TypographyPageExample5(),
          ).p(),
          const Text('Blockquote').h2().anchored(blockquoteKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_6.dart',
            child: TypographyPageExample6(),
          ).p(),
          const Text('List').h2().anchored(listKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_7.dart',
            child: TypographyPageExample7(),
          ).p(),
          const Text('Inline code').h2().anchored(inlineCodeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_8.dart',
            child: TypographyPageExample8(),
          ).p(),
          const Text('Lead').h2().anchored(leadKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_9.dart',
            child: TypographyPageExample9(),
          ).p(),
          const Text('Large text').h2().anchored(largeTextKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_10.dart',
            child: TypographyPageExample10(),
          ).p(),
          const Text('Small text').h2().anchored(smallTextKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_11.dart',
            child: TypographyPageExample11(),
          ).p(),
          const Text('Muted text').h2().anchored(mutedTextKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_12.dart',
            child: TypographyPageExample12(),
          ).p(),
          const Text('Sans').h2().anchored(sansKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_13.dart',
            child: TypographyPageExample13(),
          ).p(),
          const Text('Mono').h2().anchored(monoKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_14.dart',
            child: TypographyPageExample14(),
          ).p(),
          const Text('Extra small').h2().anchored(xSmallKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_15.dart',
            child: TypographyPageExample15(),
          ).p(),
          const Text('Small').h2().anchored(smallKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_16.dart',
            child: TypographyPageExample16(),
          ).p(),
          const Text('Base').h2().anchored(baseKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_17.dart',
            child: TypographyPageExample17(),
          ).p(),
          const Text('Large').h2().anchored(largeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_18.dart',
            child: TypographyPageExample18(),
          ).p(),
          const Text('Extra large').h2().anchored(xLargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_19.dart',
            child: TypographyPageExample19(),
          ).p(),
          const Text('Extra 2x large').h2().anchored(x2LargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_20.dart',
            child: TypographyPageExample20(),
          ).p(),
          const Text('Extra 3x large').h2().anchored(x3LargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_21.dart',
            child: TypographyPageExample21(),
          ),
          const Text('Extra 4x large').h2().anchored(x4LargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_22.dart',
            child: TypographyPageExample22(),
          ).p(),
          const Text('Extra 5x large').h2().anchored(x5LargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_23.dart',
            child: TypographyPageExample23(),
          ).p(),
          const Text('Extra 6x large').h2().anchored(x6LargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_24.dart',
            child: TypographyPageExample24(),
          ).p(),
          const Text('Extra 7x large').h2().anchored(x7LargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_25.dart',
            child: TypographyPageExample25(),
          ).p(),
          const Text('Extra 8x large').h2().anchored(x8LargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_26.dart',
            child: TypographyPageExample26(),
          ).p(),
          const Text('Extra 9x large').h2().anchored(x9LargeKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_27.dart',
            child: TypographyPageExample27(),
          ).p(),
          const Text('Thin').h2().anchored(thinKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_28.dart',
            child: TypographyPageExample28(),
          ).p(),
          const Text('Extra light').h2().anchored(extraLightKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_29.dart',
            child: TypographyPageExample29(),
          ).p(),
          const Text('Light').h2().anchored(lightKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_30.dart',
            child: TypographyPageExample30(),
          ).p(),
          const Text('Normal').h2().anchored(normalKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_31.dart',
            child: TypographyPageExample31(),
          ).p(),
          const Text('Medium').h2().anchored(mediumKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_32.dart',
            child: TypographyPageExample32(),
          ).p(),
          const Text('Semi bold').h2().anchored(semiBoldKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_33.dart',
            child: TypographyPageExample33(),
          ).p(),
          const Text('Bold').h2().anchored(boldKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_34.dart',
            child: TypographyPageExample34(),
          ).p(),
          const Text('Extra bold').h2().anchored(extraBoldKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_35.dart',
            child: TypographyPageExample35(),
          ).p(),
          const Text('Black').h2().anchored(blackKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_36.dart',
            child: TypographyPageExample36(),
          ).p(),
          const Text('Italic').h2().anchored(italicKey),
          const WidgetUsageExample(
            path:
                'lib/pages/docs/typography_page/typography_page_example_37.dart',
            child: TypographyPageExample37(),
          ).p(),
        ],
      ),
    );
  }
}
