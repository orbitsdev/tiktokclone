import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:tiktokclone/constant/firebase_constant.dart';
import 'package:tiktokclone/controller/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  ProfileScreen({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var profilecontroller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    profilecontroller.updateUserId(widget.uid);
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black12,
                leading: Icon(Icons.person_add_alt_1_outlined),
                title:  Text(
                  controller.user['name']??'',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                actions: [
                  Icon(
                    Icons.more_horiz,
                  ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                    height: size.height,
                    width: size.width,
                    child: Column(
                      children: [
                       controller.user['profilePhoto']==null 
                       ? SizedBox(
                              width: 90,
                              height: 90,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                       
                       : ClipOval(
                          child: CachedNetworkImage(
                            imageUrl:  controller.user['profilePhoto'],
                            fit: BoxFit.cover,
                            height: 90,
                            width: 90,
                            placeholder: (context, url) => SizedBox(
                              width: 100,
                              height: 100,
                              child: CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            ),
                            errorWidget: (context, url, error) => Icon(
                              Icons.error,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              children: [
                                Text(
                                  controller.user['following']??'',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Following',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.user['followers']??'',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Followers',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              children: [
                                Text(
                                  controller.user['likes']??'',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Likes',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Container(
                          width: 140,
                          height: 47,
                          child: InkWell(
                            onTap: () {
                              if(     widget.uid == authcontroller.user.uid){
                                firebaseauth.signOut();

                              }else{

                                controller.followUser();
                              }

                            },
                            child: Center(
                              child: Text(
                                widget.uid == authcontroller.user.uid
                                 ? 'Sign out'
                                 : controller.user['isFollowing']
                                        ? 'Unfollow'
                                        : 'Follow'
                                ,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    )),
              ),
            ));
  }
}
