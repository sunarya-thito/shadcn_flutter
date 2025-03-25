import 'dart:async';

import 'package:shadcn_flutter/shadcn_flutter.dart';

typedef FutureOrWidgetBuilder<T> = Widget Function(
    BuildContext context, AsyncSnapshot<T> snapshot);

class FutureOrBuilder<T> extends StatelessWidget {
  final FutureOr<T> future;
  final FutureOrWidgetBuilder<T> builder;
  final T? initialValue;

  const FutureOrBuilder({
    super.key,
    required this.future,
    required this.builder,
    this.initialValue,
  });

  @override
  Widget build(BuildContext context) {
    if (future is Future<T>) {
      return FutureBuilder<T>(
        future: future as Future<T>,
        initialData: initialValue,
        builder: builder,
      );
    }
    return builder(
        context, AsyncSnapshot.withData(ConnectionState.done, future as T));
  }
}
