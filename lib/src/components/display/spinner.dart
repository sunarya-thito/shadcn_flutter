import '../../../shadcn_flutter.dart';

abstract class SpinnerTransform {}

abstract class SpinnerElement {
  void paint(Canvas canvas, Size size, Matrix4 transform);
}

abstract class Spinner extends StatelessWidget {
  const Spinner({super.key});
}
