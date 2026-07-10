class MyComplexData {
  final int myInt;
  final bool myBool;

  const MyComplexData({
    required this.myInt,
    required this.myBool,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MyComplexData &&
        other.myInt == myInt &&
        other.myBool == myBool;
  }

  @override
  int get hashCode => Object.hash(myInt, myBool);
}
