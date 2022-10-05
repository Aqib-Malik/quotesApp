import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mypreferences extends GetxController {
  RxList preferencesList = [].obs;

  @override
  void onInit() {
    print("override method has been executed");
    getpreferencelistmembers();
    super.onInit();
  }

  getpreferencelistmembers() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    preferencesList = pref.getStringList("my_subscription")!.obs;
    print(preferencesList.toList());
  }
}
