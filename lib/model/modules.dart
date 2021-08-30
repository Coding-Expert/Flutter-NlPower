import 'module.dart';

class Modules {
  String oauth_uid;
  int level;
  int week;
  List<Module> modules;

  Modules({
    this.oauth_uid,
    this.level,
    this.week,
    this.modules,
  });

  factory Modules.fromJson(Map<String, dynamic> json) => Modules(
        oauth_uid: json['oauth_uid'],
        level: json['level'],
        week: json['week'],
        modules: json['modules'] == null
            ? []
            : List<Module>.from(
                json['modules'].map((item) => Module.fromJson(item))),
      );

  Map<String, dynamic> toJson() => {
        "oauth_uid": oauth_uid,
        "level": level,
        "week": week,
        "modules": List<dynamic>.from(modules.map((e) => e.toJson())),
      };
}
