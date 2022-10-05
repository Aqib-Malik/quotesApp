// ignore_for_file: dead_code

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:positify_project/common_widgets/CommonWidgets.dart';
import 'package:positify_project/pages/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/firebase_service/firestore.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController oldpasscontroller = TextEditingController();
  TextEditingController newpasscontroller = TextEditingController();
  final formkey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isButtonEnable = true;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Change Password',
              style: TextStyle(fontFamily: 'Quattrocento', color: Colors.black),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);

                // Navigator.pushNamed(context, '/quote_screen');
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: Get.height,
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/background_splash.jpg'),
              fit: BoxFit.cover,
            )),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      image: const DecorationImage(
                          image:
                              AssetImage("assets/images/girl_background.jpg"),
                          fit: BoxFit.cover)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 120),
                  decoration: const BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage("assets/images/girl_background.jpg"),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  child: BlurryContainer(
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(40)),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        // ignore: sized_box_for_whitespace
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Container(
                            height: Get.height / 2.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text("Change Password",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                        color: Colors.black,
                                        fontFamily: 'Quattrocento',
                                      )),
                                ),
                                Form(
                                  key: formkey1,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        // controller: email,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'must enter old Password';
                                          }
                                          return null;
                                        },
                                        controller: oldpasscontroller,

                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    20, 10, 10, 10),
                                            hintText: "Enter Old Password",
                                            hintStyle: const TextStyle(
                                              fontFamily: 'Quattrocento',
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 1)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      TextFormField(
                                        // controller: email,
                                        keyboardType: TextInputType.text,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'must enter new Password';
                                          }
                                          return null;
                                        },
                                        controller: newpasscontroller,

                                        decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.transparent,
                                            contentPadding:
                                                const EdgeInsets.fromLTRB(
                                                    20, 10, 10, 10),
                                            hintText: "Enter Password",
                                            hintStyle: const TextStyle(
                                              fontFamily: 'Quattrocento',
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30),
                                                borderSide: const BorderSide(
                                                    color: Colors.white,
                                                    width: 1)),
                                            enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(30))),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      // TextFormField(
                                      //   // controller: email,

                                      //   decoration: InputDecoration(
                                      //       filled: true,
                                      //       fillColor: Colors.transparent,
                                      //       contentPadding:
                                      //           const EdgeInsets.fromLTRB(
                                      //               20, 10, 10, 10),
                                      //       hintText: "Reenter Password",
                                      //       hintStyle: const TextStyle(
                                      //         fontFamily: 'Quattrocento',
                                      //       ),
                                      //       focusedBorder: OutlineInputBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(30),
                                      //           borderSide: const BorderSide(
                                      //               color: Colors.white,
                                      //               width: 1)),
                                      //       enabledBorder: OutlineInputBorder(
                                      //           borderRadius:
                                      //               BorderRadius.circular(30))),
                                      // ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    if (formkey1.currentState!.validate()) {
                                      //   FirestoreMethods.checkPass(
                                      //     oldpasscontroller.text,
                                      //  );
                                      SharedPreferences sharedPreferences =
                                          await SharedPreferences.getInstance();
                                      var obtainPass = sharedPreferences
                                          .getString('password');

                                      // print(
                                      //     await FirestoreMethods.verifyPass());
                                      if (obtainPass ==
                                          oldpasscontroller.text) {
                                        FirestoreMethods.changePassword(
                                            newpasscontroller.text);
                                      } else {
                                        CommonWdget.toastShow(
                                            "Old password Wrong");
                                      }
                                      FocusScope.of(context).unfocus();
                                    }
                                    // Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: 150,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: isButtonEnable
                                          ? const Color.fromARGB(
                                              133, 118, 47, 3)
                                          : Colors.white10,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        'Change Password',
                                        style: TextStyle(
                                            fontFamily: 'Quattrocento',
                                            fontSize: 17,
                                            color: isButtonEnable
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
