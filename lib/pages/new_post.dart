
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nlpower/model/category.dart';
import 'package:nlpower/model/post.dart';
import 'package:nlpower/module/post_module.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:toast/toast.dart';


class NewPostPage extends StatefulWidget {

  final String groupId;
  final Category category;
  final Function(String) onRefreshPage;

  NewPostPage({
    Key key,
    this.groupId,
    this.category,
    this.onRefreshPage
  }) : super(key: key);

  NewPostPageState createState()=> NewPostPageState();
  
}

class NewPostPageState extends State<NewPostPage> {

  final FocusNode myFocusNodePost = FocusNode();
  TextEditingController postController = new TextEditingController();
  String image_file; 
  String uploaded_url;
  bool post_loading = false;

  @override
  void initState() {
    super.initState();
    
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${UserModule.user.firstname} ${UserModule.user.lastname} ' + widget.category.title, style:TextStyle(color: Colors.black, fontSize: 18)),
            Text('Posting publicly to ' + widget.category.title,style:TextStyle(color: Colors.black, fontSize: 14))
          ],
        ),
        leading: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10),
              child: UserModule.user.image == null ?
              CircleAvatar(
                  child: Image.asset('images/user.png',fit: BoxFit.fill,),
                  radius: 20,
              ): 
              ClipOval(
                child: Image.network(UserModule.user.image, width: 40, height: 40, fit: BoxFit.fill)
              ),
            )
          ]
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.cancel, color: Colors.black, ), 
            onPressed: (){
              Navigator.pop(context);
            }
          )
        ],
      ),
      body: post_loading == false ?
        postWidget()
        : loadingWidget()
    );
  }

  Widget loadingWidget(){
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/edit_profile.jpg"),
          fit: BoxFit.cover
        )
      ),
      child: Center(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      child: TextField(
                        focusNode: myFocusNodePost,
                        controller: postController,
                        keyboardType: TextInputType.multiline,
                        style: TextStyle(fontFamily: "WorkSansSemiBold",fontSize: 16.0,color: Colors.black),
                        decoration: InputDecoration(
                          hintText: 'input post data',
                        ),
                        maxLines: 8,
                      )
                    ),
                    image_file != null ?
                      Container(
                        padding: const EdgeInsets.only(top: 28.0, bottom: 16.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 120,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(new File(image_file)),
                              fit: BoxFit.cover
                            ),
                          ),
                        )
                      ): Container(),
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.picture_in_picture_rounded, color: Colors.blue),
                          onPressed: (){
                            displayBottomSheet(context);
                          }
                        ),
                        Container(
                          width: 250,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xffc0c7d0),
                            borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                          child: FlatButton(
                            onPressed: (){
                              onPostData();
                              
                            },
                            child: Text("Post", style:TextStyle(color: Colors.white, fontSize: 18)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ),
            Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          ],
        ),
      )
    );
  }

  Widget postWidget() {
    return Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/edit_profile.jpg"),
                fit: BoxFit.cover
              )
            ),
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: TextField(
                    focusNode: myFocusNodePost,
                    controller: postController,
                    keyboardType: TextInputType.multiline,
                    style: TextStyle(fontFamily: "WorkSansSemiBold",fontSize: 16.0,color: Colors.black),
                    decoration: InputDecoration(
                      hintText: 'input post data',
                    ),
                    maxLines: 8,
                  )
                ),
                image_file != null ?
                  Container(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 16.0),
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(new File(image_file)),
                          fit: BoxFit.contain
                        ),
                      ),
                    )
                  ): Container(
                    padding: const EdgeInsets.only(top: 28.0, bottom: 16.0),
                  ),
                Container(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.picture_in_picture_rounded, color: Colors.blue),
                        onPressed: (){
                          displayBottomSheet(context);
                        }
                      ),
                      Container(
                        width: 300,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Color(0xffc0c7d0),
                          borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                        child: FlatButton(
                          onPressed: (){
                            onPostData();
                            
                          },
                          child: Text("Post", style:TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          )
        ),
      );
  }

  void onPostData(){
    if(image_file != null){
      onUploadUserImage(UserModule.user.uid, new File(image_file));
    }
    else{
      setState(() {
        post_loading = true;
        onPost();  
      });
      
    }
    
  }
  Future<void> onUploadUserImage(String imageId, File imageFile){
    String extension = image_file.substring(image_file.length - 3, image_file.length);
    StorageReference ref = FirebaseStorage.instance.ref().child(imageId).child(DateTime.now().toString() + "." + extension);
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    setState(() {
      post_loading = true;
      uploadTask.onComplete.then((snapshot){
        snapshot.ref.getDownloadURL().then((url) {
          if(url != null){
            uploaded_url = url;
            onPost();
          }
        });
      });
    });
  }
  void onPost(){
    List<String> post_comments = [];
    List<String> post_likes = [];
    Post new_post = Post(
      description: postController.text,
      userId: UserModule.user.uid,
      groupId: widget.groupId,
      categoryId: widget.category.id,
      comments: post_comments,
      likes: post_likes,
      imageUrl: uploaded_url,
      
    );
    PostModule.savePost(new_post).then((value){
      if(value == "success"){
        setState(() {
          post_loading = false;
          Toast.show("Data was posted successfully", context); 
          widget.onRefreshPage.call(value);  
          Navigator.pop(context);
        });
      }
    });
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (ctx) {
        return Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: Platform.isAndroid ? MediaQuery.of(context).size.width  * 0.4 : MediaQuery.of(context).size.width * 0.5,
          child: Column(
            children: [
              new ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text('Προσθήκη Αρχείου'),
                onTap: () {
                  getImageFromGallery();
                  Navigator.of(context).pop();
                }
              ),
              new ListTile(
                leading: new Icon(Icons.photo_camera),
                title: new Text('Κάμερα'),
                onTap: () {
                  getImageFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        );
      }
    );
  }

  Future<void> getImageFromGallery() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((file) {
      setState(() {
        image_file = file.path;
      });
    });
  }
  Future<void> getImageFromCamera() async {
    await ImagePicker.pickImage(source: ImageSource.camera).then((file) {
      setState(() {
        image_file = file.path;
      });
    });
    
    
  }
  
}