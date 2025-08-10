import 'package:docs/pages/docs/components_page.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class OverflowMarqueeTile extends StatelessWidget implements IComponentPage {
  const OverflowMarqueeTile({super.key});

  @override
  String get title => 'Overflow Marquee';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
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
              Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.muted,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: const Center(
                          child: Text(
                            'This is a very long text that will scroll horizontally when it overflows the container width',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ),
                      // Simulate scrolling effect with positioned text
                      Positioned(
                        left: -100,
                        top: 12,
                        child: const Text(
                          'This is a very long text that will scroll...',
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                    ],
                  ),
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
