import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/controller/auth_controller.dart';
import 'package:tiktokclone/routes/app_name.dart';
import 'package:tiktokclone/theme/app_color.dart';
import 'package:tiktokclone/views/screens/auth/login_screen.dart';
import 'package:tiktokclone/views/screens/auth/signup_screen.dart';
import 'package:tiktokclone/views/screens/body/home_screen.dart';
import 'package:tiktokclone/views/screens/body/video_screen.dart';

void main()  async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });
  runApp(const TiktokClone());
}

class TiktokClone extends StatefulWidget {
  const TiktokClone({ Key? key }) : super(key: key);

  @override
  _TiktokCloneState createState() => _TiktokCloneState();
}

class _TiktokCloneState extends State<TiktokClone> {
  @override
  Widget build(BuildContext context) {

      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor:  AppColor.backGround,
        ),
        home: VideoScreen(),
        getPages: [
          GetPage(name: AppName.login, page: ()=> LoginScreen()),
          GetPage(name: AppName.signup, page: ()=> SignupScreen()),
          GetPage(name: AppName.home, page: ()=> HomeScreen()),
        ],

      );

  }
}