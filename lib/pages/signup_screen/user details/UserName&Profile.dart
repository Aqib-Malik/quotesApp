import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jelly_anim/jelly_anim.dart';
import 'package:positify_project/pages/signup_screen/SignUpWidgets.dart';

import '../../Get_started_page/get_started_screen.dart';
import '../signup_controller.dart';

class UserNameAndProfile extends StatefulWidget {
  const UserNameAndProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<UserNameAndProfile> createState() => _UserNameAndProfileState();
}

class _UserNameAndProfileState extends State<UserNameAndProfile> {
  List<Widget> all_options = [addimage(), EnterUserName(), UserContactNumber()];
  final onBoardingController = PageController(initialPage: 0);
  int currentpage = 0;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/girl_background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BlurryContainer(
          padding: EdgeInsets.all(0),
          blur: 10,
          child: ListView(
            children: [
              const SizedBox(
                height: 150,
              ),
              Container(
                height: MediaQuery.of(context).size.height / 2.7,
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (current_index) {
                    setState(() {
                      currentpage = current_index;
                    });
                  },
                  controller: onBoardingController,
                  itemCount: all_options.length,
                  itemBuilder: (context, index) =>
                      Center(child: all_options[index]),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    all_options.length, (index) => buildDot(index, context)),
              ),
              SizedBox(
                height: 55,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: JellyAnim(
                        jellyCount: 2,
                        radius: 70,
                        allowOverFlow: true,
                        jellyCoordinates: 5,
                        colors: [
                          Colors.orange,
                          Colors.brown,
                          Colors.amber.withOpacity(.5),
                          Colors.brown[300]!
                        ],
                        viewPortSize: Size.square(300),
                        duration: Duration(seconds: 2),
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (currentpage < 2) {
                    onBoardingController.animateToPage(currentpage + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInSine);
                  } else if (currentpage == 2) {
                    if (Get.find<SignupController>()
                        .usernamecontroller
                        .text
                        .isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .update({
                        "name": Get.find<SignupController>()
                            .usernamecontroller
                            .text
                            .toString()
                            .trim(),
                      });
                    }
                    if (Get.find<SignupController>()
                        .contactcontroller
                        .text
                        .isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .update({
                        "contact": Get.find<SignupController>()
                            .contactcontroller
                            .text
                            .toString()
                            .trim(),
                      });
                    }
                    if (SignupController.imagelink.isNotEmpty) {
                      FirebaseFirestore.instance
                          .collection("users")
                          .doc(FirebaseAuth.instance.currentUser!.email)
                          .update({
                        "imageLink":
                            SignupController.imagelink.value.toString(),
                      });
                    }
                    Get.to(GetStartedScreen());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Center(
                      child: Text(
                    currentpage == 2 ? 'finish' : 'Next',
                    style: TextStyle(
                        fontFamily: 'Quattrocento',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDot(int index, BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 9,
      width: currentpage == index ? 30 : 14,
      margin: const EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: currentpage == index ? Colors.white : Colors.grey),
    );
  }
}
