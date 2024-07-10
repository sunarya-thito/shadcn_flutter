import 'package:shadcn_flutter/shadcn_flutter.dart';

class SheetExample1 extends StatefulWidget {
  @override
  State<SheetExample1> createState() => _SheetExample1State();
}

class _SheetExample1State extends State<SheetExample1> {
  final FormController controller = FormController();

  void saveProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: AlertDialog(
            title: Text('Profile updated'),
            content: Text('Content: ${controller.values}'),
            actions: [
              PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget buildSheet(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(24),
      constraints: BoxConstraints(maxWidth: 400),
      child: Form(
        controller: controller,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Text('Edit profile').large().medium(),
                ),
                TextButton(
                  density: ButtonDensity.icon,
                  child: Icon(Icons.close),
                  onPressed: () {
                    closeSheet(context);
                  },
                ),
              ],
            ),
            gap(8),
            Text('Make changes to your profile here. Click save when you\'re done.')
                .muted(),
            gap(16),
            FormTableLayout(
              rows: [
                FormRow<String>(
                  key: FormKey(#name),
                  label: Text('Name'),
                  validator: NotEmptyValidator() & LengthValidator(min: 4),
                  child: TextField(
                    initialValue: 'Thito Yalasatria Sunarya',
                    placeholder: 'Your fullname',
                  ),
                ),
                FormRow<String>(
                  key: FormKey(#username),
                  label: Text('Username'),
                  validator: NotEmptyValidator() & LengthValidator(min: 4),
                  child: TextField(
                    initialValue: '@sunarya-thito',
                    placeholder: 'Your username',
                  ),
                ),
              ],
            ),
            gap(16),
            Align(
              alignment: Alignment.centerRight,
              child: FormErrorBuilder(
                builder: (context, errors, child) {
                  return PrimaryButton(
                    onPressed: errors.isNotEmpty
                        ? null
                        : () {
                            context.submitForm().then(
                              (value) {
                                if (value.errors.isEmpty) {
                                  closeSheet(context).then(
                                    (value) {
                                      saveProfile();
                                    },
                                  );
                                }
                              },
                            );
                          },
                    child: Text('Save changes'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        openSheet(
          context: context,
          builder: (context) {
            return buildSheet(context);
          },
          position: OverlayPosition.right,
        );
      },
      child: Text('Open Sheet'),
    );
  }
}
