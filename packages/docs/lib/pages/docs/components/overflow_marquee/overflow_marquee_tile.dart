import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OverflowMarqueeTile extends StatelessWidget implements IComponentPage {
  const OverflowMarqueeTile({super.key});

  @override
  String get title => 'Overflow Marquee';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      name: 'overflow_marquee',
      title: 'Overflow Marquee',
      scale: 1.2,
      example: Card(
        child: Container(
          width: 250,
          height: 120,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const Text('Scrolling Text:').bold(),
              const Gap(16),
              const OverflowMarquee(
                child: Text(
                  'This is a very long text that will scroll horizontally when it overflows the container width',
                ),
              ),
              const Gap(8),
              const Text('Auto-scrolling overflow text').muted(),
            ],
          ),
        ),
      ),
    );
  }
}
