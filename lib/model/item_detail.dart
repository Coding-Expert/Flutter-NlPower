

class ItemDetail {

  String id;
  String category_id;
  String title;
  String descr;
  String photo;
  String media;
  String filetype;
  String duration;
  String date_created;
  String date_updated;
  String sort;
  String day_item_id;
  String question_title;

  ItemDetail({
    this.id,
    this.category_id,
    this.title,
    this.descr,
    this.photo,
    this.media,
    this.filetype,
    this.duration,
    this.date_created,
    this.date_updated,
    this.sort,
    this.question_title,
    this.day_item_id
  });

  factory ItemDetail.fromJson(Map<String, dynamic> json)=> ItemDetail(
    id: json["id"],
    category_id: json["category_id"],
    title: json["title"],
    descr: json["descr"],
    photo: json["photo"],
    media: json["media"],
    filetype: json["filetype"],
    duration: json["duration"],
    date_created: json["date_created"],
    date_updated: json["date_updated"],
    sort: json["sort"],
    question_title: json["question_title"],
    day_item_id: json["day_item_id"]
  );

  Map<String, dynamic> toJson()=> {
    "id": id,
    "category_id": category_id,
    "title": title,
    "descr": descr,
    "photo": photo,
    "media": media,
    "filetype": filetype,
    "duration": duration,
    "date_created": date_created,
    "date_updated": date_updated,
    "sort": sort,
    "question_title": question_title,
    "day_item_id": day_item_id
  };
}