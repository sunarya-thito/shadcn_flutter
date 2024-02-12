import 'package:flutter/widgets.dart';

import '../../../shadcn_flutter.dart';

class Headline1 extends StatelessWidget {
  final Widget child;

  const Headline1({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.headline1,
      child: child,
    );
  }
}

class Headline2 extends StatelessWidget {
  final Widget child;

  const Headline2({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.headline2,
      child: child,
    );
  }
}

class Headline3 extends StatelessWidget {
  final Widget child;

  const Headline3({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.headline3,
      child: child,
    );
  }
}

class Headline4 extends StatelessWidget {
  final Widget child;

  const Headline4({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.headline4,
      child: child,
    );
  }
}

class Blockquote extends StatelessWidget {
  final Widget child;

  const Blockquote({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.blockquote,
      child: child,
    );
  }
}

class TableHeaderText extends StatelessWidget {
  final Widget child;

  const TableHeaderText({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.tableHeader,
      child: child,
    );
  }
}

class TableCellText extends StatelessWidget {
  final Widget child;

  const TableCellText({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.tableCell,
      child: child,
    );
  }
}

class ListText extends StatelessWidget {
  final Widget child;

  const ListText({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.list,
      child: child,
    );
  }
}

class InlineCode extends StatelessWidget {
  final Widget child;

  const InlineCode({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.inlineCode,
      child: child,
    );
  }
}

class Lead extends StatelessWidget {
  final Widget child;

  const Lead({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return mergeAnimatedTextStyle(
      duration: kDefaultDuration,
      style: Theme.of(context).typography.lead,
      child: child,
    );
  }
}
