// ignore_for_file: non_constant_identifier_names, empty_catches, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class GetStartedController extends GetxController {
  var isforumimageLoad = false.obs;
  RxString name = "".obs;
  var email = "".obs;
  var contact = "".obs;
  var image = "".obs;
  var is_primeuser = false.obs;

  var fav_quotes = [].obs;
  Map? data;
  fetchdata() {
    CollectionReference collectionReference = FirebaseFirestore.instance
        .collection //(teach == false? 'students': 'users');
        ('users');

    collectionReference
        .doc(FirebaseAuth.instance.currentUser!.email)
        .snapshots()
        .listen((snapshot) {
      data = snapshot.data() as Map?;
      print(data.toString());
      if (data != null) {
        // CommonWdget.confirmBox("titlle", data.toString(), () { });
        name.value = data!['name'];
        email.value = data!['email'];
        contact.value = data!['contact'];
        is_primeuser.value = data!['prime_user'];
        image.value = data!['imageLink'];
        data!['fav_quotes'] == null
            ? fav_quotes.value = []
            : fav_quotes.value = data!['fav_quotes'];
      } else {
        name.value = "";
        email.value = "";
        contact.value = "";
        image.value = "";
        fav_quotes.value = [];
        is_primeuser.value = false;
      }
    });
  }

  @override
  void onClose() {}

  @override
  void onInit() async {
    await fetchdata();
    super.onInit();
  }
}
