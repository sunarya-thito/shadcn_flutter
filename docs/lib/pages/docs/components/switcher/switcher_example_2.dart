import 'package:shadcn_flutter/shadcn_flutter.dart';

class SwitcherExample2 extends StatefulWidget {
  const SwitcherExample2({super.key});

  @override
  State<SwitcherExample2> createState() => _SwitcherExample2State();
}

class _SwitcherExample2State extends State<SwitcherExample2> {
  bool _isRegister = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Switcher(
        index: _isRegister ? 1 : 0,
        onIndexChanged: (index) {
          setState(() {
            _isRegister = index == 1;
          });
        },
        direction: AxisDirection.left,
        children: [
          Container(
            key: const Key('login'),
            width: 350,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                FormField(
                  key: TextFieldKey(#email),
                  label: Text('Email'),
                  validator: EmailValidator() & NotEmptyValidator(),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(),
                ),
                FormField(
                  key: TextFieldKey(#password),
                  label: Text('Password'),
                  validator: NotEmptyValidator(),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(obscureText: true),
                ),
                SubmitButton(
                  child: Text('Login'),
                ),
                Text('Don\'t have an account? ').thenButton(
                    onPressed: () {
                      setState(() {
                        _isRegister = true;
                      });
                    },
                    child: Text('Sign Up!')),
              ],
            ),
          ),
          Container(
            key: Key('register-form'),
            width: 350,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                FormField(
                  key: TextFieldKey(#email),
                  label: Text('Email'),
                  validator: EmailValidator() & NotEmptyValidator(),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(),
                ),
                FormField(
                  key: TextFieldKey(#password),
                  label: Text('Password'),
                  validator: LengthValidator(
                      min: 6,
                      message: 'Password must be at least 6 characters'),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(obscureText: true),
                ),
                FormField(
                  key: TextFieldKey(#confirmPassword),
                  label: Text('Confirm Password'),
                  validator: CompareWith.equal(TextFieldKey(#password),
                      message: 'Passwords do not match'),
                  showErrors: {
                    FormValidationMode.changed,
                    FormValidationMode.submitted,
                  },
                  child: TextField(obscureText: true),
                ),
                SubmitButton(
                  child: Text('Register'),
                ),
                Text('Already have an account? ').thenButton(
                    onPressed: () {
                      setState(() {
                        _isRegister = false;
                      });
                    },
                    child: Text('Login!')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
