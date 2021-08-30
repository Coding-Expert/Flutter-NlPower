

import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nlpower/model/category.dart';
import 'package:nlpower/model/comment.dart';
import 'package:nlpower/model/group.dart';
import 'package:nlpower/model/post.dart';
import 'package:nlpower/module/user_module.dart';
import 'package:nlpower/service/database_service.dart';


class PostModule {

  static String groupId;
  static List<Category> category_list = [];
  static List<Post> post_list = [];
  static List<Comment> comment_list = [];


  static Future<String> getGroupId(String user_level) async {
    await DatabaseService.firestoreForumGroupsCollection.getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.asMap().forEach((index, data) { 
        if(user_level == snapshot.documents[index]["level"]){
          groupId = snapshot.documents[index].documentID;
        }
      });
      
    });
    return groupId;
  }

  static Future<List<Category>> getCategoryList(String user_level) async {
    category_list = [];
    await DatabaseService.firestoreForumCategoryCollection.getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.asMap().forEach((index, data) {
        if(user_level == snapshot.documents[index]["level"]){
          String level = snapshot.documents[index]["level"];
          String title = snapshot.documents[index]["title"];
          // List groupId_list = snapshot.documents[index]["groupId"];
          Category category = Category(
            level: level,
            title: title,
            id: snapshot.documents[index].documentID
            // groupId_list: groupId_list
          ); 
          category_list.add(category);
        }

      });
    });
    return category_list;
  }

  static Future<String> savePost(Post post) async {
    String response = "";
    String postId = getRandomString(10);    // 10: random string length
    DateTime now = new DateTime.now();
    int offset = now.timeZoneOffset.inHours;
    String timezone = "UTC";
    if(offset < 0){
      timezone = timezone + offset.toString();
    }
    else{
      timezone = timezone + "+" + offset.toString();
    }
    String year = now.year.toString();
    String month = "";
    month = now.month.toString();
    if(now.month < 10){
      month = "0" + month;
    }
    String day = "";
    day = now.day.toString();
    if(now.day < 10){
      day = "0" + day;
    }
    String date = year + "-" + month + "-" + day;
    String formattedTime = DateFormat('kk:mm:ss:a').format(now);
    String post_date = date + " at " + formattedTime + " " + timezone;
    await DatabaseService.firestoreForumPostsCollection.document(postId).setData({
      "description": post.description,
      "dateCreated": post_date,
      "groupId": post.groupId,
      "image": post.imageUrl,
      "postId": postId,
      "userId": post.userId,
      "categoryId": post.categoryId,
      "Comments": post.comments,
      "likes": post.likes,
      
    }).then((value){
      print("---Success!---");
      response = "success";
    });
    
    return response;
  }

  static String getRandomString(int len){
    var random = Random.secure();
    var values = List<int>.generate(len, (index) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  static Future<List<Post>> getPostList(String user_id, String category_id) async {
    post_list = [];
    await DatabaseService.firestoreForumPostsCollection.getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.asMap().forEach((index, data) {
        if(category_id == snapshot.documents[index]["categoryId"]){
          List<String> comment_list = [];
          List<String> likes_list = [];
          String categoryId = snapshot.documents[index]["categoryId"];
          String created_date = snapshot.documents[index]["dateCreated"];
          String description = snapshot.documents[index]["description"];
          String groupId = snapshot.documents[index]["groupId"];
          String image = snapshot.documents[index]["image"];
          String postId = snapshot.documents[index]["postId"];
          String userId = snapshot.documents[index]["userId"];
          List comments = snapshot.documents[index]["Comments"];
          
          for(int i = 0; i < comments.length; i++){
            comment_list.add(comments[i]);
          }
          List likes = snapshot.documents[index]["likes"];
          for(int i = 0; i < likes.length; i++){
            likes_list.add(likes[i]);
          }
          Post post = Post(
            description: description,
            imageUrl: image,
            createdDate: created_date,
            groupId: groupId,
            postId: postId,
            userId: userId,
            categoryId: categoryId,
            comments: comment_list,
            likes: likes_list,
            
          ); 
          post_list.add(post);
        }

      });
    });
  
    return post_list;
  } 

  static Future<String> updateLikeForPost(Post post) async {
    String response = "";
    await DatabaseService.firestoreForumPostsCollection.document(post.postId).setData({
      "description": post.description,
      "dateCreated": post.createdDate,
      "groupId": post.groupId,
      "image": post.imageUrl,
      "postId": post.postId,
      "userId": post.userId,
      "categoryId": post.categoryId,
      "Comments": post.comments,
      "likes": post.likes,
     
    }).then((value){
      print("---Success!---");
      response = "success";
    });
    return response;
  }

  static Future<String> updateCommentForPost(Post post, String comment) async {
    String response = "";
    await DatabaseService.firestoreForumPostsCollection.document(post.postId).setData({
      "description": post.description,
      "dateCreated": post.createdDate,
      "groupId": post.groupId,
      "image": post.imageUrl,
      "postId": post.postId,
      "userId": post.userId,
      "categoryId": post.categoryId,
      "Comments": post.comments,
      "likes": post.likes,
      
    }).then((value) async {
      String commentId = getRandomString(10);    // 10: random string length
      DateTime now = new DateTime.now();
      int offset = now.timeZoneOffset.inHours;
      String timezone = "UTC";
      if(offset < 0){
        timezone = timezone + offset.toString();
      }
      else{
        timezone = timezone + "+" + offset.toString();
      }
      String year = now.year.toString();
      String month = "";
      month = now.month.toString();
      if(now.month < 10){
        month = "0" + month;
      }
      String day = "";
      day = now.day.toString();
      if(now.day < 10){
        day = "0" + day;
      }
      String date = year + "-" + month + "-" + day;
      String formattedTime = DateFormat('kk:mm:ss:a').format(now);
      String comment_date = date + " at " + formattedTime + " " + timezone;
      List<String> comment_likes = [];
      await DatabaseService.firestoreForumCommentCollection.document(commentId).setData({
        "commentId": commentId,
        "date": comment_date,
        "description": comment,
        "parentId": null,
        "postId": post.postId,
        "userId": UserModule.user.uid,
        "likes": comment_likes,
        
      }).then((value) {
        print("---Success!---");
        response = "success";
      });
    });
    return response;
  }

  static Future<List<Comment>> getCommentList(String postId) async {
    comment_list = [];
    await DatabaseService.firestoreForumCommentCollection.getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.asMap().forEach((index, data) {
        if(postId == snapshot.documents[index]["postId"] && snapshot.documents[index]["parentId"] == null){
          List<String> likes_list = [];
          List likes = snapshot.documents[index]["likes"];
          for(int i = 0; i < likes.length; i++){
            likes_list.add(likes[i]);
          }
          Comment comment = Comment(
            commentId: snapshot.documents[index]["commentId"],
            date: snapshot.documents[index]["date"],
            description: snapshot.documents[index]["description"],
            parentId: snapshot.documents[index]["parentId"],
            postId: snapshot.documents[index]["postId"],
            userId: snapshot.documents[index]["userId"],
            likes: likes_list,
            
          ); 
          comment_list.add(comment);
        }

      });
    });
    return comment_list;
  }
  static Future<List<Comment>> getChildCommentForComment(String postId, String commentId) async {
    List<Comment> child_comment_list = [];
    await DatabaseService.firestoreForumCommentCollection.getDocuments().then((QuerySnapshot snapshot){
      snapshot.documents.asMap().forEach((index, data) {
        if(postId == snapshot.documents[index]["postId"] && snapshot.documents[index]["parentId"] == commentId){
          List<String> likes_list = [];
          List likes = snapshot.documents[index]["likes"];
          for(int i = 0; i < likes.length; i++){
            likes_list.add(likes[i]);
          }
          Comment comment = Comment(
            commentId: snapshot.documents[index]["commentId"],
            date: snapshot.documents[index]["date"],
            description: snapshot.documents[index]["description"],
            parentId: snapshot.documents[index]["parentId"],
            postId: snapshot.documents[index]["postId"],
            userId: snapshot.documents[index]["userId"],
            likes: likes_list,
            
          ); 
          child_comment_list.add(comment);
        }

      });
    });
    return child_comment_list;
  }

  static Future<String> updateLikeForComment(Comment comment) async {
    String response = "";
    await DatabaseService.firestoreForumCommentCollection.document(comment.commentId).setData({
      "description": comment.description,
      "date": comment.date,
      "postId": comment.postId,
      "userId": comment.userId,
      "parentId": comment.parentId,
      "commentId": comment.commentId,
      "likes": comment.likes
    }).then((value){
      print("---Success!---");
      response = "success";
    });
    return response;
  }

  static Future<String> saveCommentForComment(String postId, String description, String parentCommentId) async {
    String response = "";
    String child_commentId = getRandomString(10);    // 10: random string length
    DateTime now = new DateTime.now();
    int offset = now.timeZoneOffset.inHours;
    String timezone = "UTC";
    if(offset < 0){
      timezone = timezone + offset.toString();
    }
    else{
      timezone = timezone + "+" + offset.toString();
    }
    String year = now.year.toString();
    String month = "";
    month = now.month.toString();
    if(now.month < 10){
      month = "0" + month;
    }
    String day = "";
    day = now.day.toString();
    if(now.day < 10){
      day = "0" + day;
    }
    String date = year + "-" + month + "-" + day;
    String formattedTime = DateFormat('kk:mm:ss:a').format(now);
    String comment_date = date + " at " + formattedTime + " " + timezone;
    List<String> comment_likes = [];
    await DatabaseService.firestoreForumCommentCollection.document(child_commentId).setData({
      "commentId": child_commentId,
      "date": comment_date,
      "description": description,
      "parentId": parentCommentId,
      "postId": postId,
      "userId": UserModule.user.uid,
      "likes": comment_likes
    }).then((value) {
      print("---Success!---");
      response = "success";
    });
    return response;
  }

  static Future<String> deleteComment(Post post, Comment comment) async {
    String response = "";
    if(comment.parentId != null){
      await DatabaseService.firestoreForumCommentCollection.document(comment.commentId).delete();
      print("---Success!---");
      response = "success";
    }
    else{
      await DatabaseService.firestoreForumCommentCollection.getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.asMap().forEach((index, data) async {
          if(comment.commentId == snapshot.documents[index]["commentId"] || snapshot.documents[index]["parentId"] == comment.commentId){
            await DatabaseService.firestoreForumCommentCollection.document(snapshot.documents[index].documentID).delete();
            
          }
        });
        post.comments.remove(comment.userId);
        DatabaseService.firestoreForumPostsCollection.document(post.postId).setData({
          "description": post.description,
          "dateCreated": post.createdDate,
          "groupId": post.groupId,
          "image": post.imageUrl,
          "postId": post.postId,
          "userId": post.userId,
          "categoryId": post.categoryId,
          "Comments": post.comments,
          "likes": post.likes,
          
        });
        print("---Success!---");
        response = "success";
      });
    }
    return response;
  }

  static Future<String> deletePost(Post post) async {
    String response = "";
    await DatabaseService.firestoreForumPostsCollection.document(post.postId).delete();
    await DatabaseService.firestoreForumCommentCollection.getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.asMap().forEach((index, data) async {
          if(snapshot.documents[index]["postId"] == post.postId){
            await DatabaseService.firestoreForumCommentCollection.document(snapshot.documents[index].documentID).delete();
            
          }
        });
        print("---Success!---");
        response = "success";
    });
    
    return response;
  }

}