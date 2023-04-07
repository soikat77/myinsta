import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myinsta/models/post_model.dart';
import 'package:myinsta/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //* ----------------------- method of uploading a post to firestore ----------------------- *//
  Future<String> uploadPost(
    String caption,
    Uint8List imageFile,
    String uid,
    String username,
    String profileImage,
  ) async {
    String res = 'Something wrong';
    try {
      // upload the photo and get the url
      String photoUrl =
          await StorageMethods().uploadImageToStorage('posts', imageFile, true);

      // create unic post id
      String postid = const Uuid().v1();

      // generate post with various data
      PostModel post = PostModel(
        uid: uid,
        postid: postid,
        postUrl: photoUrl,
        // photoUrl: photoUrl,
        username: username,
        profileImage: profileImage,
        caption: caption,
        datePublished: DateTime.now(),
        likes: [],
      );

      // now upload/create the post
      _firestore.collection('posts').doc(postid).set(
            post.toJson(),
          );

      res = 'Success';
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
