
import 'package:get/get.dart';
import 'package:tiktokclone/constant/firebase_constant.dart';
import 'package:tiktokclone/model/user.dart';

class SearchController  extends GetxController {
  var _searchUsers = <User>[].obs;

  List<User>get searchUsers => _searchUsers.value;

   searchUser(String typeuser) async {
  
    _searchUsers.bindStream(firestore.collection('users').where('name', isGreaterThanOrEqualTo: typeuser).snapshots().map((event) {
      var userlist = <User>[];
      print(userlist);
      for(var element in event.docs){
        userlist.add(User.fromJson(element.data() as Map<String, dynamic>));
      }
      return userlist;
    }));
  }

  clearSearch(String comment){

    if(comment.isEmpty){
    _searchUsers.clear();

    }
  }



}