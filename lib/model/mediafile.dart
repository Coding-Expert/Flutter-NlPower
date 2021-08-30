class MediaFile {
  String title;
  String descr;
  String photo;
  String media;
  String filetype;
  String duration;

  MediaFile(
      {this.title,
      this.descr,
      this.photo,
      this.media,
      this.filetype,
      this.duration});

  factory MediaFile.fromJson(Map<String, dynamic> json) => MediaFile(
        title: json['title'],
        descr: json['descr'],
        photo: json['photo'],
        media: json['media'],
        filetype: json['filetype'],
        duration: json['duration'],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "descr": descr,
        "photo": photo,
        "media": media,
        "filetype": filetype,
        "duration": duration,
      };
}
