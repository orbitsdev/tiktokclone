import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/constant/firebase_constant.dart';
import 'package:tiktokclone/dialog/app_dialog.dart';
import 'package:tiktokclone/model/user.dart' as model;
import 'package:tiktokclone/routes/app_name.dart';
import 'package:tiktokclone/views/screens/auth/login_screen.dart';
import 'package:tiktokclone/views/screens/body/comment_screen.dart';
import 'package:tiktokclone/views/screens/body/home_screen.dart';
import 'package:tiktokclone/views/screens/body/video_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  late Rx<File> _pickedImage;

  File? get profilePhoto => _pickedImage.value;
  User get user=> _user.value!;
  var isCreating = false.obs;
  var isLoginining = false.obs;


  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseauth.currentUser);
    _user.bindStream(firebaseauth.authStateChanges());
    ever(_user, _setInitialScreen);
  }
  
  void _setInitialScreen(User? user) {
      if(user ==  null){
        Get.offAll(()=>LoginScreen());
      }else{
        Get.offAll(()=> HomeScreen());

      }
  }

  File? _storeImage;
  File? get storeimage => _storeImage;
  var imagpathh = ''.obs;
  
  void pickImage(BuildContext context, ImageSource imagesource) async {
    final imageFile = await ImagePicker().pickImage(source: imagesource, maxWidth: 600);
    if(imageFile == null) return;
    _storeImage = File(imageFile.path);
      



  }




  Future<String> _uploadImage(File image) async {
    //this mean the location will be videos/useruid/videofile
    profilestoragerefference.child(firebaseauth.currentUser!.uid);
    UploadTask uploadtaks = profilestoragerefference.putFile(image);
    TaskSnapshot snap = await uploadtaks;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  void loginUser(BuildContext context, String email, String password) async {
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
          isLoginining(true);
        await firebaseauth.signInWithEmailAndPassword(email: email, password: password);
          isLoginining(false);
          Get.offNamedUntil(AppName.home, (route) => false);

      }else{
          isLoginining(false);
                 AppDialog.showError(context, 'Error Creating account Check all fields');
      }
    } on FirebaseAuthException catch (e) {
          isLoginining(false);
        AppDialog.showError(context,e.message.toString());
    }
  }

  void register(BuildContext context, String name, String phonenumber,
      String email, String password, File? image) async {
    try {
      if (name.isNotEmpty &&
          phonenumber.isNotEmpty &&
          email.isNotEmpty &&
          password.isNotEmpty &&
          image != null) {
        isCreating(true);
        UserCredential cred = await firebaseauth.createUserWithEmailAndPassword(
            email: email, password: password);
        String profilePhoto = await _uploadImage(image);
        model.User user = model.User(
            uid: cred.user!.uid,
            name: name,
            phonenumber: phonenumber,
            email: email,
            profilePhoto: profilePhoto);
        await firestore.collection('users').doc(user.uid).set(user.toJson());

        isCreating(false);
      } else {
        isCreating(false);
        AppDialog.showError(context, 'Error Creating account Check all fields');
      }
    } catch (e) {
      isCreating(false);
      AppDialog.showError(context, e.toString());
    }
  }
}
