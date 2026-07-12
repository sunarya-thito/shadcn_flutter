import 'package:shadcn_flutter/shadcn_flutter.dart';
import 'package:shadcn_flutter_genui/src/gen_schema.dart';

class GenAvatarSchema extends GenSchema {
  late final GenField<String> initials;
  late final GenField<String?> photoUrl;

  @override
  void describeFields(GenFieldDescriptor descriptor) {
    initials = descriptor.string(
      'initials',
      label: 'Fallback initials',
      example: 'AB',
    );
    photoUrl = descriptor.optionalString('photoUrl', label: 'Photo URL');
  }

  @override
  Widget buildWidget(BuildContext context) {
    final url = photoUrl[context];
    if (url != null) {
      return Avatar.network(initials: initials[context], photoUrl: url);
    }
    return Avatar(initials: initials[context]);
  }
}

const genAvatar = GenCatalogItem(
  name: 'Avatar',
  label: 'A circular image or fallback initials representing a user or entity.',
  schema: GenAvatarSchema.new,
);
