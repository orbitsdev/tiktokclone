import 'package:flutter/material.dart';

class BuildMusicAlbum extends StatelessWidget {
  final String profilephoto;
  const BuildMusicAlbum({
    Key? key,
    required this.profilephoto,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return SizedBox(width: 60, height: 60, child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(11),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.grey,
                Colors.white,
              ],

            ),
            borderRadius: BorderRadius.circular(25),
            
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image(image: NetworkImage(profilephoto), fit: BoxFit.cover,),

          ),
        )
      ],
    ),);
  }
}
