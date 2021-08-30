

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nlpower/model/category.dart';
import 'package:nlpower/model/post.dart';
import 'package:nlpower/model/user.dart';
import 'package:nlpower/module/post_module.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:nlpower/widget/post_widget.dart';

class FollowingWidget extends StatefulWidget{

  FollowingWidgetState createState()=> FollowingWidgetState();
}

class FollowingWidgetState extends State<FollowingWidget> {

  bool loading = false;
  List<Post> post_list = [];
  List<User> user_list = [];
  Category category;

  @override
  void initState() {
    super.initState();
    category = Category(
      level: "Explore",
      title: "Κοινότητα"
    );
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
    await PostModule.getPostList(UserModule.user.uid, "dmRffkSKFcXhetyRDLbW").then((list) {
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
    return loading == false ?
    Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Container(
          //   width: MediaQuery.of(context).size.width,
          //   padding: EdgeInsets.all(10.0),
          //   color: Colors.white,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.start,
          //     children: [
          //       CircleAvatar(
          //         child: Image.asset('assets/activate.png',fit: BoxFit.fill,),
          //       ),
          //       SizedBox(width: 5.0,),
          //       Container(
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children:[
          //             Text('Effie Kyriakaki > Cybernetics', style:TextStyle(color: Colors.black, fontSize: 16)),
          //             Text('63 seconds ago', style:TextStyle(color: Colors.black, fontSize: 16))
          //           ]
                    
          //         )
                  
          //       )
          //     ],
          //   )
          // ),
          // Container(
          //   color: Colors.white,
          //   padding: EdgeInsets.all(5.0),
          //   child: Text(
          //     'THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS ORIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THEAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHE LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS INTHE SOFTWARE.',
          //     maxLines: 5,
          //   ),
          // ),
          // Container(
          //   color: Colors.white,
          //   width: double.infinity,
          //   padding: EdgeInsets.all(5.0),
          //   child: Text('Read More...', style:TextStyle(color: Colors.blue, fontSize: 18)),
          // )
          for (var post in post_list)
            PostWidget(
              category:  category,
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
        
      )
    ) : Center(
      child: CircularProgressIndicator()
    );
  }
  
}