import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/constant/firebase_constant.dart';
import 'package:tiktokclone/model/user.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  var _uid = "".obs;

  updateUserId(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    var thumbnaoil = <String>[];
    var videoCollection = await firestore
        .collection('videos')
        .where('uid', isEqualTo: _uid.value)
        .get();
    for (int i = 0; i < videoCollection.docs.length; i++) {
      thumbnaoil.add((videoCollection.docs[i].data() as dynamic)['thumbnail']);
    }

    DocumentSnapshot userdata =
        await firestore.collection('users').doc(_uid.value).get();
    var data = userdata.data()! as Map<String, dynamic>;
    User theuser = User.fromJson(data);
    String name = theuser.name;
    String profilePhoto = theuser.profilePhoto;
    int likes = 0;
    int follower = 0;
    int following = 0;

    bool isFollowing = false;

    for (var item in videoCollection.docs) {
      likes += (item.data()['likes'] as List).length;
    }

    var followerdocs = await firestore
        .collection('user')
        .doc(_uid.value)
        .collection('followers')
        .get();
    var followingdoc = await firestore
        .collection('user')
        .doc(_uid.value)
        .collection('following')
        .get();

    follower = followerdocs.docs.length;
    following = followingdoc.docs.length;

    firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followeing')
        .doc(authcontroller.user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        isFollowing = true;
      } else {
        isFollowing = false;
      }
    });

    _user.value = {
      'followers': follower.toString(),
      'following': following.toString(),
      'isFollowing': isFollowing,
      'likes': likes.toString(),
      'profilePhoto': profilePhoto,
      'name': name,
      'thumbnail': thumbnaoil,
    };

    update();
  }

  followUser() async {
    var doc = await firestore
        .collection('users')
        .doc(_uid.value)
        .collection('followers')
        .doc(authcontroller.user.uid)
        .get();

    if (!doc.exists) {
      print('you can folw');
      await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authcontroller.user.uid)
          .set({});
      await firestore
          .collection('users')
          .doc(authcontroller.user.uid)
          .collection('following')
          .doc(_uid.value)
          .set({});
      _user.value.update('followers', (value) => (int.parse(value) + 1).toString());
    } else {
      print('unfollow');
       await firestore
          .collection('users')
          .doc(_uid.value)
          .collection('followers')
          .doc(authcontroller.user.uid)
          .delete();
      await firestore
          .collection('users')
          .doc(authcontroller.user.uid)
          .collection('following')
          .doc(_uid.value)
          .delete();
            _user.value.update('followers', (value) => (int.parse(value) - 1).toString());
    }

   _user.value.update('isFollowing', (value) => !value);
   update();
    // update();
  }
}
