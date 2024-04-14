import 'package:shadcn_flutter/shadcn_flutter.dart';

class ButtonExample8 extends StatelessWidget {
  const ButtonExample8({super.key});
  
  @override
  Widget build(BuildContext context) {
     return PrimaryButton( onPressed: () {}, padding: Button.iconPadding, child: Icon(Icons.add), ); 
  }
}
    