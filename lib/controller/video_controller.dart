import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/constant/firebase_constant.dart';
import 'package:tiktokclone/model/video.dart';

class VideoController extends GetxController{

  static VideoController instance =  Get.find();

  var _videoList = <Video>[].obs;
  List<Video> get videoList => _videoList.value;


  @override
  void onInit() {
    super.onInit();
    _videoList.bindStream(firestore.collection('videos').snapshots().map((QuerySnapshot query) {
      var reval = <Video>[];
      
      for(var element in query.docs){
        reval.add(Video.fromJson(element.data() as Map<String, dynamic>));
      } 
      return reval;
    }));
  }

  void likeVideo(String id) async{
    
    var data =  await firestore.collection('videos').doc(id).get();
    var uid = authcontroller.user.uid;
    var video = data.data() as Map<String, dynamic>;

    if(video['likes'].contains(uid)){
      await firestore.collection('videos').doc(id).update({  
        "likes": FieldValue.arrayRemove([uid])
      });
      print('yes');
    }else{
      print('no');
       await firestore.collection('videos').doc(id).update({
        "likes": FieldValue.arrayUnion([uid])
      }); 
    }
  }

}