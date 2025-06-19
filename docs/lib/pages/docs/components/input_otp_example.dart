import 'package:docs/pages/docs/component_page.dart';
import 'package:docs/pages/docs/components/input_otp/input_otp_example_1.dart';
import 'package:docs/pages/docs/components/input_otp/input_otp_example_3.dart';
import 'package:docs/pages/docs/components/input_otp/input_otp_example_4.dart';
import 'package:docs/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'input_otp/input_otp_example_2.dart';

class InputOTPExample extends StatelessWidget {
  const InputOTPExample({super.key});

  @override
  Widget build(BuildContext context) {
    return const ComponentPage(
      name: 'input_otp',
      description:
          'Input OTP is a component that allows users to enter OTP code.',
      displayName: 'Input OTP',
      children: [
        WidgetUsageExample(
          title: 'Example',
          path: 'lib/pages/docs/components/input_otp/input_otp_example_1.dart',
          child: InputOTPExample1(),
        ),
        WidgetUsageExample(
          title: 'Initial Value Example',
          path: 'lib/pages/docs/components/input_otp/input_otp_example_2.dart',
          child: InputOTPExample2(),
        ),
        WidgetUsageExample(
          title: 'Obscured Example',
          path: 'lib/pages/docs/components/input_otp/input_otp_example_3.dart',
          child: InputOTPExample3(),
        ),
        WidgetUsageExample(
          title: 'Upper Case Alphabet Example',
          path: 'lib/pages/docs/components/input_otp/input_otp_example_4.dart',
          child: InputOTPExample4(),
        ),
      ],
    );
  }
}
