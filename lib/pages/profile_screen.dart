// ignore_for_file: deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/Forums/AddForum.dart';
import 'package:positify_project/Forums/forumView.dart';
import 'package:positify_project/common_methods/common_methods.dart';
import 'package:positify_project/pages/EditProfile/edit_profile.dart';
import 'package:positify_project/pages/add_quote.dart';
import 'package:positify_project/pages/change_password.dart';
import 'package:positify_project/pages/daily_quote_reminder.dart';
import 'package:positify_project/pages/forum_main.dart';
import 'package:positify_project/pages/help.dart';
import 'package:positify_project/pages/stage_of_life.dart';
import 'package:positify_project/pages/support.dart';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:positify_project/pages/terms_conditions.dart';
import 'package:positify_project/services/firebase_service/authentication.dart';
import 'package:positify_project/services/firebase_service/firestore.dart';
import '../common_widgets/CommonWidgets.dart';
import 'Get_started_page/GetStardedController.dart';
import 'privacy_policy.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();

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
                      hintText: "password.."),
                ),
              ),
            ),
          ],
        ),
      ),
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        if (resetController.text.toString().trim().isEmpty) {
          CommonWdget.toastShow("password field should not b empty!");
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

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController passcontroller = TextEditingController();
  TextEditingController checkpasscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
            padding: const EdgeInsets.only(
                top: 5, left: 26.0, right: 26, bottom: 26),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child:
                              Get.find<GetStartedController>().image.value == ""
                                  ? CircleAvatar(
                                      backgroundColor: Colors.grey.shade300,
                                      radius: 45,
                                      child: ImageIcon(
                                        AssetImage(
                                          'assets/acc_option/circle-user.png',
                                        ),
                                        size: 50,
                                        color: Colors.black,
                                      ),
                                    )
                                  : ClipOval(
                                      child: CachedNetworkImage(
                                      imageUrl: Get.find<GetStartedController>()
                                          .image
                                          .value,
                                      width: 90,
                                      height: 90,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) =>
                                          Image.asset('assets/loading.gif',
                                              fit: BoxFit.cover),
                                      fadeOutCurve: Curves.easeInOutCubic,
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Get.find<GetStartedController>().name.value,
                                style: const TextStyle(
                                  fontFamily: 'Quattrocento',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                Get.find<GetStartedController>().email.value ==
                                            "" ||
                                        Get.find<GetStartedController>()
                                                .email
                                                .value ==
                                            "not mentioned"
                                    ? "Guest"
                                    : Get.find<GetStartedController>()
                                        .email
                                        .value
                                        .toString(),
                                style: const TextStyle(
                                  fontFamily: 'Quattrocento',
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Personalize Your App',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Quattrocento',
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.pushNamed(context, '/forum_main');
                  //   },
                  //   child: ListTile(
                  //     leading: SizedBox(
                  //       width: 25,
                  //       height: 25,
                  //       child: Icon(
                  //         Icons.content_paste_go,
                  //         size: 28,
                  //         color: Color(0xff346E70),
                  //       ),
                  //     ),
                  //     title: Text('Forum'),
                  //   ),
                  // ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const Stage_of_life(
                              nextpageaddress: "notificationScreen"),
                          duration: const Duration(milliseconds: 1000),
                        ),
                      );
                    },
                    // onTap: () {
                    //   Navigator.pushNamed(context, '/daily_reminder');
                    // },
                    leading: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset('assets/acc_option/Group 4744.png'),
                    ),
                    title: const Text('Manage Notifications',
                        style: TextStyle(
                          fontFamily: 'Quattrocento',
                        )),
                  ),
                  // ListTile(
                  //   leading: SizedBox(
                  //     width: 25,
                  //     height: 25,
                  //     child: Image.asset(
                  //         'assets/acc_option/Group 4745.png'),
                  //   ),
                  //   title: const Text('Widgets'),
                  // ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Support Us',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Quattrocento',
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      CommonMethodst.onShareWithResult(
                          context,
                          "",
                          "i there! Check out this app for inspiring quote: http:// ",
                          "Positify");
                    },
                    leading: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset('assets/acc_option/Path 12103.png'),
                    ),
                    title: const Text('Share Positify',
                        style: TextStyle(
                          fontFamily: 'Quattrocento',
                        )),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/add_review');
                    },
                    leading: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset('assets/acc_option/Path 12104.png'),
                    ),
                    title: const Text('Leave a review',
                        style: TextStyle(
                          fontFamily: 'Quattrocento',
                        )),
                  ),
                  ListTile(
                    onTap: () {
                      Get.to(EditProfileView());
                      // Navigator.pushNamed(context, '/add_review');
                    },
                    leading: SizedBox(
                      width: 25,
                      height: 25,
                      child: Icon(Icons.edit),
                    ),
                    title: const Text('Edit Profile',
                        style: TextStyle(
                          fontFamily: 'Quattrocento',
                        )),
                  ),
                  // ListTile(
                  //   onTap: () {
                  //     if (Get.find<GetStartedController>().is_primeuser.value) {
                  //       Get.to(AddForum());
                  //       // Navigator.pushNamed(
                  //       //     context, '/forum_main',
                  //       //     arguments: widget.illustration_
                  //       //     // PageTransition(
                  //       //     //   type: PageTransitionType.fade,
                  //       //     //   child: IllustrationScreen(
                  //       //     //     bg: '' + illustration_,
                  //       //     //   ),
                  //       //     //
                  //       //     //   duration: const Duration(
                  //       //     //       milliseconds: 500),
                  //       //     // ),
                  //       //     );
                  //     } else {
                  //       CommonWdget.toastShow("You are not a prime user");
                  //       Navigator.push(
                  //         context,
                  //         PageTransition(
                  //           type: PageTransitionType.fade,
                  //           child: const Support(),
                  //           duration: const Duration(milliseconds: 1000),
                  //         ),
                  //       );
                  //     }
                  //   },
                  //   leading: const SizedBox(
                  //     width: 25,
                  //     height: 25,
                  //     child: Icon(Icons.forum),
                  //   ),
                  //   title: const Text('Add Forum',
                  //       style: TextStyle(
                  //         fontFamily: 'Quattrocento',
                  //       )),
                  // ),

                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: const Support(),
                          duration: const Duration(milliseconds: 1000),
                        ),
                      );
                      // Navigator.pushNamed(context, '/support');
                    },
                    leading: const SizedBox(
                      width: 25,
                      height: 25,
                      child: ImageIcon(
                        AssetImage('assets/acc_option/Group 4711.png'),
                        color: Color.fromARGB(133, 118, 47, 3),
                        size: 30,
                      ),
                      // child: Image.asset('assets/acc_option/Group 4746.png'),
                    ),
                    title: const Text('Support Us',
                        style: TextStyle(
                          fontFamily: 'Quattrocento',
                        )),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Your Collection',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Quattrocento',
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: AddQuote(),
                          duration: const Duration(milliseconds: 1000),
                        ),
                      );
                    },
                    leading: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset('assets/acc_option/Group 4742.png'),
                    ),
                    title: const Text(
                      'Add your own quote',
                      style: TextStyle(
                        fontFamily: 'Quattrocento',
                      ),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/favourite_quote');
                    },
                    leading: SizedBox(
                      width: 25,
                      height: 25,
                      child: Image.asset('assets/acc_option/Path 12110.png'),
                    ),
                    title: const Text('Favourite',
                        style: TextStyle(
                          fontFamily: 'Quattrocento',
                        )),
                  ),
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.workspace_premium,
                  //     size: 28,
                  //     color: const Color.fromARGB(133, 118, 47, 3),
                  //   ),
                  //   title: const Text(
                  //     'Become a Premium Member',
                  //     style: TextStyle(
                  //       fontFamily: 'Quattrocento',
                  //     ),
                  //   ),
                  // ),
                  const Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Text(
                      'Other settings',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        fontFamily: 'Quattrocento',
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(ChangePassword());

                      // ProfileScreen.dialogconfirmBox(
                      //     "Change Password", "Enter Password", () {
                      // FirestoreMethods.changePassword(passcontroller.text);
                      // }, context, passcontroller);
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8),
                        child: Row(
                          children: const [
                            Icon(Icons.lock_reset),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Change password',
                              style: TextStyle(
                                fontFamily: 'Quattrocento',
                              ),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      CommonWdget.confirmBox(
                          "Log Out", "Are u sure you want to Log out ?", () {
                        AuthServices.logOutUser();
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0, top: 8),
                      child: Row(
                        children: const [
                          Icon(Icons.logout),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Log out',
                            style: TextStyle(
                              fontFamily: 'Quattrocento',
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  InkWell(
                    onTap: () {
                      Get.to(const Help());
                    },
                    child: Padding(
                        padding: const EdgeInsets.only(left: 16.0, top: 8),
                        child: Row(
                          children: const [
                            Icon(Icons.help_outline_sharp),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Help',
                              style: TextStyle(
                                fontFamily: 'Quattrocento',
                              ),
                            ),
                          ],
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const PrivacyPolicy());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 10),
                      child: Text(
                        'Privacy Policy',
                        style: TextStyle(
                          fontFamily: 'Quattrocento',
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(const TermsCondition());
                    },
                    child: const Padding(
                      padding: EdgeInsets.only(left: 16.0, top: 8),
                      child: Text(
                        'Terms and Conditions',
                        style: TextStyle(
                          fontFamily: 'Quattrocento',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
