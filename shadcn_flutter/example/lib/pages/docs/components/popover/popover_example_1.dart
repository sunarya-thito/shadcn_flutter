import 'package:shadcn_flutter/shadcn_flutter.dart';

class PopoverExample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Popover(
      builder: (context) {
        return PrimaryButton(
          onPressed: () {
            context.showPopover();
          },
          child: Text('Open popover'),
        );
      },
      popoverBuilder: (context) {
        return Card(
          child: SizedBox(
            width: 300,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Dimensions').large().medium(),
                Text('Set the dimensions for the layer.').muted(),
                Form(
                  controller: FormController(),
                  child: FormTableLayout(
                    rows: [
                      FormRow<double>(
                        key: FormKey(#width),
                        label: Text('Width'),
                        child: TextField(
                          initialValue: '100%',
                        ),
                      ),
                      FormRow<double>(
                        key: FormKey(#maxWidth),
                        label: Text('Max. Width'),
                        child: TextField(
                          initialValue: '300px',
                        ),
                      ),
                      FormRow<double>(
                        key: FormKey(#height),
                        label: Text('Height'),
                        child: TextField(
                          initialValue: '25px',
                        ),
                      ),
                      FormRow<double>(
                        key: FormKey(#maxHeight),
                        label: Text('Max. Height'),
                        child: TextField(
                          initialValue: 'none',
                        ),
                      ),
                    ],
                    spacing: 8,
                  ),
                ).withPadding(vertical: 16),
              ],
            ),
          ),
        ).withPadding(vertical: 8);
      },
      alignment: Alignment.topCenter,
    );
  }
}
