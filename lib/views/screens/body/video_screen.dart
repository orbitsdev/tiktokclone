import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/controller/video_controller.dart';
import 'package:tiktokclone/theme/app_color.dart';
import 'package:tiktokclone/views/screens/body/comment_screen.dart';
import 'package:tiktokclone/views/widgets/build_music_album.dart';
import 'package:tiktokclone/views/widgets/circle_animation.dart';
import 'package:tiktokclone/views/widgets/profile_photo.dart';
import 'package:tiktokclone/views/widgets/video_player_item.dart';

class VideoScreen extends StatelessWidget {
   VideoScreen({Key? key}) : super(key: key);
  final VideoController videoController = Get.put(VideoController());
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(() =>

          PageView.builder(
            itemCount:  videocontroller.videoList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            final data = videocontroller.videoList[index];
            return Stack(
            children: [
              VideoPlayerItem(videoUrl:data.videoUrl),
              Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.only(
                              left: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  data.username,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  data.caption,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.music_note,
                                      size: 15,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      data.songname,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,

                          margin: EdgeInsets.only(top: size.height / 5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ProfilePhoto(
                                  profilephoto: data.profilePhoto),
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        videocontroller.likeVideo(data.id);
                                      },
                                      child:  Icon(
                                        Icons.favorite,
                                        color: data.likes.contains(authcontroller.user.uid) ? Colors.red:  Colors.white,
                                        size: 40,
                                      )),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(data.likes.length.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () {
                                        Get.to(()=> CommentScreen(id: data.id));
                                      },
                                      child: const Icon(
                                        Icons.comment,
                                        color: Colors.white,
                                        size: 40,
                                      )),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(data.commentCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              Column(
                                children: [
                                  InkWell(
                                      onTap: () {},
                                      // ignore: prefer_const_constructors
                                      child: Icon(
                                        Icons.reply,
                                        color:Colors.white,
                                        size: 40,
                                      )),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(data.shareCount.toString(),
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              CircleAnimation(child:  BuildMusicAlbum(profilephoto: data.profilePhoto)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              
            ],
          );
          } 
        ),
      ),
    );
  }
}
