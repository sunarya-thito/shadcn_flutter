import 'package:docs/pages/docs_page.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';

class IntroductionPage extends StatefulWidget {
  const IntroductionPage({super.key});

  @override
  IntroductionPageState createState() => IntroductionPageState();
}

class IntroductionPageState extends State<IntroductionPage> {
  final OnThisPage featuresKey = OnThisPage();
  final OnThisPage faqKey = OnThisPage();
  final OnThisPage notesKey = OnThisPage();
  final OnThisPage linksKey = OnThisPage();

  @override
  Widget build(BuildContext context) {
    return DocsPage(
      name: 'introduction',
      onThisPage: {
        'Features': featuresKey,
        'Notes': notesKey,
        'Frequently Asked Questions': faqKey,
        'Links': linksKey,
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Introduction').h1(),
          const Text(
                  'A cohesive shadcn/ui ecosystem for Flutter—components, theming, and tooling—ready to ditch Material and Cupertino.')
              .lead(),
          const Text(
            'Welcome to shadcn_flutter, a cohesive UI ecosystem built on the shadcn/ui design system '
            'for Flutter applications across mobile, web, and desktop. Rather than a one‑to‑one '
            'design‑system port, this project focuses on delivering a consistent, production‑ready '
            'experience that feels at home on every platform.',
            textAlign: TextAlign.justify,
          ).p(),
          const Text(
            '\tThis ecosystem provides a wide range of customizable and responsive components, primitives, '
            'and theming aligned with modern shadcn/ui patterns. Whether you\'re building a mobile app, '
            'a sleek web dashboard, or a desktop productivity tool, our components are designed to help '
            'you ship professional, polished UIs quickly—without relying on Material or Cupertino.',
            textAlign: TextAlign.justify,
          ).p(),
          const Text(
            'Already using Material or Cupertino? You can adopt shadcn_flutter incrementally: mix components inside your '
            'existing MaterialApp/CupertinoApp, keep your navigation (e.g., GoRouter), and align visuals with '
            'your shadcn_flutter theme. Interop is optional—go all‑in when you\'re ready.',
            textAlign: TextAlign.justify,
          ).p(),
          const Text('Features').h2().anchored(featuresKey),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('84 components and growing!').li(),
              const Text(
                      'Standalone ecosystem: no Material or Cupertino requirement; optional interop when needed.')
                  .li(),
              const Text(
                      'shadcn/ui design tokens and ready-to-use New York theme.')
                  .li(),
              const Text(
                      'Works inside MaterialApp and CupertinoApp; mix and match while you migrate.')
                  .li(),
              const Text(
                      'First-class support across Android, iOS, Web, macOS, Windows, and Linux.')
                  .li(),
              const Text('Various widget extensions for typography purposes.')
                  .li(),
              const Text('Supports WebAssembly for better performance.').li(),
            ],
          ).p(),
          const Text('Notes').h2().anchored(notesKey),
          const Text(
                  'This package is still in development and may have breaking changes in the future. '
                  'Please be cautious when using this package in production.')
              .p(),
          const Text(
            'This package is not affiliated with Shadcn/UI. This package is a community-driven project.',
          ).p(),
          const Text('Frequently Asked Questions').h2().anchored(faqKey),
          Accordion(
            items: [
              const AccordionItem(
                trigger: AccordionTrigger(
                    child: Text('Does this support GoRouter?')),
                content: Text(
                    'Yes, it does. You can use GoRouter with shadcn_flutter. '),
              ),
              const AccordionItem(
                trigger: AccordionTrigger(
                  child: Text('Can I use this in my project?'),
                ),
                content: Text(
                    'Yes! Free to use for personal and commercial projects. No attribution required.'),
              ),
              AccordionItem(
                trigger: const AccordionTrigger(
                  child:
                      Text('Can I use this with Material/Cupertino Widgets?'),
                ),
                content: const Text(
                        'Yes. If your app already uses Material or Cupertino, shadcn_flutter plays nicely with both. ')
                    .thenText('You can:')
                    .thenText(
                        '\n• Drop shadcn_flutter components into an existing MaterialApp/CupertinoApp')
                    .thenText(
                        '\n• Keep your current routing (e.g., GoRouter) and state management')
                    .thenText(
                        '\n• Adopt incrementally and go all‑in when ready for a full ecosystem switch ')
                    .thenButton(
                        onPressed: () {
                          context.goNamed('external');
                        },
                        child: const Text('See interop guidance')),
              ),
              AccordionItem(
                trigger: const AccordionTrigger(
                  child: Text(
                      'Can I configure which style i would like to use? (Default/New York)'),
                ),
                content: const Text(
                        'Unfortunately you can\'t. This package only supports New York style. '
                        'But if you wish to have default style of Shadcn/UI, i would recommend ')
                    .thenButton(
                        onPressed: () {
                          launchUrlString(
                              'https://github.com/nank1ro/flutter-shadcn-ui');
                        },
                        child: const Text('this package'))
                    .thenText(' by ')
                    .thenButton(
                        onPressed: () {
                          launchUrlString('https://x.com/nank1ro');
                        },
                        child: const Text('@nank1ro'))
                    .thenText('.'),
              ),
            ],
          ),
          const Text('Links').h2().anchored(linksKey),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Github: ')
                  .thenButton(
                      onPressed: () {
                        launchUrlString(
                            'https://github.com/sunarya-thito/shadcn_flutter');
                      },
                      child: const Text(
                          'https://github.com/sunarya-thito/shadcn_flutter'))
                  .li(),
              const Text('pub.dev: ')
                  .thenButton(
                      onPressed: () {
                        launchUrlString(
                            'https://pub.dev/packages/shadcn_flutter');
                      },
                      child:
                          const Text('https://pub.dev/packages/shadcn_flutter'))
                  .li(),
              const Text('Discord: ')
                  .thenButton(
                      onPressed: () {
                        launchUrlString('https://discord.gg/ZzfBPQG4sV');
                      },
                      child: const Text('https://discord.gg/ZzfBPQG4sV'))
                  .li(),
            ],
          ).p(),
        ],
      ),
    );
  }
}
