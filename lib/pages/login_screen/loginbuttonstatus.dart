import 'package:get/get.dart';

class loginbuttonstatus extends GetxController {
  RxBool isloginbuttonpressed = false.obs;

  set_true() {
    isloginbuttonpressed.value = true;
  }

  set_false() {
    isloginbuttonpressed.value = false;
  }
}
