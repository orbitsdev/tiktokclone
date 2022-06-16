

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/constant/firebase_constant.dart';
import 'package:tiktokclone/model/comment.dart';
import 'package:tiktokclone/model/user.dart';

class CommentController extends GetxController{
final _comments = <Comment>[].obs;
  List<Comment> get comment => _comments.value;

  String _postId = "";

   updatePostId(String id) {
    _postId = id;
    getComment();   
  }  

   getComment ()  async{
    _comments.bindStream(firestore.collection('videos').doc(_postId).collection('comments').snapshots().map((event) {
       var listofcomment = <Comment>[];
       for(var element in event.docs){
          listofcomment.add(Comment.fromSnapShot(element));
       }

       return listofcomment;
    }));
  }

  var isCommenting = false.obs;
  postComment(String commentTex, Function clearText) async{

    try{
      if(commentTex.isNotEmpty){
     
        isCommenting(true);
      DocumentSnapshot  data =  await firestore.collection('users').doc(authcontroller.user.uid).get();
      var user =  User.fromJson(data.data() as Map<String, dynamic>);
      var allvideos =  await firestore.collection('videos').doc(_postId).collection('comments').get();
      int len =  allvideos.docs.length;
      Comment comment =  Comment(
        DateTime.now(),
        username:user.name ,
        comment: commentTex,
         likes: [], profilePhoto:user.profilePhoto , uid: authcontroller.user.uid, id: 'comment$len');
        
          await firestore.collection('videos').doc(_postId).collection('comments').doc('comment$len').set(comment.toJson());
         var commentCollection = await firestore.collection('videos').doc(_postId).get();
         var commentdata  =  commentCollection.data() as Map<String, dynamic>;
          await firestore.collection('videos').doc(_postId).update({
          "commentCount": commentdata["commentCount"] + 1,
         });
         isCommenting(false);
         clearText();
    }
      }catch(e){
         isCommenting(false);
         Get.snackbar('Error', e.toString());

    }
    
  }

  likeComment(String id) async{
    var uid =  authcontroller.user.uid;
    var commentData    = await firestore.collection('videos').doc(_postId).collection('comments').doc(id).get();
    var commentDetail = commentData.data() as Map<String,dynamic>;  
    if(commentDetail['likes'].contains(uid)){
     
      print('yes');
      await firestore.collection('videos').doc(_postId).collection('comments').doc(id).update({
        "likes": FieldValue.arrayRemove([uid]) ,
      });
    }else{
      print('no');
      await  firestore.collection('videos').doc(_postId).collection('comments').doc(id).update({
        "likes": FieldValue.arrayUnion([uid]) ,
      });

    }

    }
  

}