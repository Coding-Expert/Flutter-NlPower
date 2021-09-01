

import 'package:nlpower/model/item_detail.dart';

class Group{

  String day_id;
  String id;
  String item_title;
  String item_type;
  String media_id;
  String question_id;
  String date_created;
  String date_updated;
  String sort;
  List<ItemDetail> item_details;

  Group({
    this.day_id,
    this.id,
    this.item_title,
    this.item_type,
    this.media_id,
    this.question_id,
    this.date_created,
    this.date_updated,
    this.sort,
    this.item_details
  });

  factory Group.fromJson(Map<String, dynamic> json)=> Group(
    id: json["id"],
    day_id: json["day_id"],
    item_title: json["item_title"],
    item_type: json["item_type"],
    media_id: json["media_id"],
    question_id: json["question_id"],
    date_created: json["date_created"],
    date_updated: json["date_updated"],
    sort: json["sort"],
    item_details: List<ItemDetail>.from(json["item_details"].map((x) => ItemDetail.fromJson(x)))
  );

  Map<String, dynamic> toJson()=> {
    "id": id,
    "day_id": day_id,
    "item_title": item_title,
    "item_type": item_type,
    "media_id": media_id,
    "question_id": question_id,
    "date_created": date_created,
    "date_updated": date_updated,
    "sort": sort,
    "item_details": List<dynamic>.from(item_details.map((e) => e.toJson()))
  };
}