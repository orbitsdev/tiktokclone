import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/views/widgets/option_listtile.dart';

class AppDialog {

  static void showOptionDilaog(BuildContext context , Function pickVideo) => showDialog(context: context, builder: (context)=> SimpleDialog(
    children: [
      SimpleDialogOption(
        onPressed: () {
        Get.back();
        pickVideo(context, ImageSource.camera);

        },
        child:Row(
          children: [
            Icon(Icons.camera_alt),
            Padding(padding: EdgeInsets.all(7.0),
            child: const Text('Camera', style: TextStyle(fontSize: 20) ,),
            ),

          ],
        ),
      ),
      SimpleDialogOption(
        onPressed: (){
          Get.back();
        pickVideo(context, ImageSource.gallery);
        },
        child:Row(
          children: [
            Icon(Icons.image),
            Padding(padding: EdgeInsets.all(7.0),
            child: const Text('Gallery', style: TextStyle(fontSize: 20) ,),
            ),

          ],
        ),
      ),
    ],
  ));

  static void showError(BuildContext context, String message) {
     showDialog(
              context: context,
              builder: (BuildContext context){
                  return AlertDialog(
                    content: Text(message),
                  );
              }
            );
  }
  static void showChnageProfileOption(
      BuildContext context, Function pickimage) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.back();
                  pickimage(context, ImageSource.camera);
                },
                child: OptionListtile(
                    title: 'Take a Photo', icon: FontAwesomeIcons.camera),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.back();
                  pickimage(context, ImageSource.gallery);
                },
                child: OptionListtile(
                    title: 'Upload Photo', icon: FontAwesomeIcons.image),
              ),
            ),
          ],
        ),
      ),
    );
  }


}

