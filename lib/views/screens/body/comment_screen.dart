import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktokclone/constant/controller_constant.dart';

import 'package:tiktokclone/controller/comment_controller.dart';
import 'package:timeago/timeago.dart';

class CommentScreen extends StatelessWidget {
    final String id;
   CommentScreen({
    Key? key,
    required this.id,
  }) : super(key: key);
  
    final TextEditingController _commentController=  TextEditingController(); 
  CommentController commentController =  CommentController();


  void clearText(){
    _commentController.clear();
  }
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    commentController.updatePostId(id);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            child: Obx(()=>
               Column(
                children: [
                  Container(
                    color: Colors.amber,
                    child: Text(id, style: TextStyle(color: Colors.white, fontSize: 20),)),
                  Expanded(
                    child: 
                     ListView.builder(
                        itemCount: commentController.comment.length,
                        itemBuilder: (context, index) {
                          var comment =  commentController.comment[index];
                          
                          return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.black,
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Row(
                            children: [
                              Text(comment.username,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold)),
                                      SizedBox(width: 6,),
                             
                            ],
                            
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 3,
                              ),
                               Text('${comment.comment}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500)),
                                      SizedBox(
                                        height: 6,
                                      ),
                              Row(
                                children: [
                                  Text(format(comment.datePublished.toDate()), style: TextStyle(fontSize: 12, color: Colors.white)),
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Text('${comment.likes.length} likes', style: TextStyle(fontSize: 12, color: Colors.white)),
                    
                                ],
                                
                              ),
                            ],
                          ),
                          trailing: IconButton(onPressed: (){
                            commentController.likeComment(comment.id);
                          }, icon:  Icon(Icons.favorite, size: 25, color: comment.likes.contains(authcontroller.user.uid) ? Colors.red:  Colors.white,)),
                        );
                        }
                      ),
                    ),
                
                  Divider(
                
                  ),
                  ListTile(
                    title: TextFormField(
                      controller: _commentController,
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                        
                      ),
                      decoration: InputDecoration(
                        labelText: 'Comment',
                        labelStyle: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w700),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:  BorderSide(color: Colors.red)
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red
                          )
                        )
                      ),
                      
                
                      
                    ), 
                    trailing: TextButton(onPressed: (){
                        commentController.postComment(_commentController.text ,clearText);
                
                    }, child: commentController.isCommenting.isTrue ? SizedBox( height: 16, width: 16, child:  CircularProgressIndicator(color: Colors.white, strokeWidth: 2,),) :  Text('Send', style: TextStyle(color: Colors.white, fontSize: 16) ,)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
