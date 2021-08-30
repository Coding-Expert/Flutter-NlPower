

import 'package:flutter/material.dart';
import 'package:nlpower/model/comment.dart';
import 'package:nlpower/model/post.dart';
import 'package:nlpower/model/user.dart';
import 'package:nlpower/module/post_module.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:toast/toast.dart';

class CommentWidget extends StatefulWidget {
  
  final Comment comment;
  final Post post;
  final Function(String) onRefreshPage;
  final String description;
  final List<User> users;
  CommentWidget({
    Key key,
    this.comment,
    this.post,
    this.onRefreshPage,
    this.description,
    this.users
  }): super(key: key);

  CommentWidgetState createState ()=> CommentWidgetState();
}

class CommentWidgetState extends State<CommentWidget> {

  String comment_date;
  bool like_status = false;
  User comment_user;
  List<Comment> child_commentList = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    if(widget.comment.likes.contains(UserModule.user.uid)){
        like_status = true;
    }
    for(int i = 0; i < widget.users.length; i++){
      if(widget.comment.userId == widget.users[i].uid) {
        comment_user = widget.users[i];
        break;
      }
    }
    if(comment_user.image == null){
      comment_user.image = "";
    }
    getCommentDate();
    getChildCommentList();
  }

  Future<void> getChildCommentList() async {
    child_commentList = [];
    loading = true;
    await PostModule.getChildCommentForComment(widget.post.postId, widget.comment.commentId).then((list){
      child_commentList = list;
      setState(() {
        loading = false;        
      });
    });
  }
  void getCommentDate(){
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime.utc(now.year, now.month, now.day, now.hour, now.minute);
    List<String> date_time = widget.comment.date.split(" at ");
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
      comment_date = different.toString() + " minutes ago";
    }
    if(different > 60 && different < 24 * 60){
      comment_date = (different ~/ 60).toString() + " hours ago";
    }
    if(different > 24 * 60){
      comment_date = (different ~/ (24 * 60)).toString() + " days ago";
    }
      
  }
  @override
  Widget build(BuildContext context) {
    return loading == false ?
    Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      padding: EdgeInsets.only(left: 10),
      child: Column(
        children:[
          Row(
            children: [
              comment_user.image == null ?
              CircleAvatar(
                child: Image.asset('assets/activate.png',fit: BoxFit.fill,),
              ): 
              ClipOval(
                child: Image.network(comment_user.image, fit: BoxFit.fill, width: 40, height: 40)
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[
                      // Text(widget.comment.description, style:TextStyle(color: Colors.black, fontSize: 16), maxLines: 4,),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: "${comment_user.firstname} ${comment_user.lastname} ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
                            TextSpan(text: widget.comment.description, style:TextStyle(color: Colors.black,))
                          ]
                        )
                      ),
                      Row(
                        children: [
                          Text(comment_date, style: TextStyle(color: Colors.black)),
                          SizedBox(width: 5.0),
                          widget.comment.likes.length > 0 ?
                          Text(widget.comment.likes.length.toString() + " likes", style: TextStyle(color: Colors.black)) : Container(),
                          SizedBox(width: 5.0),
                          GestureDetector(
                            onTap: () {
                              onCommentforComment();
                            },
                            child: Text("Reply", style: TextStyle(color: Colors.blue))
                          ),
                          SizedBox(width: 10.0),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.black),
                            onPressed: (){
                              onDeleteComment();
                            },
                          ),
                        ],
                      )
                    ]
                  )
                  
                )
              ),
              IconButton(
                icon: Icon(like_status == false ? Icons.favorite_border_outlined : Icons.favorite, color: like_status == false ? Colors.black : Colors.red),
                onPressed: (){
                  onUpdateLikeforComment();
                },
              ),
            ],
          ),
          Container(
            child: Column(
              children: [
                for (var child_comment in child_commentList)
                  CommentWidget(
                    comment: child_comment,
                    post: widget.post,
                    users: widget.users,
                    description: widget.description,
                    onRefreshPage: (String result){
                      if(result == "success"){
                        setState(() {
                          getChildCommentList();                
                        });
                      }
                    },
                  ),
              ],
            )
          )
          
        ]
      )
    ): CircularProgressIndicator();
  }

  void onUpdateCommentForPost() {
    if(widget.description.isEmpty || widget.description == ""){
      Toast.show("please input comment content", context);
      return;
    }
    widget.post.comments.add(UserModule.user.uid);
    PostModule.updateCommentForPost(widget.post, widget.description).then((value){
      if(value == "success"){
        widget.onRefreshPage.call(value);
      }
    });
  }
  void onUpdateLikeforComment(){
    if(widget.comment.likes.contains(UserModule.user.uid)){
      widget.comment.likes.remove(UserModule.user.uid);
    }
    else{
      widget.comment.likes.add(UserModule.user.uid);
    }
    PostModule.updateLikeForComment(widget.comment).then((value){
      // widget.onRefreshPage.call(value);
      setState(() {
        if(widget.comment.likes.contains(UserModule.user.uid)){
          like_status = true;
        }
        else{
          like_status = false;
        }
      });
    });
  }

  void onCommentforComment() {
    if(widget.description.isEmpty || widget.description == ""){
      Toast.show("please input comment content", context);
      return;
    }
    
    PostModule.saveCommentForComment(widget.post.postId, widget.description, widget.comment.commentId).then((value){
      if(value == "success"){
        setState(() {
          getChildCommentList();
        });
      }
    });
  }

  void onDeleteComment() {
    PostModule.deleteComment(widget.post, widget.comment).then((result){
      if(result == "success"){
        if(widget.comment.parentId != null){
          widget.onRefreshPage.call(result);
        }
        else{
          widget.onRefreshPage.call(result);
        }
      }
    });
  }
  
}