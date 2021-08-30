

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nlpower/model/category.dart';
import 'package:nlpower/model/comment.dart';
import 'package:nlpower/model/post.dart';
import 'package:nlpower/model/user.dart';
import 'package:nlpower/module/post_module.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:nlpower/pages/new_post.dart';
import 'package:nlpower/widget/comment_widget.dart';
import 'package:toast/toast.dart';

class PostWidget extends StatefulWidget {

  final Category category;
  final String groupId;
  final Post post;
  final List<User> users;
  final Function(String) onRefreshPage;
  PostWidget({
    Key key,
    this.category,
    this.groupId,
    this.post,
    this.users,
    this.onRefreshPage
  }): super(key: key);

  PostWidgetState createState()=> PostWidgetState();
}

class PostWidgetState extends State<PostWidget> {

  String firstHalf;
  String secondHalf;
  bool flag = true;
  String post_date = "";
  bool user_like = false;
  bool comment_flag = false;
  final FocusNode myFocusNodeComment = FocusNode();
  TextEditingController commentController = new TextEditingController();
  List<Comment> comment_list = [];
  User post_user;
  

  @override 
  void initState() {
    super.initState();
    if(widget.post.description.length > 50){
      firstHalf = widget.post.description.substring(0, 50);
      secondHalf = widget.post.description.substring(50, widget.post.description.length);
    }
    else{
      firstHalf = widget.post.description;
      secondHalf = "";
    }
    for(int i = 0; i < widget.users.length; i++){
      if(widget.users[i].uid == widget.post.userId){
        post_user = widget.users[i];
        break;
      }
    }
    if(post_user.image == null){
      post_user.image = "";
    }
    
    getLikeCommentStatus();
    getPostDate();
    getCommentList();
  }

  

  void getLikeCommentStatus() {
    if(widget.post.likes.contains(UserModule.user.uid)){
      user_like = true;
    }
    else{
      user_like = false;
    }
    
  }
  Future<void> getCommentList() async {
    await PostModule.getCommentList(widget.post.postId).then((list){
      comment_list = [];
      if(list.length > 0){
        for(int i = 0; i < list.length; i++) {
          comment_list.add(list[i]);
        }
        if(Platform.isIOS){
          comment_list..sort((item1, item2) => item1.date.compareTo(item2.date));
        }  
        else{
          comment_list..sort((item1, item2) => item2.date.compareTo(item1.date));
        }
      }
    });
  }

  void getPostDate(){
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime.utc(now.year, now.month, now.day, now.hour, now.minute);
    List<String> date_time = widget.post.createdDate.split(" at ");
    String date = date_time[0]; 
    String time = date_time[1];
    List<String> date_array = date.split("-");
    List<String> time_array = time.split(":");
    int post_year = int.parse(date_array[0]);
    int post_month = int.parse(date_array[1]);
    int post_day = int.parse(date_array[2]);
    int post_hour = int.parse(time_array[0]);
    int post_minutes = int.parse(time_array[1]);
    DateTime post_dateTime = DateTime.utc(post_year, post_month, post_day, post_hour, post_minutes);
    int different = currentDate.difference(post_dateTime).inMinutes;
    if(different < 60){
      if(different < 0){
        different = 0;
      }
      post_date = different.toString() + " minutes ago";
    }
    if(different > 60 && different < 24 * 60){
      post_date = (different ~/ 60).toString() + " hours ago";
    }
    if(different > 24 * 60){
      post_date = (different ~/ (24 * 60)).toString() + " days ago";
    }
      
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10.0),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                post_user.image == "" ?
                CircleAvatar(
                  child: Image.asset('assets/activate.png',fit: BoxFit.fill,),
                ): 
                ClipOval(
                  child: Image.network(post_user.image, fit: BoxFit.fill, width: 40, height: 40,),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("${post_user.firstname} ${post_user.lastname} > ${widget.category.title}", style:TextStyle(color: Colors.black, fontSize: 16)),
                        Text(post_date, style:TextStyle(color: Colors.black, fontSize: 16))
                      ]
                    )
                    
                  )
                ),
                IconButton(
                  icon: Icon(Icons.more_vert, color: Colors.grey),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostPage(
                      groupId: widget.groupId,
                    )));
                  },
                ),
                
              ],
            )
          ),
          Container(
            color: Colors.white,
            width: double.infinity,
            padding: EdgeInsets.all(5.0),
            child: Text(
              flag ? firstHalf : firstHalf + secondHalf,
              
            ),
          ),
          flag == false && widget.post.imageUrl != null ?
            Container(
              width: double.infinity,
                child: Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(widget.post.imageUrl),
                        fit: BoxFit.fill
                    ),
                  ),
                )
          ): Container(),
          GestureDetector(
            onTap: (){
              setState(() {
                flag = !flag;                
              });
            },
            child: Container(
              color: Colors.white,
              width: double.infinity,
              padding: EdgeInsets.all(5.0),
              child: Text(flag ? 'read more' : 'less', style:TextStyle(color: Colors.blue, fontSize: 18)),
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: Icon(user_like == true ? Icons.favorite : Icons.favorite_border_outlined, color: user_like == true ? Colors.red : Colors.black),
                  onPressed: (){
                    if(user_like){
                      widget.post.likes.remove(UserModule.user.uid);
                    }
                    else{
                      widget.post.likes.add(UserModule.user.uid);
                    }
                    onUpdateLikeForPost();
                  },
                ),
                widget.post.likes.length > 0 ?
                Text(widget.post.likes.length.toString(), style:TextStyle(color: Colors.black)) : Container(),
                IconButton(
                  icon: Icon(Icons.chat_bubble_outline_outlined, color: Colors.black),
                  onPressed: (){
                    setState(() {
                      comment_flag = !comment_flag;
                    });
                    // widget.post.comments.add(UserModule.user.uid);
                    // onPostUpdate();
                  },
                ),
                widget.post.comments.length > 0 ?
                Text(widget.post.comments.length.toString(), style:TextStyle(color: Colors.black)) : Container(),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.black),
                  onPressed: (){
                    onDeletePost();
                  },
                ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          comment_flag == true ? 
            widget.post.comments.length < 1 ?
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          focusNode: myFocusNodeComment,
                          controller: commentController,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(fontFamily: "WorkSansSemiBold",fontSize: 16.0,color: Colors.black),
                          decoration: InputDecoration(
                            hintText: 'Add a comment',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide(width: 1.0)
                            )
                          ),
                        )
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_upward_outlined, color: Colors.black),
                      onPressed: (){
                        onUpdateCommentForPost();
                      },
                    ),
                  ],
                )
              ) : Container(
                child: Column(
                  children: [
                    for (var comment in comment_list)
                      CommentWidget(
                        comment: comment,
                        post: widget.post,
                        users: widget.users,
                        description: commentController.text,
                        onRefreshPage: (String result){
                          if(result == "success"){
                            setState(() {
                              comment_flag = false;
                              getLikeCommentStatus();
                              getCommentList();                         
                            });
                            
                          }
                        },
                      ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                                focusNode: myFocusNodeComment,
                                controller: commentController,
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(fontFamily: "WorkSansSemiBold",fontSize: 16.0,color: Colors.black),
                                decoration: InputDecoration(
                                  hintText: 'Add a comment',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                    borderSide: BorderSide(width: 1.0)
                                  )
                                ),
                              )
                          ),
                          IconButton(
                            icon: Icon(Icons.arrow_upward_outlined, color: Colors.black),
                            onPressed: (){
                              onUpdateCommentForPost();
                            },
                          ),
                        ],
                      )
                    )
                  ],
                )
              )
            : Container(),
            SizedBox(
              height: 10
            )
        ],
        
      )
    );
  }

  void onUpdateLikeForPost() {
    PostModule.updateLikeForPost(widget.post).then((value){
      if(value == "success"){
        setState(() {
          getLikeCommentStatus();
        });
      }
    });
  }

  void onUpdateCommentForPost() {
    if(commentController.text.isEmpty || commentController.text == ""){
      Toast.show("please input comment content", context);
      return;
    }
    widget.post.comments.add(UserModule.user.uid);
    PostModule.updateCommentForPost(widget.post, commentController.text).then((value){
      if(value == "success"){
        setState(() {
          comment_flag = false;
          getLikeCommentStatus();
          getCommentList();
        });
      }
    });
  }

  void onDeletePost() {
    PostModule.deletePost(widget.post).then((value){
      widget.onRefreshPage.call(value);
    });
  }
  
}