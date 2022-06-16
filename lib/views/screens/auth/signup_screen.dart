
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/dialog/app_dialog.dart';
import 'package:tiktokclone/theme/app_color.dart';
import 'package:tiktokclone/views/widgets/text_input.dart';
import 'package:tiktokclone/views/widgets/ygap.dart';

class SignupScreen extends StatefulWidget {
  
  SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  File? pickedImage;
  void pickImage(BuildContext context,ImageSource source)  async{
    final imageFile = await ImagePicker().pickImage(source: source);
  
    if(imageFile ==  null) return;
      setState(() { 
        pickedImage =  File(imageFile.path);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
                const Ygap(height: 24),
                  const Text('Tiktok Clone', style: TextStyle(fontSize: 35, color: AppColor.buttonColor, fontWeight:  FontWeight.w900),),
                  const Text('Sign Up', style: TextStyle(
                    fontSize: 25, 
                     fontWeight:  FontWeight.w700),),
                    const Ygap(height: 24),
                      Stack(
                        children: [
                                  ClipOval(
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    child: pickedImage !=  null 
                                    ? Image.file(pickedImage as File,  fit: BoxFit.cover)
                                    :   Image.network('https://www.pngitem.com/pimgs/m/150-1503945_transparent-user-png-default-user-image-png-png.png', 
                                    loadingBuilder: (context, child, progress)=> progress ==  null 
                                    ? child 
                                    :  const SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                        
                                      ),
                                    ),
                                     fit: BoxFit.cover,
                                    ),
                                  ),
                               ),      

                          Positioned(
                            right: 3,
                            bottom: -6,
                            child: IconButton(onPressed: (){
                              AppDialog.showChnageProfileOption(context, pickImage);
                            }, icon: Icon(Icons.camera_alt, color:Colors.white, size: 34,)),
                          )
                        ],
                      ),
                    const Ygap(height: 24),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      child: TextInput(
                        controller: _nameController,
                         labeltext: 'Name', 
                         icon: FontAwesomeIcons.user, 
                         isObscure: false) ,
                    ),
                    const Ygap(height: 25),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      child: TextInput(
                        controller: _phoneNumberController,
                         labeltext: 'Mobile', 
                         icon: FontAwesomeIcons.phone, 
                         isObscure: false) ,
                    ),
                    const Ygap(height: 25),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      child: TextInput(
                        controller: _emailController,
                         labeltext: 'Email', 
                         icon: FontAwesomeIcons.envelope, 
                         isObscure: false) ,
                    ),
                    const Ygap(height: 25),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 20,),
                      child: TextInput(
                        controller: _passwordController,
                         labeltext: 'Password', 
                         icon: FontAwesomeIcons.lock, 
                         isObscure: true) ,
                    ),
                                    const Ygap(height: 25),
                      Obx( ()=>

                        authcontroller.isCreating.value 
                        ? Container(
                          child: Center(
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),
                          ),
                        )
                        : Column(
                          children: [
                            InkWell(
                              onTap: (){
                                      authcontroller.register(context, _nameController.text, _phoneNumberController.text, _emailController.text, _passwordController.text, pickedImage );
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width  -40 ,
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColor.buttonColor,
                                ),
                                child: Center(child: Text('Create Account')),
                              ),
                            ),
                            const Ygap(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Text('Login to existing account')),
                              ],
                            ),
                          ],
                        ),
                      )

            ],
          ),
        ),
      ),
    );
  }
}
