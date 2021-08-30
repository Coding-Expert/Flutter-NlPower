
import 'package:flutter/material.dart';

class User {

  String firstname;
  String lastname;
  String email;
  String uid;
  String level;
  String image;
  String link;
  String username;
  String week;
  String day;

  User({
    this.firstname,
    this.lastname,
    this.email,
    this.uid,
    this.level,
    this.image,
    this.link,
    this.username,
    this.week,
    this.day
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    firstname: json["firstname"],
    lastname: json["lastname"],
    email: json["email"],
    uid: json["uid"],
    level: json["level"],
    image: json["image"],
    link: json["link"],
    username: json["username"],
    week: json["week"],
    day: json["day"],

  );

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "uid": uid,
    "level": level,
    "image": image,
    "link": link,
    "username": username,
    "week": week,
    "day": day
  };

}