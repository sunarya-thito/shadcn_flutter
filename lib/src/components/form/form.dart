import 'package:email_validator/email_validator.dart' as email_validator;
import 'package:flutter/widgets.dart';

import '../../../shadcn_flutter.dart';

abstract class Validator<T> {
  const Validator();
  ValidationResult? validate(BuildContext context, T? value);

  Validator<T> combine(Validator<T> other) {
    return CompositeValidator([this, other]);
  }

  Validator<T> operator &(Validator<T> other) {
    return combine(other);
  }

  Validator<T> operator |(Validator<T> other) {
    return OrValidator([this, other]);
  }

  Validator<T> operator ~() {
    return NotValidator(this);
  }

  Validator<T> operator +(Validator<T> other) {
    return combine(other);
  }
}

class NotValidator<T> extends Validator<T> {
  final Validator<T> validator;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const NotValidator(this.validator, {this.message});

  @override
  ValidationResult? validate(BuildContext context, T? value) {
    var result = validator.validate(context, value);
    if (result == null) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).invalidValue);
    }
    return null;
  }
}

class OrValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;

  const OrValidator(this.validators);

  @override
  ValidationResult? validate(BuildContext context, T? value) {
    ValidationResult? result;
    for (var validator in validators) {
      result = validator.validate(context, value);
      if (result == null) {
        return null;
      }
    }
    return result;
  }

  @override
  Validator<T> operator |(Validator<T> other) {
    return OrValidator([...validators, other]);
  }
}

class NonNullValidator<T> extends Validator<T> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const NonNullValidator({this.message});

  @override
  ValidationResult? validate(BuildContext context, T? value) {
    if (value == null) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formNotEmpty);
    }
    return null;
  }
}

class NotEmptyValidator extends NonNullValidator<String> {
  const NotEmptyValidator({String? message}) : super(message: message);

  @override
  ValidationResult? validate(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formNotEmpty);
    }
    return null;
  }
}

class LengthValidator extends Validator<String> {
  final int? min;
  final int? max;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const LengthValidator({this.min, this.max, this.message});

  @override
  ValidationResult? validate(BuildContext context, String? value) {
    if (value == null) {
      return null;
    }
    if (min != null && value.length < min!) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations)
              .formLengthLessThan(min!));
    }
    if (max != null && value.length > max!) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations)
              .formLengthGreaterThan(max!));
    }
    return null;
  }
}

class SafePasswordValidator extends Validator<String> {
  final String?
      message; // if null, use default message from ShadcnLocalizations
  final bool requireDigit;
  final bool requireLowercase;
  final bool requireUppercase;
  final bool requireSpecialChar;

  const SafePasswordValidator(
      {this.requireDigit = true,
      this.requireLowercase = true,
      this.requireUppercase = true,
      this.requireSpecialChar = true,
      this.message});

  @override
  ValidationResult? validate(BuildContext context, String? value) {
    if (value == null) {
      return null;
    }
    if (requireDigit && !RegExp(r'\d').hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formPasswordDigits);
    }
    if (requireLowercase && !RegExp(r'[a-z]').hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formPasswordLowercase);
    }
    if (requireUppercase && !RegExp(r'[A-Z]').hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formPasswordUppercase);
    }
    if (requireSpecialChar && !RegExp(r'[\W_]').hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).formPasswordSpecial);
    }
    return null;
  }
}

class MinValidator<T extends num> extends Validator<T> {
  final T min;
  final bool inclusive;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const MinValidator(this.min, {this.inclusive = true, this.message});

  @override
  ValidationResult? validate(BuildContext context, T? value) {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value < min) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formGreaterThanOrEqualTo(min));
      }
    } else {
      if (value <= min) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formGreaterThan(min));
      }
    }
    return null;
  }
}

class MaxValidator<T extends num> extends Validator<T> {
  final T max;
  final bool inclusive;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const MaxValidator(this.max, {this.inclusive = true, this.message});

  @override
  ValidationResult? validate(BuildContext context, T? value) {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value > max) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formLessThanOrEqualTo(max));
      }
    } else {
      if (value >= max) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations).formLessThan(max));
      }
    }
    return null;
  }
}

class RangeValidator<T extends num> extends Validator<T> {
  final T min;
  final T max;
  final bool inclusive;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const RangeValidator(this.min, this.max,
      {this.inclusive = true, this.message});

  @override
  ValidationResult? validate(BuildContext context, T? value) {
    if (value == null) {
      return null;
    }
    if (inclusive) {
      if (value < min || value > max) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formBetweenInclusively(min, max));
      }
    } else {
      if (value <= min || value >= max) {
        return InvalidResult(message ??
            Localizations.of(context, ShadcnLocalizations)
                .formBetweenExclusively(min, max));
      }
    }
    return null;
  }
}

class RegexValidator extends Validator<String> {
  final RegExp pattern;
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const RegexValidator(this.pattern, {this.message});

  @override
  ValidationResult? validate(BuildContext context, String? value) {
    if (value == null) {
      return null;
    }
    if (!pattern.hasMatch(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).invalidValue);
    }
    return null;
  }
}

// email validator using email_validator package
class EmailValidator extends Validator<String> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const EmailValidator({this.message});

  @override
  ValidationResult? validate(BuildContext context, String? value) {
    if (value == null) {
      return null;
    }
    if (!email_validator.EmailValidator.validate(value)) {
      return InvalidResult(message ??
          Localizations.of(context, ShadcnLocalizations).invalidEmail);
    }
    return null;
  }
}

class URLValidator extends Validator<String> {
  final String?
      message; // if null, use default message from ShadcnLocalizations

  const URLValidator({this.message});

  @override
  ValidationResult? validate(BuildContext context, String? value) {
    if (value == null) {
      return null;
    }
    try {
      Uri.parse(value);
    } on FormatException {
      return InvalidResult(
          message ?? Localizations.of(context, ShadcnLocalizations).invalidURL);
    }
    return null;
  }
}

class CompositeValidator<T> extends Validator<T> {
  final List<Validator<T>> validators;

  const CompositeValidator(this.validators);

  @override
  ValidationResult? validate(BuildContext context, T? value) {
    for (var validator in validators) {
      var result = validator.validate(context, value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  @override
  Validator<T> combine(Validator<T> other) {
    return CompositeValidator([...validators, other]);
  }
}

abstract class ValidationResult {
  const ValidationResult();
}

class ReplaceResult<T> extends ValidationResult {
  final T value;

  const ReplaceResult(this.value);
}

class InvalidResult extends ValidationResult {
  final String message;

  const InvalidResult(this.message);
}

class FormValidityNotification extends Notification {
  final ValidationResult? oldValidity;
  final ValidationResult? newValidity;

  const FormValidityNotification(this.newValidity, this.oldValidity);
}

class FormKey<T> extends LabeledGlobalKey<FormEntryState<FormEntry<T>, T>> {
  FormKey(String? label) : super(label);

  T? get value {
    assert(currentState != null, 'FormKey is not attached to a FormEntry');
    return currentState?.value;
  }

  ValidationResult? get validity {
    assert(currentState != null, 'FormKey is not attached to a FormEntry');
    return currentState?.validity;
  }

  void validate() {
    assert(currentState != null, 'FormKey is not attached to a FormEntry');
    currentState?.validate();
  }

  void reset() {
    assert(currentState != null, 'FormKey is not attached to a FormEntry');
    currentState?.reset();
  }

  set value(T? value) {
    assert(currentState != null, 'FormKey is not attached to a FormEntry');
    currentState?.value = value;
  }
}

abstract class FormEntry<T> extends StatefulWidget {
  final Widget? label;
  final Validator<T>? validator;
  final T? initialValue;
  final Widget? hint;
  const FormEntry(
      {this.label, super.key, this.validator, this.initialValue, this.hint});
  @override
  FormEntryState<FormEntry<T>, T> createState();
}

abstract class FormEntryState<T extends FormEntry<V>, V> extends State<T> {
  V? _value;
  ValidationResult? _validity;
  ValidationResult? get validity => _validity;
  V? get value => _value;
  FormState? _form;

  set value(V? value) {
    if (_value != value) {
      setState(() {
        _value = value;
      });
      validate();
    }
  }

  void reset() {
    if (_value != widget.initialValue) {
      setState(() {
        _value = widget.initialValue;
      });
      validate();
    }
  }

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    FormState? oldForm = _form;
    _form = Data.maybeOf(context);
    if (_validity != null) {
      oldForm?._removeValidity(_validity!);
      _form?._addValidity(_validity!);
    }
    validate();
  }

  @override
  void dispose() {
    if (_validity != null) {
      _form?._removeValidity(_validity!);
    }
    super.dispose();
  }

  void validate() {
    ValidationResult? result = widget.validator?.validate(context, _value);
    if (_validity != result) {
      setState(() {
        ValidationResult? oldValidity = _validity;
        _validity = result;
        if (oldValidity != null) {
          _form?._removeValidity(oldValidity);
        }
        if (_validity != null) {
          _form?._addValidity(_validity!);
        }
      });
    }
  }

  Widget buildEditor(BuildContext context);
}

class Form extends StatefulWidget {
  final List<Widget> children;

  const Form({super.key, required this.children});

  @override
  FormState createState() => FormState();
}

class FormState extends State<Form> {
  final List<ValidationResult> _validities = [];

  void _addValidity(ValidationResult validity) {
    if (!_validities.contains(validity)) {
      setState(() {
        _validities.add(validity);
      });
    }
  }

  void _removeValidity(ValidationResult validity) {
    if (_validities.contains(validity)) {
      setState(() {
        _validities.remove(validity);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Data(
      data: this,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.children,
      ),
    );
  }
}

class FormHeader extends StatelessWidget {
  final Widget title;
  final Widget? subtitle;

  const FormHeader({super.key, required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        title.large().medium(),
        if (subtitle != null) subtitle!.small().muted(),
        const SizedBox(height: 24),
        const Divider(),
      ],
    );
  }
}

class FormColumn extends StatelessWidget {
  final List<Widget> children;
  const FormColumn({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: join(children, const SizedBox(height: 32)).toList(),
    );
  }
}

class FormRow extends StatelessWidget {
  final List<Widget> children;
  const FormRow({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: join(children, const SizedBox(width: 32)).toList(),
    );
  }
}
