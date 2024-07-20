import 'package:shadcn_flutter/shadcn_flutter.dart';

class ToastExample1 extends StatefulWidget {
  @override
  State<ToastExample1> createState() => _ToastExample1State();
}

class _ToastExample1State extends State<ToastExample1> {
  Widget buildToast(BuildContext context) {
    return Card(
      child: Text('Hello World'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.bottomLeft,
            );
          },
          child: Text('Show Bottom Left Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.bottomRight,
            );
          },
          child: Text('Show Bottom Right Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.topLeft,
            );
          },
          child: Text('Show Top Left Toast'),
        ),
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.topRight,
            );
          },
          child: Text('Show Top Right Toast'),
        ),
        // bottom center
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.bottomCenter,
            );
          },
          child: Text('Show Bottom Center Toast'),
        ),
        // top center
        PrimaryButton(
          onPressed: () {
            showToast(
              context: context,
              builder: buildToast,
              location: ToastLocation.topCenter,
            );
          },
          child: Text('Show Top Center Toast'),
        ),
      ],
    );
  }
}
