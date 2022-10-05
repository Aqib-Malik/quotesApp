// ignore_for_file: library_private_types_in_public_api, file_names, avoid_types_as_parameter_names, unused_field, non_constant_identifier_names

import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/pages/signup_screen/signup_controller.dart';

import '../login_screen/loginView.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key, key}) : super(key: key);
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  Map<String, dynamic>? userInfi;
  final formkey1 = GlobalKey<FormState>();
  final SignupController _signupcontroller = Get.put(SignupController());
  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.of(context).viewInsets.bottom;
    var size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/girl_background.jpg'),
              ),
            ),
            child: BlurryContainer(
              width: 300,
              height: 200,
              padding: EdgeInsets.only(bottom: bottom),
              blur: 6,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Image(
                        // height: 70,
                        // width: 70,
                        image: AssetImage(
                          "assets/images/logo.png",
                        ),
                      ),
                    ),
                    const Text(
                      'Positify',
                      style: TextStyle(
                          fontFamily: 'Charlemagne',
                          fontSize: 26,
                          letterSpacing: 5),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Form(
                      key: formkey1,
                      child: Column(
                        children: [
                          Container(
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 7,
                                      offset: const Offset(1, 1),
                                      color: Colors.grey.withOpacity(0.2))
                                ]),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Email Cannot Be Empty';
                                }
                                if (!value.isValidEmail()) {
                                  return 'Email not valid';
                                }

                                return null;
                              },
                              controller:
                                  Get.find<SignupController>().emailcontroller,
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  hintText: "Email",
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Quattrocento',
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: size.width * 0.9,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 7,
                                      offset: const Offset(1, 1),
                                      color: Colors.grey.withOpacity(0.2))
                                ]),
                            child: TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Password Cannot Be Empty';
                                }
                                return null;
                              },
                              controller:
                                  Get.find<SignupController>().passcontroller,
                              obscureText: true,
                              decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(20, 10, 10, 10),
                                  hintText: "Password",
                                  hintStyle: const TextStyle(
                                    fontFamily: 'Quattrocento',
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: const BorderSide(
                                          color: Colors.white, width: 1)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   width: size.width * 0.9,
                          //   decoration: BoxDecoration(
                          //       color: Colors.white,
                          //       borderRadius: BorderRadius.circular(30),
                          //       boxShadow: [
                          //         BoxShadow(
                          //             blurRadius: 10,
                          //             spreadRadius: 7,
                          //             offset: const Offset(1, 1),
                          //             color: Colors.grey.withOpacity(0.2))
                          //       ]),
                          //   child: TextFormField(
                          //     validator: (value) {
                          //       if (value !=
                          //           Get.find<SignupController>()
                          //               .passcontroller
                          //               .text) {
                          //         return 'Not matched';
                          //       }
                          //       return null;
                          //     },
                          //     controller:
                          //         Get.find<SignupController>().confirmpassword,
                          //     decoration: InputDecoration(
                          //         contentPadding:
                          //             const EdgeInsets.fromLTRB(20, 10, 10, 10),
                          //         hintText: "Confirm Password",
                          //         hintStyle: const TextStyle(
                          //           fontFamily: 'Quattrocento',
                          //         ),
                          //         focusedBorder: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(30),
                          //             borderSide: const BorderSide(
                          //                 color: Colors.white, width: 1)),
                          //         enabledBorder: OutlineInputBorder(
                          //             borderRadius: BorderRadius.circular(30))),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (formkey1.currentState!.validate()) {
                          Get.find<SignupController>()
                              .signup()
                              .whenComplete(() {
                            FocusManager.instance.primaryFocus!.unfocus();
                          });
                        }
                      },
                      child: Obx(
                        () => Container(
                          width: size.width * 0.5,
                          height: 50,
                          decoration: const BoxDecoration(
                              color: Color.fromARGB(133, 118, 47, 3),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          child: Center(
                              child: Get.find<SignupController>().isLoad.value
                                  ? CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          fontFamily: 'Quattrocento',
                                          fontSize: 16,
                                          color: Colors.white),
                                    )),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const loginView(),
                            duration: const Duration(milliseconds: 1000),
                          ),
                        );
                      },
                      child: const Text(
                        'Already have an account? Sign In',
                        style: TextStyle(
                            fontFamily: 'Quattrocento',
                            fontSize: 16,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  static Future<File> getImage() async {
    final picker = ImagePicker();
    File _image;
    // ignore: deprecated_member_use
    final image = await picker.getImage(source: ImageSource.gallery);

    _image = File(image!.path);
    return _image;
  }
}

// extension in string
extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
