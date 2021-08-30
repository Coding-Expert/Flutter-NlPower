import 'package:flutter/material.dart';
import 'dart:async';
import 'package:nlpower/login.dart';
import 'package:nlpower/model/user.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:nlpower/pages/home.dart';
import 'package:nlpower/service/database_service.dart';
import 'package:nlpower/service/firebase_service.dart';

class SplashScreen extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<Timer> loadData() async {
    return new Timer(Duration(seconds: 5), getCurrentUserState);
  }

  getCurrentUserState() async {
    await FirebaseService.auth.getCurrentUser().then((user) {
      if (user != null && user.isEmailVerified) {
        DatabaseService.initFirebase();
        UserModule.initUser(user.uid).then((value) {
          if (value == "success") {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => new HomePage()));
          } else {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => new LoginPage()));
          }
        });
      } else {
        Navigator.of(context).pushReplacement(new MaterialPageRoute(
            builder: (BuildContext context) => new LoginPage()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/splash.gif'), fit: BoxFit.cover),
      ),
    );
  }
}
