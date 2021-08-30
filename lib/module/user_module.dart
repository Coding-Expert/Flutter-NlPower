import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nlpower/model/user.dart';
import 'package:nlpower/service/database_service.dart';
import 'package:http/http.dart' as http;

class UserModule {
  static User user;
  static List<User> user_list = [];

  static Future<String> initUser(String uid) async {
    String result = "failed";
    var body = jsonEncode({
      "key":
          "-vaudSGntDBhFM^+M!67EE2FwytZDKPrrxXFq?@B+wqbGtHMRZV-LDeq%AnQ9pD4vdTF7QYUgbp?ZbGy*^gAuKrC-q9#qguAJP",
      "code": "w0QuizqqjtTfd1EAhdr8CePRqzz1"
    });
    var response = await http.post(
      Uri.parse("https://app.metamathesis.edu.gr/bridge/get_user"),
      headers: {"Content-Type": "application/json"},
      body: body,
    );
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      String level = res["level"];
      String week = res["week"];
      String day = res["day"];
      await DatabaseService.firestoreUserCollection
          .getDocuments()
          .then((QuerySnapshot snapshot) {
        snapshot.documents.asMap().forEach((index, data) {
          if (uid == snapshot.documents[index]["uid"]) {
            user = User(
                firstname: snapshot.documents[index]["firstname"],
                lastname: snapshot.documents[index]["lastname"],
                email: snapshot.documents[index]["email"],
                level: level, //snapshot.documents[index]["level"],
                image: snapshot.documents[index]["image"],
                link: snapshot.documents[index]["link"],
                uid: snapshot.documents[index]["uid"],
                week: week,
                day: day);
            result = "success";
          }
        });
      });
    }
    return result;
  }

  static Future<List<User>> getAllUsers() async {
    user_list = [];
    await DatabaseService.firestoreUserCollection
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.asMap().forEach((index, data) {
        User common_user = User(
            firstname: snapshot.documents[index]["firstname"],
            lastname: snapshot.documents[index]["lastname"],
            email: snapshot.documents[index]["email"],
            level: snapshot.documents[index]["level"],
            image: snapshot.documents[index]["image"],
            link: snapshot.documents[index]["link"],
            uid: snapshot.documents[index]["uid"]);
        user_list.add(common_user);
      });
    });
    return user_list;
  }

  static Future<String> saveUser(
      String firstname, String lastname, String email, String uid) async {
    String response = "";
    await DatabaseService.firestoreUserCollection.document(uid).setData({
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "level": "",
      "uid": uid,
      "image": null,
      "link": ""
    }).then((value) {
      response = "success";
    });
    return response;
  }

  static Future<String> updateUser(User update_user) async {
    String response = "";
    await DatabaseService.firestoreUserCollection
        .document(update_user.uid)
        .setData({
      "firstname": update_user.firstname,
      "lastname": update_user.lastname,
      "email": update_user.email,
      "level": update_user.level,
      "uid": update_user.uid,
      "image": update_user.image,
      "link": update_user.link
    }).then((value) {
      user = null;
      user = User(
          firstname: update_user.firstname,
          lastname: update_user.lastname,
          email: update_user.email,
          level: update_user.level,
          uid: update_user.uid,
          image: update_user.image,
          link: update_user.link);
      response = "success";
    });
    return response;
  }
}
