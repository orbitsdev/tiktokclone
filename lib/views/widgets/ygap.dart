import 'package:flutter/material.dart';

class Ygap extends StatelessWidget {

  final double height;
  const Ygap({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: height,
    );
  }
}
