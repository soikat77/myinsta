import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //* ------------------ upload image in the firebase storage ------------------ *//

  Future<String> uploadImageToStorage(
    String childName,
    Uint8List file,
    bool isPost,
  ) async {
    // create folder alike
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    // upload task
    UploadTask uploadTask = ref.putData(file);

    // snapshot the task
    TaskSnapshot snap = await uploadTask;

    // get the url of uploaded task
    String downloadUrlofProfilePics = await snap.ref.getDownloadURL();

    // return url
    return downloadUrlofProfilePics;
  }
}
