// ignore_for_file: unused_field

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/pages/Get_started_page/GetStardedController.dart';
import '../stage_of_life.dart';

class GetStartedScreen extends StatefulWidget {
  GetStartedScreen({Key? key}) : super(key: key);

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final GetStartedController _signupcontroller =
      Get.put(GetStartedController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/girl_background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(),
                  //background is blur but due to bg image, it cant be seen
                  BlurryContainer(
                    // padding: EdgeInsets.only(left: 10,right: 10),
                    height: MediaQuery.of(context).size.height / 3,
                    color: Colors.white10,

                    blur: 25,
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: Image.asset('assets/images/icon.png'),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              '"quotation is a handy thing to have about, saving one the trouble of thinking for oneself, always a laborious business."',
                              style: TextStyle(
                                fontFamily: 'Quattrocento',
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    // color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      // color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   color: Colors.blue,
                      //   width: 1,
                      // ),
                    ),
                    // ignore: deprecated_member_use

                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: const Stage_of_life(
                                nextpageaddress: "catagoriesPage"),
                            duration: const Duration(milliseconds: 1000),
                          ),
                        );
                        // Navigator.push(
                        //   context,
                        //   PageTransition(
                        //     type: PageTransitionType.fade,
                        //     child: const DailyReminder(),
                        //     duration: const Duration(milliseconds: 1000),
                        //   ),
                        // );
                        // Navigator.pushNamed(context, '/stage_of_life');
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(133, 118, 47, 3),
                          borderRadius: BorderRadius.circular(10),
                          // border: Border.all(
                          //   color: Colors.blue,
                          //   width: 1,
                          // ),
                        ),
                        child: const Text(
                          "Get Started",
                          style: TextStyle(
                            fontFamily: 'Quattrocento',
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
