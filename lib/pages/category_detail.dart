

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nlpower/model/category.dart';
import 'package:nlpower/model/post.dart';
import 'package:nlpower/model/user.dart';
import 'package:nlpower/module/post_module.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:nlpower/pages/new_post.dart';
import 'package:nlpower/widget/post_widget.dart';

class CategoryDetailPage extends StatefulWidget {

  final Category category;
  final String groupId;
  CategoryDetailPage({
    Key key,
    this.category,
    this.groupId
  }): super(key: key);
  
  CategoryDetailPageState createState()=> CategoryDetailPageState();
}

class CategoryDetailPageState extends State<CategoryDetailPage>{

  bool loading = false;
  List<Post> post_list = [];
  List<User> user_list = [];
  

  @override
  void initState(){
    super.initState();
    
    getPostList();
    getUserList();
  }
  Future<void> getUserList() async {
    user_list = [];
    await UserModule.getAllUsers().then((list){
      if(list.length > 0){
        user_list = list;
      }
    });
  }
  Future<void> getPostList() async {
    post_list = [];
    loading = true;
    await PostModule.getPostList(UserModule.user.uid, widget.category.id).then((list) {
      setState(() {
        for(int i = 0; i < list.length; i++){
          post_list.add(list[i]);
        }
        if(Platform.isIOS){
          post_list..sort((item1, item2) => item1.createdDate.compareTo(item2.createdDate));
        }  
        else{
          post_list..sort((item1, item2) => item2.createdDate.compareTo(item1.createdDate));
        }
        
        loading = false;      
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: new BoxDecoration(
            gradient: new RadialGradient(
              radius: MediaQuery.of(context).size.width / 50,
              colors: [
                Color.fromRGBO(89, 0, 224, 1),
                Color.fromRGBO(109, 42, 128, 1),
              ],
            ),
          ),
        ),
        title: Text(widget.category.title, style:TextStyle(color: Colors.white, fontSize: 18)),
      ),
      body: loading == false ? 
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          // color: Color(0xfff4f5f7),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/edit_profile.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border(bottom: BorderSide(color: Color(0xffdbf9ea), width: 5.0)),
                              ),
                              child: Text(widget.category.title, style:TextStyle(color: Colors.black, fontSize: 22)),
                            ),
                            IconButton(
                              icon: Icon(Icons.notifications_active, color: Colors.grey), 
                              onPressed: (){}
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10.0),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircleAvatar(
                              child: Image.asset('assets/activate.png',fit: BoxFit.fill,),
                            ),
                            SizedBox(width: 5.0,),
                            Expanded(
                              child: Container(
                                child: Text('Post to ' + widget.category.title, style:TextStyle(color: Colors.black, fontSize: 16))
                              )
                            ),
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => NewPostPage(
                                  groupId: widget.groupId,
                                  category: widget.category,
                                  onRefreshPage: (result){
                                    if(result == "success"){
                                      setState(() {
                                        getPostList();                                 
                                      });
                                    }
                                  }
                                )));
                              },
                            ),
                          ],
                        )
                      ),
                      SizedBox(height: 20),
                      for (var post in post_list)
                        PostWidget(
                          category:  widget.category,
                          groupId: widget.groupId,
                          post: post,
                          users: user_list,
                          onRefreshPage: (String result){
                            if(result == "success"){
                              setState(() {
                                getPostList();              
                              });
                            }
                          },
                        ),
                      
                    ],
                  ),
                )
              ),
              SliverFillRemaining(
                child: Container(),
              ),
            ],
          ),
        ): Center(
          child: CircularProgressIndicator()
        )
    );
  }
  
}