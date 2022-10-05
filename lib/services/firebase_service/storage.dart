// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:positify_project/services/firebase_service/firestore.dart';

class StorageFirebaseServices {
  ///****Pick image freom mob Gallery******/
  static Future<File> getImage() async {
    final picker = ImagePicker();
    File _image;
    // ignore: deprecated_member_use
    final image = await picker.getImage(source: ImageSource.gallery);

    _image = File(image!.path);
    return _image;
  }

  ///****Pick image freom mob camera******/
  static Future<File> getCameraImage() async {
    final picker = ImagePicker();
    File _image;
    // ignore: deprecated_member_use
    final image = await picker.getImage(source: ImageSource.camera);

    _image = File(image!.path);
    return _image;
  }

  ///****upload account pic on firebase Storage******/
  static Future<String> uploadImage(_image, email, userInfi) async {
    var imagestatus = await FirebaseStorage.instance
        .ref()
        .child('images')
        .child(email + ".jpg")
        .putFile(_image) //await StorageFirebaseServices.getImage())
        .then((value) => value);
    String imageUrl = await imagestatus.ref.getDownloadURL();
    userInfi['imageLink'] = imageUrl.toString();
    await FirestoreMethods.createUserInFireStore(email, userInfi);
    return imageUrl;
  }
}
