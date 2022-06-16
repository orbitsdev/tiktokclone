import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/firebase_constant.dart';
import 'package:tiktokclone/views/screens/auth/login_screen.dart';

class Profile extends StatelessWidget {
const Profile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      child:Center(
        child: ElevatedButton(onPressed: (){

            firebaseauth.signOut();
            Get.offAll(()=>  LoginScreen());
            
        }, child: Text('Logout')),
      ),
    );
  }
}