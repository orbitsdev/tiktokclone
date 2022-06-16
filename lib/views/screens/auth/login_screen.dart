import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/controller_constant.dart';
import 'package:tiktokclone/theme/app_color.dart';
import 'package:tiktokclone/views/screens/auth/signup_screen.dart';
import 'package:tiktokclone/views/widgets/text_input.dart';
import 'package:tiktokclone/views/widgets/ygap.dart';

class LoginScreen extends StatelessWidget {
LoginScreen({ Key? key }) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                      
                   Ygap(height: MediaQuery.of(context).size.height * 0.050),
                    const Text('Tiktok Clone', style: TextStyle(fontSize: 35, color: AppColor.buttonColor, fontWeight:  FontWeight.w900),),
                    const Ygap(height: 8),
                     const Text('1.0.1', style: TextStyle(
                    fontSize: 25, 
                     fontWeight:  FontWeight.w700),),
                    const Ygap(height: 34),
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
        const Ygap(height: 24),
                        Obx(()=> 
                          authcontroller.isLoginining.isTrue 
                          ?  const SizedBox(
                                      height: 34,
                                      width: 34,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                        
                                      ),
                                    )
                          : Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  authcontroller.loginUser(context, _emailController.text, _passwordController.text);
                                },
                                child: Container(
                                  height: 50,
                                  decoration: const BoxDecoration(
                                    color: AppColor.buttonColor,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                  ),
                                  width: MediaQuery.of(context).size.width - 40,
                                  margin:  const EdgeInsets.symmetric(horizontal: 20),
                                  child: const Center(child: Text('Login')),
                                ),
                              ),
                              const Ygap(height:20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Get.to(()=>  SignupScreen(), transition:  Transition.rightToLeft);
                                    },
                                    child: Text('Create account')),
                                ],
                              ),
                            ],
                          ),
                        )
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}