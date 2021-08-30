
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  static Firestore firestore;
  static CollectionReference firestoreForumGroupsCollection;
  static CollectionReference firestoreForumPostsCollection;
  static CollectionReference firestoreForumCategoryCollection;
  static CollectionReference firestoreForumCommentCollection;
  static CollectionReference firestoreUserCollection;

  static void initFirebase(){
    firestore = Firestore.instance;
    firestore.settings(persistenceEnabled: false, cacheSizeBytes: 10000000);
    firestoreForumGroupsCollection = firestore.collection("ForumGroups");
    firestoreForumPostsCollection = firestore.collection("ForumPosts");
    firestoreForumCategoryCollection = firestore.collection("ForumCategories");
    firestoreForumCommentCollection = firestore.collection("ForumComments");
    firestoreUserCollection = firestore.collection("User");
  }
}