import 'package:get/get.dart';

class uploadingButton extends GetxController {
  RxBool isbuttonpressed = false.obs;

  set_true() {
    isbuttonpressed.value = true;
  }

  set_false() {
    isbuttonpressed.value = false;
  }
}
