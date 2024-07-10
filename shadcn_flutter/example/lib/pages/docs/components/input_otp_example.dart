import 'package:example/pages/docs/component_page.dart';
import 'package:example/pages/docs/components/input_otp/input_otp_example_1.dart';
import 'package:example/pages/docs/components/input_otp/input_otp_example_3.dart';
import 'package:example/pages/docs/components/input_otp/input_otp_example_4.dart';
import 'package:example/pages/widget_usage_example.dart';
import 'package:shadcn_flutter/shadcn_flutter.dart';

import 'input_otp/input_otp_example_2.dart';

class InputOTPExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ComponentPage(
      name: 'input_otp',
      description:
          'Input OTP is a component that allows users to enter OTP code.',
      displayName: 'Input OTP',
      children: [
        WidgetUsageExample(
          title: 'Example',
          child: InputOTPExample1(),
          path: 'lib/pages/docs/components/input_otp/input_otp_example_1.dart',
        ),
        WidgetUsageExample(
          title: 'Initial Value Example',
          child: InputOTPExample2(),
          path: 'lib/pages/docs/components/input_otp/input_otp_example_2.dart',
        ),
        WidgetUsageExample(
          title: 'Obscured Example',
          child: InputOTPExample3(),
          path: 'lib/pages/docs/components/input_otp/input_otp_example_3.dart',
        ),
        WidgetUsageExample(
          title: 'Upper Case Alphabet Example',
          child: InputOTPExample4(),
          path: 'lib/pages/docs/components/input_otp/input_otp_example_4.dart',
        ),
      ],
    );
  }
}
