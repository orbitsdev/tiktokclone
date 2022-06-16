import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/search_controller.dart';
import 'package:tiktokclone/model/user.dart';
import 'package:tiktokclone/views/screens/body/profile_screen.dart';

class SearchScreen extends StatelessWidget {
 SearchScreen({ Key? key }) : super(key: key);

var searchcontroller =  Get.put(SearchController());

  @override
  Widget build(BuildContext context){
    return Obx(() =>
       Scaffold(
        
        appBar: AppBar(
          backgroundColor: Colors.red,
          title:TextFormField(
            onChanged: (value){
              searchcontroller.clearSearch(value);
            },
          onFieldSubmitted: (value) => searchcontroller.searchUser(value),
          decoration: InputDecoration(
          filled: false,
          hintText: 'Search',
          hintStyle: TextStyle(fontSize: 18, color:  Colors.white)
          ),
        ),
          centerTitle: true,
        ),
        body:searchcontroller.searchUsers.isEmpty 
        ? Center(
          child: Text("Search", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold))
        ) 
        : ListView.builder(
          itemCount: searchcontroller.searchUsers.length,
          itemBuilder: (context,index){
            User user = searchcontroller.searchUsers[index];
    
          return InkWell(
            onTap: (){
              Get.to(()=> ProfileScreen(uid: user.uid));
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(user.profilePhoto),
    
              ),
              title: Text(user.name, style: TextStyle(color: Colors.white, fontSize: 18),),
            ),
          ); 
        })
      ),
    );
  }
}