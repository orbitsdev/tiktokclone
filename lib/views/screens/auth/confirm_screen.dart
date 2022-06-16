import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/controller/upload_video_controller.dart';
import 'package:tiktokclone/views/widgets/text_input.dart';
import 'package:tiktokclone/views/widgets/ygap.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
final File videoFile;
final String videoPath;

  const ConfirmScreen({
    Key? key,
    required this.videoFile,
    required this.videoPath,
  }) : super(key: key);
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
 
  late VideoPlayerController controller;
  TextEditingController songController = TextEditingController();
  TextEditingController captionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    setState(() {
      controller =  VideoPlayerController.file(widget.videoFile);
    });

    controller.initialize();
    controller.play();
    controller.setVolume(1);
    controller.setLooping(true);
  }

    File? thumbnailFile;
     void pickThumbnail (BuildContext context) async{
      final pickedthumbnail = await FilePicker.platform.pickFiles(allowMultiple: false, type:  FileType.image);
      if(pickedthumbnail == null) return;
      final path =  pickedthumbnail.files.single.path;
      final name =  pickedthumbnail.files.single.name;
      
      //set path
      uploadcontroller.thumbnailpath = path;
      //display selected patj
      setState(() {
        thumbnailFile =  File(path!);
      });

  }

  @override
  void dispose() {
    uploadcontroller.dispose();
    super.dispose();
  }
 
  @override
  Widget build(BuildContext context){
    return Scaffold(
      
      body:SingleChildScrollView(
        child: Column(
          children: [
                 SizedBox(width: MediaQuery.of(context).size.width, height: MediaQuery.of(context).size.height / 1.7, child: VideoPlayer(controller),),
                
                SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        Ygap(height: 30),
                        Container(
                          width: MediaQuery.of(context).size.width -20,
                          margin: EdgeInsets.symmetric(horizontal: 10,),
                          child: TextInput(controller:  songController , labeltext: 'Song Name', icon: Icons.music_note, isObscure: false),
                        ),
                        Ygap(height: 10),
                         Container(
                          width: MediaQuery.of(context).size.width -20,
                          margin: EdgeInsets.symmetric(horizontal: 10,),
                          child: TextInput(controller: captionController  , labeltext: 'Caption Name', icon: Icons.closed_caption, isObscure: false),
                        ),
                           thumbnailFile != null 
                           ? Container(
                          height: 120,
                          width: 120,
                          child:  Image.file(thumbnailFile as File, fit: BoxFit.cover,)
                        ) : Text('No selected thumbnail'),
                        ElevatedButton(onPressed: (){
                          pickThumbnail(context);
                        }, child:Text('Upload thumbnail')),
                        Ygap(height: 10),
                        Obx(()=> uploadcontroller.isUploading.isTrue 
                        ? const SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                        
                                      ),
                                    )  
                        :   ElevatedButton(onPressed: (){
                
                              uploadcontroller.uploadVideo(context, songController.text, captionController.text, widget.videoPath);
                        
                          }, child: Text('Share', style: TextStyle(fontSize: 20, color: Colors.white),)),
                        )
                      ],
                    ),
                ),
      
          ],
        ),
      )
    );
  }
}