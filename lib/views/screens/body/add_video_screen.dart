
import 'package:flutter/material.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/dialog/app_dialog.dart';
import 'package:tiktokclone/theme/app_color.dart';

class AddVideoScreen extends StatelessWidget {
const AddVideoScreen({ Key? key }) : super(key: key);


  @override
  Widget build(BuildContext context){
    return Center(
      child: InkWell(
        onTap: (){
          AppDialog.showOptionDilaog(context, uploadcontroller.pickVideo);
        },
        child: Container(
          width: 190,
          height: 50,
          decoration: const BoxDecoration(
            color: AppColor.buttonColor,
          ),
          child: const Center(
            child: Text('Add Video', style: TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.bold
            ),),
          ),
          
        ),
      ),
    );
  }
}