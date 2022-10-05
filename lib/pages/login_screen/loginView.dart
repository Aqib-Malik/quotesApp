// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names, library_private_types_in_public_api, avoid_types_as_parameter_names, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/pages/login_screen/login_controller.dart';
import 'package:positify_project/pages/signup_screen/signUpView.dart';
import 'package:positify_project/services/firebase_service/authentication.dart';

import '../../common_widgets/CommonWidgets.dart';

class loginView extends StatefulWidget {
  const loginView({Key, key}) : super(key: key);

  @override
  _loginViewState createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {
  final TextEditingController _resetController = TextEditingController();
  Map<String, dynamic>? userInfi;
  final formkey1 = GlobalKey<FormState>();
  final LogInController _controller = Get.put(LogInController());
  final TextEditingController email = TextEditingController();
  // var isObscure = true;
  final TextEditingController password = TextEditingController();
  // final TextEditingController email = TextEditingController();
  var isObscure = true;
  // final TextEditingController password = TextEditingController();
  bool isButtonEnable = false;
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // var args = ModalRoute.of(context)!.settings.arguments as dynamic;
    var size = MediaQuery.of(context).size;

    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(
          padding: const EdgeInsets.only(top: 20),
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/girl_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BlurryContainer(
            width: 300,
            height: 200,
            blur: 6,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image(
                          height: 75,
                          width: 75,
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
                    ],
                  ),
                  const SizedBox(
                    height: 50,
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
                            ],
                          ),
                          child: TextFormField(
                            // controller: email,
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'must enter email address';
                              }
                              return null;
                            },
                            controller: _controller.emailcontroller,

                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.transparent,
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
                            // controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'must enter password';
                              }
                              return null;
                            },
                            keyboardType: TextInputType.emailAddress,
                            controller: _controller.passcontroller,

                            obscureText: isObscure,
                            decoration: InputDecoration(
                                suffixIcon: InkWell(
                                    onTap: () {
                                      setState(() {
                                        isObscure = isObscure ? false : true;
                                        // print(isObscure);
                                      });
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(right: 10),
                                      child: isObscure
                                          ? const Icon(
                                              FontAwesomeIcons.eyeSlash,
                                              size: 19,
                                              color: Colors.black,
                                            )
                                          : const Icon(
                                              Icons.remove_red_eye_outlined,
                                              color: Colors.black,
                                            ),
                                    )
                                    // child: isObscure?Image(image:AssetImage('assets/images/hide.png'),height: 2,):Icon(Icons.remove_red_eye_outlined)
                                    ),
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
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          dialogconfirmBox("Reset", "Enter Email", () {
                            AuthServices.sendPasswordResetEmail(
                                _resetController.text);
                          }, context, _resetController);
                        },
                        child: const Text(
                          'Forgot Password',
                          style: TextStyle(
                              fontFamily: 'Quattrocento',
                              fontSize: 17,
                              color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.08,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (formkey1.currentState!.validate()) {
                        Get.find<LogInController>().isLoad.value = true;
                        Get.find<LogInController>().signin().whenComplete(() {
                          FocusManager.instance.primaryFocus!.unfocus();
                        });

                        FocusScope.of(context).unfocus();
                      }
                      // if (email.text.isNotEmpty && password.text.isNotEmpty) {
                      //   Navigator.push(
                      //     context,
                      //     PageTransition(
                      //       type: PageTransitionType.fade,
                      //       child: const GetStartedScreen(),
                      //       duration: const Duration(milliseconds: 1000),
                      //     ),
                      //   );
                      // }
                    },
                    child: Obx(
                      () => Container(
                        width: size.width * 0.5,
                        height: 50,
                        decoration: BoxDecoration(
                          color: isButtonEnable
                              ? const Color.fromARGB(133, 118, 47, 3)
                              : Colors.white.withOpacity(.45),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Center(
                          child: Get.find<LogInController>().isLoad.value
                              ? CircularProgressIndicator(
                                  color: Colors.black,
                                )
                              : Text(
                                  'Sign In',
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
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      AuthServices.googleSignin();
                    },
                    child: Container(
                      width: size.width * 0.8,
                      height: 50,
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(133, 118, 47, 3),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          SizedBox(
                              width: 30,
                              height: 30,
                              child: Image.asset('assets/images/google.png')),
                          const SizedBox(
                            width: 30,
                          ),
                          const Text(
                            'Sign In with Google',
                            style: TextStyle(
                                fontFamily: 'Quattrocento',
                                fontSize: 15,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Container(
                  //   width: size.width * 0.8,
                  //   height: 50,
                  //   decoration: const BoxDecoration(
                  //       color: Color.fromARGB(133, 118, 47, 3),
                  //       borderRadius: BorderRadius.all(Radius.circular(10))),
                  //   child: Row(
                  //     children: [
                  //       const SizedBox(
                  //         width: 20,
                  //       ),
                  //       SizedBox(
                  //           width: 30,
                  //           height: 30,
                  //           child: Image.asset('assets/images/facebook.png')),
                  //       const SizedBox(
                  //         width: 30,
                  //       ),
                  //       const Text(
                  //         'Sign In with Facebook',
                  //         style: TextStyle(
                  //             fontFamily: 'Quattrocento',
                  //             fontSize: 15,
                  //             color: Colors.white),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const SignUpScreen(),
                          duration: const Duration(milliseconds: 1000),
                        ),
                      );
                    },
                    child: const Text(
                      'Don\'t have an account? Sign Up',
                      style: TextStyle(
                          fontFamily: 'Quattrocento',
                          fontSize: 17,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          )),
      // ?
      //     :  Container(
      //   padding: EdgeInsets.only(top: 20),
      //   width: double.infinity,
      //   height: double.infinity,
      //   decoration: const BoxDecoration(
      //     image: DecorationImage(
      //       image: AssetImage("assets/images/girl_background.jpg"),
      //       fit: BoxFit.cover,
      //     ),
      //   ),
      //
      // ),
    );
  }

  static dialogconfirmBox(String titlle, String texte, VoidCallback clickb,
      BuildContext context, var resetController) {
    return AwesomeDialog(
      // dialogBackgroundColor: Colors.amberAccent,
      btnOkText: "Send",
      showCloseIcon: true,
      btnOkColor: Colors.amber,
      btnCancelColor: Colors.amber,
      context: context,
      dialogType: DialogType.INFO,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Reset Password',
      desc: '.............',
      // customHeader: TextField(),
      body: Center(
        child: Column(
          children: [
            const Text(
              "Reset Password",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.9,
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey.withOpacity(.3),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                child: TextField(
                  controller: resetController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      fillColor: Colors.white,
                      border: InputBorder.none,
                      hintText: "Email.."),
                ),
              ),
            ),
          ],
        ),
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (resetController.text.toString().trim().isEmpty) {
          CommonWdget.toastShow("Email field should not b empty!");
        } else {
          clickb();

          //  Get.back();

          // Get.snackbar("Link", "a Password Link has been sent to ${_resetController.text}",backgroundColor: Colors.amber,colorText: Colors.black,
          // icon: Icon(Icons.error), isDismissible: true);
        }
      },
    )..show();
  }
}
