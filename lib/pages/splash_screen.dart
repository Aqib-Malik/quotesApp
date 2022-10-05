import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../common_methods/common_methods.dart';
import 'category_page/categories_screen.dart';
import 'error_pages/conncion_lost.dart';
import 'Get_started_page/get_started_screen.dart';
import 'login_screen/loginView.dart';

String? finalemail;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future getValidationData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var obtainEmail = sharedPreferences.getString('email');

    finalemail = obtainEmail;

    // print(finalemail.toString());
  }

  void _runWhileAppIsTerminated() async {
    var detailsof = await FlutterLocalNotificationsPlugin()
        .getNotificationAppLaunchDetails();
    if (detailsof!.didNotificationLaunchApp) {
      if (detailsof.payload != null) {
        //payload is the category which is displayed on the notification
        //U can navigate the user to any specific screen and pass the payload as constructor to use it further
        
        Get.to(CategoriesScreen());
      } 
      
      
      
      else {
        getValidationData().whenComplete(() async {
          if (await CommonMethodst.checkConnection()) {
            Timer(const Duration(seconds: 4), () {
              finalemail == null
                  ? Get.offAll(const loginView())
                  : Get.offAll(GetStartedScreen());
              //Get.off(Wellcome());
            });
          } else {
            Get.off(ConnectionLostScreen());
          }
        });
      }
    } else {
      getValidationData().whenComplete(() async {
        if (await CommonMethodst.checkConnection()) {
          Timer(const Duration(seconds: 4), () {
            finalemail == null
                ? Get.offAll(const loginView())
                : Get.offAll(GetStartedScreen());
            //Get.off(Wellcome());
          });
        } else {
          Get.off(ConnectionLostScreen());
        }
      });
    }
  }

  @override
  void initState() {
    _runWhileAppIsTerminated();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.fade,
                isIos: true,
                child: const loginView(),
                duration: const Duration(milliseconds: 1000),
              ),
            );
            // Navigator.push(
            //   context,
            //   PageTransition(
            //     type: PageTransitionType.fade,
            //     child:  loginView(),
            //
            //     duration: const Duration(milliseconds: 5000),
            //   ),
            // );
            // Navigator.pushNamed(context, '/get_started');
          },
          child: Container(
            padding: const EdgeInsets.all(80),
            // color: Colors.red,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background_splash.jpg"),
                  fit: BoxFit.cover),
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Image(
                      height: MediaQuery.of(context).size.height / 11,
                      // width: 120,
                      image: const AssetImage(
                        "assets/images/logo.png",
                      ),
                    ),
                  ),
                  const Text(
                    'Positify',
                    style: TextStyle(
                        fontFamily: 'Charlemagne',
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 5),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
