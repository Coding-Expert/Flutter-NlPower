import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nlpower/RoundedChiseledBorder.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:nlpower/pages/home.dart';
import 'package:nlpower/service/database_service.dart';
import 'package:nlpower/service/firebase_service.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  // Auth auth = new Auth();

  bool login_flag = true;
  PageController _pageController;
  final FocusNode myFocusNodeEmail = FocusNode();
  TextEditingController emailController = new TextEditingController();
  final FocusNode myFocusNodeFirstName = FocusNode();
  TextEditingController firstNameController = new TextEditingController();
  final FocusNode myFocusNodeLastName = FocusNode();
  TextEditingController lastNameController = new TextEditingController();
  final FocusNode myFocusNodePassword = FocusNode();
  TextEditingController passwordController = new TextEditingController();
  final FocusNode myFocusNodeRegisterEmail = FocusNode();
  TextEditingController registeremailController = new TextEditingController();
  final FocusNode myFocusNodeRegisterPassword = FocusNode();
  TextEditingController registerpasswordController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    // getCurrentUserState();
  }

  Future<void> getCurrentUserState() async {
    await FirebaseService.auth.getCurrentUser().then((user) {
      if (user != null) {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new HomePage()));
      }
    });
  }

  @override
  void dispose() {
    myFocusNodeEmail.dispose();
    myFocusNodePassword.dispose();
    _pageController.dispose();
    myFocusNodeRegisterEmail.dispose();
    myFocusNodeRegisterPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/background.jpeg"),
                    fit: BoxFit.cover)),
            child: SingleChildScrollView(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(padding: EdgeInsets.only(top: 10)),
                        Container(
                            width: MediaQuery.of(context).size.height * 0.18,
                            height: MediaQuery.of(context).size.height * 0.18,
                            child: Image.asset(
                              "assets/brain.png",
                              fit: BoxFit.fill,
                            )),
                        Container(
                            child: Text(
                                "Neuro" + "\n" + "Learning" + "\n" + "Power",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold))),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Container(
                            child: Text("WELCOME",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 30))),
                        Padding(padding: EdgeInsets.only(top: 40)),
                        Container(
                            child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white)),
                              ),
                            ),
                            Expanded(
                                child: Row(
                              children: [
                                RoundedChiseledBorder(
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  bottomBorderColor: login_flag == true
                                      ? Colors.transparent
                                      : Colors.white,
                                  leftBorderColor: login_flag == true
                                      ? Colors.white
                                      : Colors.transparent,
                                  rightBorderColor: login_flag == true
                                      ? Colors.white
                                      : Colors.transparent,
                                  topBorderColor: login_flag == true
                                      ? Colors.white
                                      : Colors.transparent,
                                  child: Container(
                                      height: 40,
                                      padding: EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            login_flag = true;
                                            _pageController.animateToPage(
                                              0,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeInOut,
                                            );
                                          });
                                        },
                                        child: new Align(
                                            alignment: Alignment.center,
                                            child: Text('LOGIN',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16))),
                                      )),
                                ),
                                Expanded(
                                    child: Container(
                                  height: 40,
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.white)),
                                  ),
                                )),
                                RoundedChiseledBorder(
                                  borderRadius: 10,
                                  borderWidth: 1,
                                  bottomBorderColor: login_flag == true
                                      ? Colors.white
                                      : Colors.transparent,
                                  leftBorderColor: login_flag == true
                                      ? Colors.transparent
                                      : Colors.white,
                                  rightBorderColor: login_flag == true
                                      ? Colors.transparent
                                      : Colors.white,
                                  topBorderColor: login_flag == true
                                      ? Colors.transparent
                                      : Colors.white,
                                  child: Container(
                                      height: 40,
                                      padding: EdgeInsets.all(8.0),
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            login_flag = false;
                                            _pageController.animateToPage(
                                              1,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeInOut,
                                            );
                                          });
                                        },
                                        child: new Align(
                                            alignment: Alignment.center,
                                            child: Text('SIGN UP',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16))),
                                      )),
                                ),
                              ],
                            )),
                            Container(
                              height: 40,
                              width: 100,
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.white)),
                              ),
                            )
                          ],
                        )),
                        Padding(padding: EdgeInsets.only(top: 20)),
                        Container(
                            child: Expanded(
                                child: Container(
                                    // height: MediaQuery.of(context).size.height * 0.4,
                                    child: PageView(
                          controller: _pageController,
                          // physics: new NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            LoginWidget(context),
                            RegisterWidget(context),
                          ],
                        )))),
                      ],
                    )))));
  }

  Widget LoginWidget(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              focusNode: myFocusNodeEmail,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
              ),
            )),
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              focusNode: myFocusNodePassword,
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
              ),
            )),
        Padding(padding: EdgeInsets.only(top: 40)),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  onLogIn();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                      ),
                      left: BorderSide(
                        color: Colors.white,
                      ),
                      top: BorderSide(
                        color: Colors.white,
                      ),
                      right: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: new Align(
                      alignment: Alignment.center,
                      child: Text('LOGIN',
                          style: TextStyle(color: Colors.white, fontSize: 16))),
                ),
              )
            ],
          ),
        ),
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    forgotPassword(emailController.text);
                  },
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0)),
                    ),
                    child: Text('Forgot Password?',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Container(
                  height: 15,
                  child: VerticalDivider(color: Colors.white),
                ),
                SizedBox(
                  width: 5.0,
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    padding: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1.0)),
                    ),
                    child: Text('HELP', style: TextStyle(color: Colors.white)),
                  ),
                )
              ],
            ))
      ],
    ));
  }

  Widget RegisterWidget(BuildContext context) {
    return SingleChildScrollView(
        child: Container(
            child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              focusNode: myFocusNodeFirstName,
              controller: firstNameController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                hintText: "FirstName",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
              ),
            )),
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              focusNode: myFocusNodeLastName,
              controller: lastNameController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                hintText: "LastName",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
              ),
            )),
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              focusNode: myFocusNodeRegisterEmail,
              controller: registeremailController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
              ),
            )),
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: TextFormField(
              focusNode: myFocusNodeRegisterPassword,
              controller: registerpasswordController,
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                  fontFamily: "WorkSansSemiBold",
                  fontSize: 16.0,
                  color: Colors.white),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
                hintText: "Password",
                hintStyle: TextStyle(color: Colors.white),
                focusedBorder: UnderlineInputBorder(
                    borderSide: new BorderSide(color: Colors.white)),
              ),
            )),
        Padding(padding: EdgeInsets.only(top: 20)),
        Container(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () {
                  onSignUp();
                },
                child: Container(
                  width: 100,
                  height: 40,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                      ),
                      left: BorderSide(
                        color: Colors.white,
                      ),
                      top: BorderSide(
                        color: Colors.white,
                      ),
                      right: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  child: new Align(
                      alignment: Alignment.center,
                      child: Text('SIGN UP',
                          style: TextStyle(color: Colors.white, fontSize: 16))),
                ),
              )
            ],
          ),
        ),
      ],
    )));
  }

  onSignUp() async {
    if (firstNameController.text == null || firstNameController.text.isEmpty) {
      Toast.show("please input firstname", context);
      return;
    }
    if (lastNameController.text == null || lastNameController.text.isEmpty) {
      Toast.show("please input lastname", context);
      return;
    }
    if (registeremailController.text == null ||
        registeremailController.text.isEmpty) {
      Toast.show("please input email", context);
      return;
    }
    if (registerpasswordController.text == null ||
        registerpasswordController.text.isEmpty) {
      Toast.show("please input password", context);
      return;
    }

    FirebaseUser user;
    try {
      user = await FirebaseService.auth.signUp(
          registeremailController.text, registerpasswordController.text);
      if (user != null) {
        print('Signed up user: ${user.uid}');
        Toast.show("Account registered successfully!", context);
        DatabaseService.initFirebase();
        UserModule.saveUser(firstNameController.text, lastNameController.text,
                registeremailController.text, user.uid)
            .then((value) {
          if (value == "success") {
            print("---register_result:${value}");
            user.sendEmailVerification();
          }
        });
      }
    } catch (e) {
      // print('Error: $e');
      Toast.show("${e}", context);
    }
  }

  void onLogIn() async {
    FirebaseUser user;
    String error_message = "";
    if (emailController.text == null || emailController.text.isEmpty) {
      Toast.show("please input email", context);
      return;
    }
    if (passwordController.text == null || passwordController.text.isEmpty) {
      Toast.show("please input password", context);
      return;
    }
    try {
      user = await FirebaseService.auth
          .signIn(emailController.text, passwordController.text);
      if (user == null) {
        Toast.show("please register account", context);
      }
      if (!user.isEmailVerified) {
        Toast.show(
            "please open link in your email for account activating ", context);
      } else {
        DatabaseService.initFirebase();
        UserModule.initUser(user.uid).then((value) {
          if (value == "success") {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => new HomePage()));
          }
        });
      }
    } catch (e) {
      print("----Error:${e}");
      String error_result = e.toString().split(",")[0];
      if (error_result == "PlatformException(ERROR_WRONG_PASSWORD") {
        Toast.show("password is invalid", context);
      }
      if (error_result == "PlatformException(ERROR_USER_NOT_FOUND") {
        Toast.show("email is invalid", context);
      }
    }
  }

  Future<void> forgotPassword(String email) async {
    await FirebaseService.auth.forgotPassword(email);
    Toast.show("please check email", context);
  }
}
