import 'package:shadcn_flutter/shadcn_flutter.dart';

class CardExample1 extends StatelessWidget {
  const CardExample1({super.key});
  
  @override
  Widget build(BuildContext context) {
     return Card( padding: EdgeInsets.all(24), child: Column( crossAxisAlignment: CrossAxisAlignment.start, children: [ Text('Create project').semiBold(), const SizedBox(height: 4), Text('Deploy your new project in one-click').muted().small(), const SizedBox(height: 24), Text('Name').semiBold().small(), const SizedBox(height: 4), TextField(placeholder: 'Name of your project'), const SizedBox(height: 16), Text('Description').semiBold().small(), const SizedBox(height: 4), TextField(placeholder: 'Description of your project'), const SizedBox(height: 24), Row( children: [ OutlineButton( child: Text('Cancel'), onPressed: () {}, ), Spacer(), PrimaryButton( child: Text('Deploy'), onPressed: () {}, ), ], ), ], ), ).intrinsic(); 
  }
}
    