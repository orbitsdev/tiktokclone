import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/constant/firebase_constant.dart';
import 'package:tiktokclone/dialog/app_dialog.dart';
import 'package:tiktokclone/model/user.dart' as model;
import 'package:tiktokclone/model/video.dart';
import 'package:tiktokclone/views/screens/auth/confirm_screen.dart';

class UploadVideoController extends GetxController {
  static UploadVideoController instance = Get.find();


  void pickVideo(BuildContext context, ImageSource source) async{
    final video  =  await ImagePicker().pickVideo(source: source);
    
    if(video !=  null){
        Get.to(()=> ConfirmScreen(videoFile: File(video.path), videoPath: video.path));
        
    } 
  }

  String? thumbnailpath;
  void pickThumbnail (BuildContext context) async{
      final pickedthumbnail = await FilePicker.platform.pickFiles(allowMultiple: false, type:  FileType.image);
      if(pickedthumbnail == null) return;
      final path =  pickedthumbnail.files.single.path;
      final name =  pickedthumbnail.files.single.name;
      thumbnailpath = path;

  }

 
  Future<String>_uploadVideoToStorage(String id, String videoPath) async {
      ///get the refference of storage the location where you will store the video if not then it will auotamitically create it 
       // it will look like this to the database videos/video1
        final ref =  firebaseStorage.ref().child("videos/$id");

        //prepaire file
        UploadTask uploadTask =  ref.putFile(File(videoPath));
      //upload file
        TaskSnapshot  snap = await uploadTask;
        //get url
        String videoDownloadedUrl =  await snap.ref.getDownloadURL();
        return videoDownloadedUrl;
  }


   _uploadThumbnailToStorage(String id, String thumbnailpath) async{
        //id sang thumbnail /thumbnais/id
        final ref =  firebaseStorage.ref().child("thumbnails/$id");
        UploadTask thumbnailtask =  ref.putFile(File(thumbnailpath));
        TaskSnapshot snap = await thumbnailtask;
        String thumbnailDownloadedurl =  await snap.ref.getDownloadURL();
        return thumbnailDownloadedurl;

    }

  var isUploading = false.obs;
  void uploadVideo(BuildContext context, String songname, String caption, String videoPath)  async {

  
      try{

        if(thumbnailpath != null){
           isUploading(true);
        var userdata =  await userrefference.doc(uid).get();
        var user = model.User.fromJson(userdata.data() as Map<String, dynamic>);
      

        // get id this code will fetch all data as list then the lenth of list will be the id of the uploaded video just like 1 2 3 4 5
        var alldocFromVideo = await videofference.get();
        int length =  alldocFromVideo.docs.length;
       

        String id="Video$length";
        final String videoUrl  = await _uploadVideoToStorage(id, videoPath);   
        final String thumbnail  = await _uploadThumbnailToStorage(id, thumbnailpath!);   
   
        

         Video video = Video(username: user.name, uid: firebaseauth.currentUser!.uid, id: id, likes: [], commentCount: 0, shareCount: 0, songname: songname, videoUrl: videoUrl, thumbnail: thumbnail, profilePhoto: user.profilePhoto ,caption: caption);
         await videofference.doc(id).set(video.toJson());
        isUploading(false);
        Get.back();
        }else{
             AppDialog.showError(context, 'Please Select thumbnail first');
        }
       
       
      }catch(e){
        isUploading(false);
        AppDialog.showError(context, e.toString());
      }
  }
}
