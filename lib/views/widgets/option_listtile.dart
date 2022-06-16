import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class OptionListtile extends StatelessWidget {

  String title;
  IconData icon;
   OptionListtile({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  @override
  Widget build(BuildContext context){
    return   ListTile(
              title: Text(title),
              leading: ClipOval(
                child: Container(
                  height: 40,
                  width: 40,
                  color: Colors.grey[200],
                  child: Center(child: FaIcon(icon, color: Colors.black,))),
              ),
            );
  }
}