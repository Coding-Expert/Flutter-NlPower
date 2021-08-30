
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nlpower/model/user.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:toast/toast.dart';

class ProfilePage extends StatefulWidget {

  final Function(String) onRefreshPage;
  ProfilePage({
    Key key,
    this.onRefreshPage
  }): super(key: key);

  ProfilePageState createState()=> ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  final FocusNode myFocusNodeFirstName = FocusNode();
  TextEditingController firstnameController = new TextEditingController();
  final FocusNode myFocusNodeLastName = FocusNode();
  TextEditingController lastnameController = new TextEditingController();
  final FocusNode myFocusNodeUserName = FocusNode();
  TextEditingController usernameController = new TextEditingController();
  final FocusNode myFocusNodeLinkedIn = FocusNode();
  TextEditingController linkedInController = new TextEditingController();
  final FocusNode myFocusNodeBio = FocusNode();
  TextEditingController bioController = new TextEditingController();

  bool isSwitched = true;
  String image_file;
  String uploaded_url;
  bool upload_loading = false;

  @override
  void initState() {
    super.initState();
    firstnameController.text = UserModule.user.firstname == null ? "" : UserModule.user.firstname;
    lastnameController.text = UserModule.user.lastname == null ? "" : UserModule.user.lastname;
    linkedInController.text = UserModule.user.link == null ? "" : UserModule.user.link;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/edit_profile.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: (){
                          displayBottomSheet(context);
                        },
                        child: UserModule.user.image != null ?
                          ClipOval(
                            child: Image.network(UserModule.user.image, width: 40, height: 40, fit: BoxFit.fill,),
                          ): 
                          ClipOval(
                            child: image_file == null ? Image.asset("assets/activate.png", width: 40, height: 40) : Image.file(new File(image_file), width: 40, height: 40, fit: BoxFit.cover,)
                          )
                      ),
                      SizedBox(width: 10),
                      Text('Update your Profile Picture', style: TextStyle(color: Colors.red))
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right:10, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Text('First Name', style: TextStyle(color: Colors.red)),
                      Container(
                        child: TextFormField(
                          focusNode: myFocusNodeFirstName,
                          controller: firstnameController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right:10, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Text('Last Name', style: TextStyle(color: Colors.red)),
                      Container(
                        child: TextFormField(
                          focusNode: myFocusNodeLastName,
                          controller: lastnameController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right:10, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Text('User Name', style: TextStyle(color: Colors.red)),
                      Container(
                        child: TextFormField(
                          focusNode: myFocusNodeUserName,
                          controller: usernameController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right:10, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Text('Linked In', style: TextStyle(color: Colors.red)),
                      Container(
                        child: TextFormField(
                          focusNode: myFocusNodeLinkedIn,
                          controller: linkedInController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right:10, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Text('Bio', style: TextStyle(color: Colors.red)),
                      Container(
                        child: TextFormField(
                          focusNode: myFocusNodeBio,
                          controller: bioController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black)
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right:10, top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Text('Public Profile', style: TextStyle(color: Colors.red)),
                      Switch(
                        value: isSwitched, 
                        onChanged: (value){
                          setState(() {
                            isSwitched = value;                            
                          });
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.blue,
                      )
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(left: 10, right:10, top: 5, bottom: 5),
                  color: Colors.blue,
                  child: FlatButton(
                    onPressed: (){
                      onUpdateUser();
                    }, 
                    child: Text('SAVE', style: TextStyle(color: Colors.white))
                  )
                ),
              )
            ],
          ),
        )
    )
    );
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

  void onUpdateUser() {
    if(image_file != UserModule.user.image){
      onUploadUserImage(UserModule.user.uid, new File(image_file));
    }
    else{
      User update_user = new User(
        firstname: firstnameController.text,
        lastname: lastnameController.text,
        link: linkedInController.text,
        email: UserModule.user.email,
        uid: UserModule.user.uid,
        level: UserModule.user.level,
        image: UserModule.user.image,
      );
      UserModule.updateUser(update_user).then((value) {
        if(value == "success"){
          Toast.show("user profile have updated successfully", context);
          widget.onRefreshPage.call(value);
        }
      });
    }
  }

  Future<void> onUploadUserImage(String imageId, File imageFile){
    String extension = image_file.substring(image_file.length - 3, image_file.length);
    StorageReference ref = FirebaseStorage.instance.ref().child(imageId).child(DateTime.now().toString() + "." + extension);
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    setState(() {
      upload_loading = true;
      uploadTask.onComplete.then((snapshot){
        snapshot.ref.getDownloadURL().then((url) {
          if(url != null){
            uploaded_url = url;
            User update_user = new User(
              firstname: firstnameController.text,
              lastname: lastnameController.text,
              link: linkedInController.text,
              email: UserModule.user.email,
              uid: UserModule.user.uid,
              level: UserModule.user.level,
              image: uploaded_url,
            );
            UserModule.updateUser(update_user).then((value) {
              if(value == "success"){
                Toast.show("user profile have updated successfully", context);
                widget.onRefreshPage.call(value);
              }
            });
          }
        });
      });
    });
  }
  
}