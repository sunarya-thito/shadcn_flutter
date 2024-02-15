import 'package:shadcn_flutter/shadcn_flutter.dart';

void a() {
  // Scaffold.of(context).openDrawer()
  // PopupMenuButton
  // ScaffoldMessenger
  // Scrollbar
  // showMenu(context: context, position: position, items: items)
  Validator<String> validator =
      NotEmptyValidator() & EmailValidator() & LengthValidator(min: 6, max: 20);
}
