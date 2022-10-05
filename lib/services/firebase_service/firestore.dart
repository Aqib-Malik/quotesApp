import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:positify_project/pages/Get_started_page/GetStardedController.dart';

import '../../common_widgets/CommonWidgets.dart';
import '../../pages/signup_screen/user details/UserName&Profile.dart';

class FirestoreMethods {
  ////************** Create User ************************///////
  static createUserInFireStore(String email, var userData) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(email)
        .set(userData);
  }

  //****Update FavouriteQuotes on firebasae******/
  static void updateActivities(var faveData) async {
    var list = [faveData];
    //followers = followers++;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"fav_quotes": FieldValue.arrayUnion(list)});

    CommonWdget.toastShow("Add to Favourite");
  }

  //****Update prime user on firebasae******/
  static void updatePrimeUser() async {
    //followers = followers++;
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({"prime_user": true});

    CommonWdget.toastShow("You become a prime user");
  }

  ////************** Add Review ************************///////
  static addReview(var userData) async {
    await FirebaseFirestore.instance
        .collection('Reviews')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(userData)
        .then((value) => CommonWdget.toastShow("Review Added"));
  }

  ////************** Add Quode ************************///////
  static addQuote(var quoteData) async {
    await FirebaseFirestore.instance
        .collection('Quotes')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(quoteData)
        .then((value) => CommonWdget.toastShow("Quote Added Successfully"));
  }

////******************Change Password */
  static void changePassword(String password) async {
    //Create an instance of the current user.
    var user = FirebaseAuth.instance.currentUser;

    //Pass in the password to updatePassword.
    user!.updatePassword(password).then((_) {
      CommonWdget.toastShow("Successfully changed password");
    }).catchError((error) {
      CommonWdget.toastShow("Password can't be changed$error");
    });
  }

  ///**** remove favourite******/
  static void removeFav(data) async {
    try {
      // print("object");
      var collection = FirebaseFirestore.instance.collection('users');
      collection.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'fav_quotes': FieldValue.arrayRemove([data]),
      }).whenComplete(() {
        CommonWdget.toastShow("Removes syccessfully");
        Get.find<GetStartedController>().fetchdata();
      });
    } catch (e) {
      // print(e);
    }
  }

  ////********************check pass */

  static void checkPass(data) async {
    try {} catch (e) {
      // print(e);
    }
  }

  ////************** Add Quode ************************///////
  static addForum(var forumData) async {
    await FirebaseFirestore.instance
        .collection('forum testing')
        .doc(Get.find<GetStartedController>().email.value +
            Timestamp.now().toString())
        .set(forumData)
        .then((value) => CommonWdget.toastShow("forum Added Successfully"));
  }

  /////update user name
  static void updateUserName(String name, String docId) async {
    await FirebaseFirestore.instance.collection('users').doc(docId).update({
      'name': name,
    }).whenComplete(() {
      CommonWdget.toastShow("User updated Successfully");
    });
  }

  ///****Update userPic on firebasae******/
  static void updatePhoto(String name, String url, String docId) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(docId)
        .update({'name': name, 'imageLink': url}).whenComplete(
            () => CommonWdget.toastShow("User updated Successfully"));
  }
}
