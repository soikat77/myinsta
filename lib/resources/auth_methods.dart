import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myinsta/models/user_model.dart';
import 'package:myinsta/resources/storage_methods.dart';
import 'package:provider/provider.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //* -------------- Get User Data from Database for Provider -------------- *//
  Future<UserModel> getUserDetails() async {
    // define current user
    User currentUser =
        _auth.currentUser!; // not UserModel, this User is from firebase

    // getting current user id to the snapshot to have all data of that id
    DocumentSnapshot snapshot =
        await _firestore.collection('users').doc(currentUser.uid).get();

    // format data and return
    return UserModel.fromSnapshot(snapshot);
  }

  // Future<bool> isAuthenticated() async {
  //   if (_auth.currentUser != null) {
  //     // signed in
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  //* ------------------------ signing up a new user ------------------------ *//
  Future<String> signupUser({
    required Uint8List file,
    required String username,
    required String bio,
    required String email,
    required String password,
  }) async {
    String res = '';

    try {
      if (file != null ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          email.isNotEmpty ||
          password.isNotEmpty) {
        // register the user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // print(credential.user!.uid);

        String photoUrl = await StorageMethods()
            .uploadImageToStorage('profilePics', file, false);

        //* -------------------- add user in the firebase database ------------------- *//
        UserModel newUser = UserModel(
          email: email,
          uid: credential.user!.uid,
          photoUrl: photoUrl,
          username: username,
          bio: bio,
          followers: [],
          following: [],
        );

        await _firestore.collection('users').doc(credential.user!.uid).set(
              newUser.toJson(),
            );
        res = "Success";
        // print(res);
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //* ------------------------------- log in user ------------------------------ *//
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'Some Error';

    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'Success';
      } else {
        res = 'Enter Your Email and Password correctly.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //* -------------------------------- sign out -------------------------------- *//
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
