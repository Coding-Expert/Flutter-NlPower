import 'package:nlpower/model/mediafile.dart';

class Media {
  String title;
  String description;
  String total_time;
  String sort;
  List<MediaFile> files;

  Media({
    this.title,
    this.description,
    this.total_time,
    this.sort,
    this.files,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        title: json['title'],
        description: json['description'],
        total_time: json['total_time'],
        sort: json['sort'],
        files: json['files'] != null
            ? List<MediaFile>.from(
                json['files'].map((item) => MediaFile.fromJson(item)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "total_time": total_time,
        "sort": sort,
        "files": List<dynamic>.from(files.map((e) => e.toJson())),
      };
}
