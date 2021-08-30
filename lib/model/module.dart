import 'package:nlpower/model/media.dart';

class Module {
  String module_title;
  String description;
  String total_time;
  String level;
  String sort;
  Media media;

  Module({
    this.module_title,
    this.description,
    this.total_time,
    this.level,
    this.sort,
    this.media,
  });

  factory Module.fromJson(Map<String, dynamic> json) => Module(
        module_title: json['module_title'],
        description: json['description'],
        total_time: json['total_time'],
        level: json['level'],
        sort: json['sort'],
        media: Media.fromJson(json['media']),
      );

  Map<String, dynamic> toJson() => {
        "module_title": this.module_title,
        "description": this.description,
        "total_time": this.total_time,
        "level": this.level,
        "sort": this.sort,
        "media": this.media,
      };
}
