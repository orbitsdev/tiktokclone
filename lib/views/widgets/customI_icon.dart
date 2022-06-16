import 'package:flutter/material.dart';

class CustomIIcon extends StatelessWidget {
const CustomIIcon({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return SizedBox(
      height: 30,
      width: 45,
      child: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10,),width: 38,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 250, 45, 108),
              borderRadius: BorderRadius.circular(7) 
            ),
          ),
          Container(
            margin: EdgeInsets.only(right: 10,),width: 38,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 32, 45, 108),
              borderRadius: BorderRadius.circular(7) 
            ),
          ),
          Center(
            child:Container(
              width: 38,
              height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7) 
            ),
            child: const Icon(Icons.add, color:  Colors.black,),
          ), 
          )
        ],
      ),
    );
  }
}