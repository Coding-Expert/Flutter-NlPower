

class CommonDay {

  String day_id;
  String id;
  String item_title;
  String item_type;
  String media_id;
  String question_id;
  String date_created;
  String date_updated;
  String sort;
  int has_complete;
  String level;
  String day;
  String week;

  CommonDay({
    this.day_id,
    this.id,
    this.item_title,
    this.item_type,
    this.media_id,
    this.question_id,
    this.date_created,
    this.date_updated,
    this.sort,
    this.has_complete,
    this.level,
    this.day,
    this.week
  });

  factory CommonDay.fromJson(Map<String, dynamic> json)=> CommonDay(
    id: json["id"],
    day_id: json["day_id"],
    item_title: json["item_title"],
    item_type: json["item_type"],
    media_id: json["media_id"],
    question_id: json["question_id"],
    date_created: json["date_created"],
    date_updated: json["date_updated"],
    sort: json["sort"],
    has_complete: int.parse(json["has_completed"]),
    level: json["level"],
    day: json["day"],
    week: json["week"]
  );

  Map<String, dynamic> toJson()=>{
    "id": id,
    "day_id": day_id,
    "item_title": item_title,
    "item_type": item_type,
    "media_id": media_id,
    "question_id": question_id,
    "date_created": date_created,
    "date_updated": date_updated,
    "sort": sort,
    "complete": has_complete,
    "level": level,
    "week": week,
    "day": day
  };
}