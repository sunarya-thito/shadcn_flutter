import 'package:flutter/material.dart' as mat;
import 'package:flutter/widgets.dart';

import '../../shadcn_flutter.dart';

class CircularProgressIndicator extends StatelessWidget {
  final double? value;

  const CircularProgressIndicator({
    Key? key,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconThemeData = IconTheme.of(context);
    final theme = Theme.of(context);
    return RepaintBoundary(
      child: SizedBox(
        width: (iconThemeData.size ?? 24) - 8,
        height: (iconThemeData.size ?? 24) - 8,
        child: mat.CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            iconThemeData.color ?? theme.colorScheme.primaryForeground,
          ),
          strokeWidth: (iconThemeData.size ?? 24) / 12,
          value: value,
        ),
      ),
    );
  }
}
