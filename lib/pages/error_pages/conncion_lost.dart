// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:positify_project/pages/splash_screen.dart';
import '../../common_methods/common_methods.dart';
import '../../common_widgets/CommonWidgets.dart';

class ConnectionLostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/10_Connection Lost.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.12,
            left: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 5),
                    blurRadius: 25,
                    color: const Color(0xFF59618B).withOpacity(0.17),
                  ),
                ],
              ),
              child: TextButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF6371AA)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    )),

                // color: Color(0xFF6371AA),
                onPressed: () async {
                  await CommonMethodst.checkConnection() == true
                      ? Get.to(const SplashScreen())
                      : CommonWdget.toastShow("Please turn on internet!");
                },
                child: Text(
                  "retry".toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
