// ignore_for_file: unnecessary_brace_in_string_interps, invalid_return_type_for_catch_error

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:positify_project/pages/Get_started_page/get_started_screen.dart';
import 'package:positify_project/pages/login_screen/loginView.dart';
import 'package:positify_project/pages/signup_screen/user%20details/UserName&Profile.dart';
import 'package:positify_project/services/firebase_service/firestore.dart';
import 'package:positify_project/services/firebase_service/storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common_widgets/CommonWidgets.dart';
import '../../common_widgets/CommonWidgets.dart';
import '../../common_widgets/CommonWidgets.dart';
import '../../pages/login_screen/login_controller.dart';
import '../../pages/signup_screen/signup_controller.dart';
import '../../pages/splash_screen.dart';

import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  static var auth = FirebaseAuth.instance.currentUser;
  Future<String>? imgLink;
  static bool? exist;

  ///****Create Account on firebase******/
  static createStuwithemailandpass(
    String email,
    String password,
    var userInfi,
  ) async {
    try {
      Get.find<SignupController>().isLoad.value = true;
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .whenComplete(() async {
        await FirestoreMethods.createUserInFireStore(email, userInfi);

        CommonWdget.toastShow('Successfully Acount created');
        Get.find<SignupController>().isLoad.value = false;
        Get.to(UserNameAndProfile());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        CommonWdget.toastShow('The password provided is too weak.');
        Get.find<SignupController>().isLoad.value = false;
      } else if (e.code == 'email-already-in-use') {
        CommonWdget.toastShow('The account already exists for that email.');
        Get.find<SignupController>().isLoad.value = false;
      }
    } catch (e) {
      CommonWdget.toastShow('Some thing gonna wrong');
      Get.find<SignupController>().isLoad.value = true;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //upload user photo to firebase//

  static Future<String?> uploadStorage(
      {required File image, required childName}) async {
    String? imagelink;
    final uploading_result = await FirebaseStorage.instance
        .ref()
        .child(childName)
        .child(Timestamp.now().toString())
        .putFile(image);
    imagelink = await uploading_result.ref.getDownloadURL();
    print("image link returns in services file : $imagelink");
    return imagelink;
  }

  ///****SignIn method for on firebase******/
  static signInWithEmailandPass(String email, String password) async {
    try {
      // ignore: unused_local_variable
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('email', email);
      sharedPreferences.setString('password', password);
      finalemail = email;
      Get.find<LogInController>().isLoad.value = false;
      // CommonWdget.toastShow('Successfully LogIn');
      Get.off(GetStartedScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.find<LogInController>().isLoad.value = false;
        CommonWdget.toastShow('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.find<LogInController>().isLoad.value = false;
        CommonWdget.toastShow('Wrong password provided for that user.');
      }
    } catch (e) {
      Get.find<LogInController>().isLoad.value = false;
      CommonWdget.toastShow('please enter valid information');
    }
  }

  //////************************LogOut
  static logOutUser() async {
    await GoogleSignIn().signOut();
    // FacebookAuth.instance.logOut();
    SignupController.imagelink.value = "";
    await FirebaseAuth.instance.signOut().whenComplete(() async {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.remove('email');
      sharedPreferences
          .remove('password')
          .whenComplete(() => Get.offAll(const loginView()));
    });
  }

  ////*************RESET PASSWORD */
  static void sendPasswordResetEmail(String email) async {
    try {
      // return FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) {
        CommonWdget.toastShow("Password Link has been sent to ${email}");
      }).catchError((e) => CommonWdget.toastShow(e.toString()));
    } on FirebaseAuthException catch (e) {
      CommonWdget.toastShow(e.toString());
    } catch (exception) {
      CommonWdget.toastShow(exception.toString());
    }
  }

  //////************************Google Sign In
  static googleSignin() async {
    Map<String, dynamic> userInfi;
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        userInfi = {
          'name': googleUser.displayName,
          'email': googleUser.email,
          "contact": "",
          "fav_quotes": null,
          "prime_user": false,
          // "cart": [],
          // "profileImage": googleUser.photoUrl,
        };
        if (await AuthServices.checkExist(
            FirebaseAuth.instance.currentUser!.uid, "users")) {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          sharedPreferences.setString('email', googleUser.email);

          // finalemail = googleUser.email;
          CommonWdget.toastShow('Logged In');
          Get.off(GetStartedScreen());
        } else {
          ////***********************checking user name is valid or not
          FirestoreMethods.createUserInFireStore(
                  FirebaseAuth.instance.currentUser!.uid, userInfi)
              .whenComplete(() async {
            SharedPreferences sharedPreferences =
                await SharedPreferences.getInstance();
            sharedPreferences.setString('email', googleUser.email);
            // finalId = FirebaseAuth.instance.currentUser!.uid;
            // finalemail = googleUser.email;
            CommonWdget.toastShow('Logged In');
            //  finalId = googleUser.id;
            Get.off(GetStartedScreen());
          });
        }

        // finalId = googleUser.email;
      });
    } catch (e) {
      //CommonWdget.toastShow(e.toString());
      // print(e.toString());
    }
  }

  ///////************Checking user exist or not*******//////
  // ignore: non_constant_identifier_names
  static Future<bool> checkExist(String docID, String Collection) async {
    bool isExist = false;
    try {
      await FirebaseFirestore.instance
          .collection(Collection)
          .doc(docID)
          .get()
          .then((doc) {
        // print(doc.exists);
        isExist = doc.exists;
        if (doc.exists == true) {
          //AuthServices.signInWithEmailandPass(docID, pass);
        } else {
          // CommonWidgets.toastShow("User not Exist");
        }
      });
      return isExist;
    } catch (e) {
      // print("user not exist");
      // If any error
      return false;
    }
  }
}

Future<File?> compressprofileimage(File file) async {
  File compressedFile = await FlutterNativeImage.compressImage(
    file.path,
    percentage: 80,
    targetHeight: 500,
    targetWidth: 700,
    quality: 80,
  );
  return compressedFile;
}
