import 'package:flutter/material.dart';

class Xgap extends StatelessWidget {

  final double width;
  const Xgap({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width:width ,
    );
  }
}
