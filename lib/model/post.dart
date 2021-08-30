

class Post {
  
  String description;
  String imageUrl;
  String createdDate;
  String groupId;
  String postId;
  String userId;
  String categoryId;
  List<String> comments;
  List<String> likes;

  Post({
    this.description,
    this.imageUrl,
    this.createdDate,
    this.groupId,
    this.postId,
    this.userId,
    this.comments,
    this.likes,
    this.categoryId,
    
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    description: json["description"] == null ? "" : json["description"],
    imageUrl: json["image"] == null ? "" : json["image"],
    createdDate: json["dateCreated"] == null ? "" : json["dateCreated"],
    groupId: json["groupId"] == null ? "" : json["groupId"],
    postId: json["postId"] == null ? "" : json["postId"],
    userId: json["userId"] == null ? "" : json["userId"],
    comments: json["Comments"] == null ? null : json["Comments"],
    likes: json["likes"] == null ? null : json["likes"],
    categoryId: json["categoryId"] == null ? null : json["categoryId"],
    
  );

  Map<String, dynamic> toJson() => {
    "description" : description,
    "imageUrl" : imageUrl,
    "createdDate": createdDate,
    "groupId": groupId,
    "postId": postId,
    "userId": userId,
    "comments": comments,
    "likes": likes,
    "categoryId": categoryId,
  };

}