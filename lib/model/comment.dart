

class Comment {

  String commentId;
  String date;
  String description;
  String parentId;
  String postId;
  String userId;
  List<String> likes;

  Comment({
    this.commentId,
    this.date,
    this.description,
    this.parentId,
    this.postId,
    this.userId,
    this.likes,
    
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
    description: json["description"] == null ? "" : json["description"],
    commentId: json["commentId"] == null ? "" : json["commentId"],
    date: json["date"] == null ? "" : json["date"],
    parentId: json["parentId"] == null ? "" : json["parentId"],
    postId: json["postId"] == null ? "" : json["postId"],
    userId: json["userId"] == null ? "" : json["userId"],
    likes: json["likes"] == null ? null : json["likes"],
    
  );

  Map<String, dynamic> toJson() => {
    "description" : description,
    "commentId": commentId,
    "parentId": parentId,
    "postId": postId,
    "userId": userId,
    "date": date,
    "likes": likes,
    
  };
}