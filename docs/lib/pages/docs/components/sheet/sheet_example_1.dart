import 'package:shadcn_flutter/shadcn_flutter.dart';

class SheetExample1 extends StatefulWidget {
  const SheetExample1({super.key});

  @override
  State<SheetExample1> createState() => _SheetExample1State();
}

class _SheetExample1State extends State<SheetExample1> {
  // A form controller to read values and validation state inside the sheet.
  final FormController controller = FormController();

  void saveProfile() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Profile updated'),
          // For demo, show raw form values.
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
                    // Close the sheet without saving.
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
                    placeholder: Text('Your fullname'),
                  ),
                ),
                FormField<String>(
                  key: const FormKey(#username),
                  label: const Text('Username'),
                  validator:
                      const NotEmptyValidator() & const LengthValidator(min: 4),
                  child: const TextField(
                    initialValue: '@sunarya-thito',
                    placeholder: Text('Your username'),
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
                    // Disable save while there are validation errors.
                    onPressed: errors.isNotEmpty
                        ? null
                        : () {
                            // Attempt to submit the form; close the sheet when successful
                            // and show a confirmation dialog.
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
            // Build the sheet content; keep it small and focused on the form.
            return buildSheet(context);
          },
          // Slide in from the end (right on LTR).
          position: OverlayPosition.end,
        );
      },
      child: const Text('Open Sheet'),
    );
  }
}
