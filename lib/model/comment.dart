import 'package:cloud_firestore/cloud_firestore.dart';

class Comment {
  String username;
  String comment;
// ignore: prefer_typing_uninitialized_variables
  final datePublished;
  List likes;
  String profilePhoto;
  String uid;
  String id;
  Comment(
    this.datePublished, {
    required this.username,
    required this.comment,
    required this.likes,
    required this.profilePhoto,
    required this.uid,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'comment': comment,
        'likes': likes,
        'datePublished': datePublished,
        'profilePhoto': profilePhoto,
        'uid': uid,
        'id': id,
      };

  factory Comment.fromSnapShot(DocumentSnapshot snap) {
    final json = snap.data() as Map<String, dynamic>;

    return Comment(
      json['datePublished'],
      username: json['username'],
      comment: json['comment'],
      likes: json['likes'],
      profilePhoto: json['profilePhoto'],
      uid: json['uid'],
      id: json['id'],
    );
  }
}
