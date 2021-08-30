
class Category {

  String level;
  String title;
  List<String> groupId_list;
  String id;

  Category({
    this.level,
    this.title,
    this.groupId_list,
    this.id
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    level: json["level"] == null ? "" : json["level"],
    title: json["title"] == null ? "" : json["title"],
    groupId_list: json["groupId"] == null ? null : json["groupId"],
    id: json["id"] == null ? null : json["id"]
  );

  Map<String, dynamic> toJson()=> {
    "level" : level,
    "title": title,
    "groupIdList": groupId_list
  };
}