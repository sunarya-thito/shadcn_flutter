import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';

enum BadgeVariant { primary, secondary, outline, destructive }

class GenBadgeSchema extends GenSchema {
  late final GenField<String> text;
  late final GenField<BadgeVariant> variant;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    text = descriptor.string('text', label: 'Badge text', example: 'New');
    variant = descriptor.enumerated(
      'variant',
      label: 'Style',
      values: BadgeVariant.values,
      example: BadgeVariant.primary,
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    final label = Text(text[context]);
    return switch (variant[context]) {
      BadgeVariant.primary => PrimaryBadge(child: label),
      BadgeVariant.secondary => SecondaryBadge(child: label),
      BadgeVariant.outline => OutlineBadge(child: label),
      BadgeVariant.destructive => DestructiveBadge(child: label),
    };
  }
}

const genBadge = GenCatalogItem(
  name: 'Badge',
  label: 'A small label for a short status or tag, in several visual styles.',
  schema: GenBadgeSchema.new,
);
