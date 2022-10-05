// ignore_for_file: camel_case_types

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/pages/category_page/categories_screen.dart';
import 'package:positify_project/pages/daily_quote_reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Stage_of_life extends StatefulWidget {
  const Stage_of_life({Key? key, required this.nextpageaddress})
      : super(key: key);
  final nextpageaddress;
  @override
  State<Stage_of_life> createState() => _Stage_of_lifeState();
}

class _Stage_of_lifeState extends State<Stage_of_life> {
  List<String> subscribedStages = [];
  List stages = [
    "Recovering from life hardship",
    "Recovering from a heartbreak",
    "Self-improvement and reaching goals",
    "Spirituality experience",
    "Inspirational stories",
    "Parenthood challenges",
    "Learning difficulties",
  ];
  List checkedDays = [false, false, true, false, true, false, false];
  bool isChecked = false;
  List check = [false, false, false, false, false, false, false, false];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        backgroundColor: Colors.transparent,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.white,
            size: 19,
          ),
        ),
        title: Text(
          "Which stage of life are you in",
          style: TextStyle(
            // fontSize: 16,
            fontSize: MediaQuery.of(context).size.width / 22,
            color: Colors.white,
            fontFamily: 'Quattrocento',
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.fromLTRB(15, 20, 15, 8),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/girl_background.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Spacer(flex: 2),
            // const Text(
            //   "Which stage of life are you in",
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: 'Quattrocento',
            //     fontSize: 16
            //   ),
            // ),
            const Spacer(flex: 1),
            Column(
              children: List.generate(
                stages.length,
                (index) => SizedBox(
                  height: 70,
                  child: Container(
                    margin: const EdgeInsets.only(top: 10),
                    child: BlurryContainer(
                      padding: const EdgeInsets.only(top: 0),
                      color: Colors.white10,
                      blur: 25,
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: MediaQuery.of(context).size.height / 18,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      child: ListTile(
                          // contentPadding: EdgeInsets.only(bottom: 1),
                          leading: const Image(
                            height: 25,
                            image: AssetImage(
                              'assets/images/logo.png',
                            ),
                          ),
                          title: Text(
                            stages[index],
                            style: const TextStyle(
                                fontFamily: 'Quattrocento',
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          trailing: Checkbox(
                            side: const BorderSide(
                                color: Color.fromARGB(133, 118, 47, 3),
                                width: 2),
                            activeColor: const Color.fromARGB(133, 118, 47, 3),
                            checkColor: Colors.white,
                            value: check.elementAt(index),
                            onChanged: (val) {
                              setState(() {
                                check[index] = val;
                              });
                              if (val!) {
                                if (!subscribedStages.contains(stages[index])) {
                                  subscribedStages.add(stages[index]);
                                }
                              } else {
                                subscribedStages.remove(stages[index]);
                              }
                            },
                          )),
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            // SizedBox(height: 2,),

            InkWell(
              onTap: () async {
                // print(subscribedStages.toList());
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setStringList("my_subscription", subscribedStages);
                if (widget.nextpageaddress == "catagoriesPage") {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const CategoriesScreen(),
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                } else {
                  if (pref.getStringList("my_subscription") != null &&
                      pref.getStringList("my_subscription")!.isNotEmpty) {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: const DailyReminder(),
                        duration: const Duration(milliseconds: 1000),
                      ),
                    );
                  } else {
                    final snackBar = SnackBar(
                        content: Text(
                            "Select atleast one of these catagories to continue"));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }

                //  Navigator.pushNamed(context, '/categories_screen');
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
                  "Continue",
                  style: TextStyle(
                      fontFamily: 'Quattrocento',
                      color: Colors.white,
                      fontSize: 18),
                ),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
