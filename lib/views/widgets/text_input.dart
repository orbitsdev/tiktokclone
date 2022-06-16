import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:tiktokclone/theme/app_color.dart';

class TextInput extends StatelessWidget {

  final TextEditingController controller;
  final String labeltext;
  final IconData icon;
  final bool isObscure;

  const TextInput({
    Key? key,
    required this.controller,
    required this.labeltext,
    required this.icon,
    required this.isObscure,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labeltext,
        prefixIcon:  SizedBox(
          child: Icon(icon)),
        labelStyle:  TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius:  BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColor.borderColor,

          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(
            color: AppColor.borderColor,
          ),

        ),
        
      ),
      obscureText: isObscure,
    );
  }
}
