import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef ValidatedBuilder = Widget Function(
    BuildContext context, ValidationResult? error, Widget? child);

class Validated<T> extends StatefulWidget {
  final ValidatedBuilder builder;
  final Validator<T> validator;
  final Widget? child;

  const Validated({
    super.key,
    required this.builder,
    required this.validator,
    this.child,
  });

  @override
  State<Validated> createState() => _ValidatedState();
}

class _ValidatedState extends State<Validated> {
  final formKey = const FormKey(#validated);
  @override
  Widget build(BuildContext context) {
    return Form(
      child: FormEntry(
        key: formKey,
        validator: widget.validator,
        child: FormEntryErrorBuilder(
          builder: (context, error, child) {
            return widget.builder(context, error, child);
          },
          child: widget.child,
        ),
      ),
    );
  }
}
