

import 'package:nlpower/model/day.dart';

class Week {

  String id;
  String week_title;
  String level;
  String week;
  String date_created;
  String date_updated;
  String sort;
  List<Day> days;

  Week({
    this.id,
    this.week_title,
    this.level,
    this.week,
    this.date_created,
    this.date_updated,
    this.sort,
    this.days
  });

  factory Week.fromJson(Map<String, dynamic> json) => Week(
    id: json["id"],
    week_title: json["week_title"],
    level: json["level"],
    week: json["week"],
    date_created: json["date_created"],
    date_updated: json["date_updated"],
    sort: json["sort"],
    days: List<Day>.from(json["days"].map((x) => Day.fromJson(x)))
  );

  Map<String, dynamic> toJson()=> {
    "id": id,
    "week_title": week_title,
    "level": level,
    "week": week,
    "date_created": date_created,
    "date_updated": date_updated,
    "sort": sort,
    "days": List<dynamic>.from(days.map((e) => e.toJson()))
  };
}