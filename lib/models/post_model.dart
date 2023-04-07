import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String uid;
  final String postid;
  final String postUrl;
  // final String photoUrl;
  final String username;
  final String profileImage;
  final String caption;
  final datePublished;
  final likes;

  const PostModel({
    required this.uid,
    required this.postid,
    required this.postUrl,
    // required this.photoUrl,
    required this.username,
    required this.profileImage,
    required this.caption,
    required this.datePublished,
    required this.likes,
  });

  // convert to Json format
  Map<String, dynamic> toJson() => {
        'uid': uid,
        'postid': postid,
        'postUrl': postUrl,
        // 'photoUrl': photoUrl,
        'username': username,
        'profileImage': profileImage,
        'caption': caption,
        'datePublished': datePublished,
        'likes': likes,
      };

  // formating post data from the snapshot 
  static PostModel fromSnapshot(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PostModel(
      uid: snapshot['uid'],
      postid: snapshot['postid'],
      postUrl: snapshot['postUrl'],
      // photoUrl: snapshot['photoUrl'],
      username: snapshot['username'],
      profileImage: snapshot['profileImage'],
      caption: snapshot['caption'],
      datePublished: snapshot['datePublished'],
      likes: snapshot['likes'],
    );
  }
}
