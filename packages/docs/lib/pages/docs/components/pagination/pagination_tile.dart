import 'package:docs/pages/docs/components_page.dart';
import 'package:docs/pages/docs/components/pagination/pagination_example_1.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

class PaginationTile extends StatelessWidget implements IComponentPage {
  const PaginationTile({super.key});

  @override
  String get title => 'Pagination';

  @override
  Widget build(BuildContext context) {
    return ComponentCard(
      title: 'Pagination',
      name: 'pagination',
      reverse: true,
      example: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Card(child: PaginationExample1()),
          Transform.translate(
              offset: const Offset(250, 0),
              child: const Card(child: PaginationExample1())),
        ],
      ).gap(16),
    );
  }
}
