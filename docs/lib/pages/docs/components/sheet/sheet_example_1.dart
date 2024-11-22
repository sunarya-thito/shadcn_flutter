import 'package:shadcn_flutter/shadcn_flutter.dart';

class SheetExample1 extends StatefulWidget {
  const SheetExample1({super.key});

  @override
  State<SheetExample1> createState() => _SheetExample1State();
}

class _SheetExample1State extends State<SheetExample1> {
  final FormController controller = FormController();

  void saveProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profile updated'),
          content: Text('Content: ${controller.values}'),
          actions: [
            PrimaryButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget buildSheet(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      constraints: const BoxConstraints(maxWidth: 400),
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
                  child: const Text('Edit profile').large().medium(),
                ),
                TextButton(
                  density: ButtonDensity.icon,
                  child: const Icon(Icons.close),
                  onPressed: () {
                    closeSheet(context);
                  },
                ),
              ],
            ),
            const Gap(8),
            const Text(
                    'Make changes to your profile here. Click save when you\'re done.')
                .muted(),
            const Gap(16),
            FormTableLayout(
              rows: [
                FormField<String>(
                  key: const FormKey(#name),
                  label: const Text('Name'),
                  validator:
                      const NotEmptyValidator() & const LengthValidator(min: 4),
                  child: const TextField(
                    initialValue: 'Thito Yalasatria Sunarya',
                    placeholder: 'Your fullname',
                  ),
                ),
                FormField<String>(
                  key: const FormKey(#username),
                  label: const Text('Username'),
                  validator:
                      const NotEmptyValidator() & const LengthValidator(min: 4),
                  child: const TextField(
                    initialValue: '@sunarya-thito',
                    placeholder: 'Your username',
                  ),
                ),
              ],
            ),
            const Gap(16),
            Align(
              alignment: AlignmentDirectional.centerEnd,
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
                    child: const Text('Save changes'),
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
      child: const Text('Open Sheet'),
    );
  }
}
