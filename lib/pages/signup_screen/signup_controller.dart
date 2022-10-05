import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../services/firebase_service/authentication.dart';

class SignupController extends GetxController {
  // final formkey1 = GlobalKey<FormState>();
  final TextEditingController usernamecontroller = TextEditingController();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();
  final TextEditingController confirmpassword = TextEditingController();
  final TextEditingController contactcontroller = TextEditingController();
  var isObsecure = true.obs;
  var isLoad = false.obs;
  static RxString imagelink = "".obs;
  togglePass() {
    isObsecure.value = !isObsecure.value;
  }

  @override
  void onClose() {}

  signup() {
    var userInfi = {
      'name': "not mentioned",
      'email': emailcontroller.text,
      'contact': "not mentioned",
      "fav_quotes": null,
      "prime_user": false,

      // 'photoUrl': '$imageUrl' == null
      //     ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSA65C8-sNxxoiwjic3K8ZOs-2oG6PC-wu1dw&usqp=CAU'
      //     : '$imageUrl',
      //'searchIndex': indexList,
      //'status': 'offline'
    };

    AuthServices.createStuwithemailandpass(
      emailcontroller.text,
      passcontroller.text,
      userInfi,
    );
    emailcontroller.clear();
    usernamecontroller.clear();
    passcontroller.clear();
    confirmpassword.clear();
    contactcontroller.clear();
    return true;
  }

  static Future<String?> uploadimage(File? image, child) async {
    await AuthServices.uploadStorage(image: image!, childName: child)
        .then((value) {
      print("here is the value data in controller class : $value");
      if (value != null) {
        return imagelink.value = value;
      }
    });
    return imagelink.value;
  }
}
