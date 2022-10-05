import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../services/firebase_service/authentication.dart';

class LogInController extends GetxController {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  var isObsecure = true.obs;
  var isLoad = false.obs;

  togglePass() {
    isObsecure.value = !isObsecure.value;
  }

  @override
  void onClose() {}

  signin() {
    AuthServices.signInWithEmailandPass(
        emailcontroller.text, passcontroller.text);
    emailcontroller.clear();
    passcontroller.clear();
    return true;
  }
}
