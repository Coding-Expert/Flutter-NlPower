
import 'package:nlpower/model/group.dart';

class Day {

  String id;
  String week_id;
  String day;
  String day_title;
  String date_created;
  String date_updated;
  String sort;
  List<Group> groups;

  Day({
    this.id,
    this.week_id,
    this.day,
    this.day_title,
    this.date_created,
    this.date_updated,
    this.sort,
    this.groups
  });

  factory Day.fromJson(Map<String, dynamic> json)=> Day(
    id: json["id"],
    week_id: json["week_id"],
    day: json["day"],
    day_title: json["day_title"],
    date_created: json["date_created"],
    date_updated: json["date_updated"],
    sort: json["sort"],
    groups: List<Group>.from(json["groups"].map((x)=> Group.fromJson(x)))
  );

  Map<String, dynamic> toJson()=> {
    "id": id,
    "week_id": week_id,
    "day": day,
    "day_title": day_title,
    "date_created": date_created,
    "date_updated": date_updated,
    "sort": sort,
    "groups": List<dynamic>.from(groups.map((e) => e.toJson()))
  };
}