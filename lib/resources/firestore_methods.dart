import 'package:firebase_auth/firebase_auth.dart';
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

  //* ----------------------------- like and unlike ---------------------------- *//
  Future<void> likePost(
    String postid,
    String uid,
    List likes,
  ) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        await _firestore.collection('posts').doc(postid).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }
    } catch (e) {
      // print(e.toString());
    }
  }

  //* --------------------------------- Comment -------------------------------- *//
  Future<void> postComment(
    String postid,
    String text,
    String uid,
    String username,
    String profilePic,
  ) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postid)
            .collection('comments')
            .doc(commentId)
            .set({
          'postid': postid,
          'text': text,
          'uid': uid,
          'username': username,
          'profilePic': profilePic,
          'datePublished': DateTime.now(),
        });
      } else {
        print('Text is empty, write something first.');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //* ----------------------------- Delete the post ---------------------------- *//
  Future<void> deletePost(String postid) async {
    try {
      await _firestore.collection('posts').doc(postid).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  //* ---------------------------- Follow / Unfollow --------------------------- *//
  Future<void> followUser(String uid, String followId) async {
    try {
      // getting userid
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uid).get();
      List following = (snapshot.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        // remove user id from the data of whoom user following
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        // remove the id of whoom user following from the data of user id
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        // add user id in the data of whoom user start to follow
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        // add the id of whoom user start to follow in the data of user id
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
