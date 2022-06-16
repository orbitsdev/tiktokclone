import 'package:get/get.dart';
import 'package:tiktokclone/controller/upload_video_controller.dart';
import 'package:tiktokclone/controller/video_controller.dart';

class AppController {


static void initializeAllController(){
  Get.put(UploadVideoController());
  Get.put(VideoController());
}

}