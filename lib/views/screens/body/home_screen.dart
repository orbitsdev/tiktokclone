import 'package:flutter/material.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/controller/app_controller.dart';
import 'package:tiktokclone/views/screens/body/add_video_screen.dart';
import 'package:tiktokclone/views/screens/body/home.dart';
import 'package:tiktokclone/views/screens/body/message.dart';
import 'package:tiktokclone/views/screens/body/profile.dart';
import 'package:tiktokclone/views/screens/body/profile_screen.dart';
import 'package:tiktokclone/views/screens/body/search.dart';
import 'package:tiktokclone/views/screens/body/search_screen.dart';
import 'package:tiktokclone/views/screens/body/video_screen.dart';
import 'package:tiktokclone/views/widgets/customI_icon.dart';

class HomeScreen extends StatefulWidget {
const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    AppController.initializeAllController();
  }

  int _pageIndex = 0;
  List _pages =  [ 
     VideoScreen(),
     SearchScreen(),
     const AddVideoScreen(),
     Message(),
    ProfileScreen(uid: authcontroller.user.uid)
  ];

  @override
  Widget build(BuildContext context){
      return Scaffold(

      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index){
          setState(() {
            _pageIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        currentIndex: _pageIndex,
        items:  [
         
        BottomNavigationBarItem(icon: Icon(Icons.home, size: 30,), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.search, size: 30,), label: 'Search'),
        BottomNavigationBarItem(icon: CustomIIcon(), label: ''),
        BottomNavigationBarItem(icon: Icon(Icons.message, size: 30,), label: 'Message'),
        BottomNavigationBarItem(icon: Icon(Icons.person, size: 30,), label: 'Profile'),
      
      ]),
    );
  }
}