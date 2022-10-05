// ignore_for_file: unused_field, unused_element, prefer_typing_uninitialized_variables
import 'dart:async';
import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:get/get.dart';
import 'package:positify_project/pages/category_page/categories_screen.dart';
import 'package:positify_project/pages/splash_screen.dart';
import 'package:positify_project/services/key.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/common_widgets/CommonWidgets.dart';
import 'package:positify_project/pages/stage_of_life.dart';
import 'package:cron/cron.dart';
import '../notifications/notificationhelper.dart';
import '../notifications/local_notification_service.dart';

class DailyReminder extends StatefulWidget {
  const DailyReminder({Key? key}) : super(key: key);

  @override
  State<DailyReminder> createState() => _DailyReminderState();
}

class _DailyReminderState extends State<DailyReminder> {
  late final LocalNotificationService service;
  void listenToNotification() =>
      service.onNotificationClick.stream.listen(onNoticationListener);

  void onNoticationListener(String? payload) async {
    if (payload != null && payload.isNotEmpty) {
      // print('payload $payload');
      CommonWdget.toastShow(payload);
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(,,
      //         builder: ((context) => SecondScreen(payload: payload))));
    }
  }

  String? _selectedTime;
  String? ho, min;
  // We don't need to pass a context to the _show() function
  // You can safety use context as below
  TimeOfDay? result;

  int? hour;

  int? minute;
  Future<void> _show() async {
    await showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((result) {
      print(result.toString().substring(10, 12));
      print(result.toString().substring(13, 15));
      if (result != null) {
        print(result.toString() + "****");
        setState(() {
          hour = result.hour;
          minute = result.minute;
          // _selectedTime = result.format(context);
        });
      }
    });
  }

  final bool _isSelected = false;
  List<String> data = ["Mathew", "Deon", "Sara", "Yeu"];
  List<String> userChecked = [];
  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        selected == !selected;
        // print('asdsa');

        userChecked.add(dataName);
      });
    } else {
      setState(() {
        userChecked.remove(dataName);
      });
    }
  }

  // TimeOfDay selectedTime = TimeOfDay.now();

  List days = [
    "Every day",
    "Every Monday",
    "Every Tuesday",
    "Every Wednesday",
    "Every Thursday",
    "Every Friday",
    "Every Saturday",
    "Every Sunday",
  ];
  List<bool> check = [true, false, false, false, false, false, false, false];
  bool is_everyday_selected = true;
  var _checked;
  @override
  void initState() {
    service = LocalNotificationService();
    service.intialize();
    listenToNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DateTime dt = DateTime.now();
    String h = dt.hour.toString();
    String m = dt.minute.toString();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
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
            "Set daily quote reminder",
            style: TextStyle(
              // fontSize: 16,
              fontSize: MediaQuery.of(context).size.width / 22,
              color: Colors.white,
              fontFamily: 'Quattrocento',
            ),
          ),
        ),
      ),
      body: GestureDetector(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.fromLTRB(25, 50, 35, 8),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/girl_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              //  Text(
              //   "Set daily quote reminder",
              //   style: TextStyle(
              //       fontSize: MediaQuery.of(context).size.width/22,
              //       fontFamily: 'Quattrocento',
              //       color: Colors.black,),
              // ),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(133, 118, 47, 3)),
                    child: const Text(
                      'Timer: ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Quattrocento',
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const Spacer(
                    flex: 4,
                  ),
                  Container(
                    padding: const EdgeInsets.all(7),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(133, 118, 47, 3)),
                    child: GestureDetector(
                      onTap: _show,
                      child: Text(
                        hour != null && minute != null
                            ? "$hour : $minute"
                            : "${DateTime.now().hour} : ${tz.TZDateTime.now(tz.local).minute} ",
                        style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'Quattrocento',
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    for (int i = 0; i < check.length; i++) {
                      check[i] = false;
                    }
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(7),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(133, 118, 47, 3)),
                  child: const Text(
                    'Clear All',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Quattrocento',
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     Container(
              //       padding: const EdgeInsets.all(7),
              //       decoration: const BoxDecoration(color: Colors.white),
              //       child: const Text.rich(
              //         TextSpan(
              //           children: <InlineSpan>[
              //             TextSpan(
              //               text: 'Repeat: ',
              //               style: TextStyle(
              //                   fontSize: 16, fontWeight: FontWeight.w500),
              //             ),
              //             TextSpan(
              //               text: '---',
              //               style: TextStyle(
              //                   fontSize: 16, fontWeight: FontWeight.w500),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              Column(
                children: List.generate(
                    days.length,
                    (index) => index == 0
                        ?

                        //separate every day container
                        Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(top: 5),
                                child: BlurryContainer(
                                  // padding: EdgeInsets.only(top: 10),
                                  padding:
                                      const EdgeInsets.only(top: 3, bottom: 2),
                                  color: Colors.white10,
                                  blur: 25,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  child: ListTile(
                                      leading: Text(
                                        days[0],
                                        style: const TextStyle(
                                            fontFamily: 'Quattrocento',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: Checkbox(
                                        activeColor: const Color.fromARGB(
                                            133, 118, 47, 3),
                                        side: const BorderSide(
                                            color:
                                                Color.fromARGB(133, 118, 47, 3),
                                            width: 2),
                                        // fillColor: MaterialStateProperty.resolveWith(Col),
                                        // shape: ContinuousRectangleBorder(
                                        //   borderRadius: BorderRadius.zero
                                        // ),
                                        checkColor: Colors.white,
                                        value: check.elementAt(index),
                                        onChanged: (val) {
                                          // print("Valeee heeeee" + val.toString());
                                          if (val!) {
                                            setState(() {
                                              check[0] = val;
                                              is_everyday_selected = true;
                                            });
                                          } else {
                                            if (!val) {
                                              setState(() {
                                                check[0] = val;
                                                is_everyday_selected = false;
                                              });
                                            }
                                          }
                                          setState(() {
                                            for (int i = 1;
                                                i < check.length;
                                                i++) {
                                              check[i] = false;
                                            }
                                          });
                                        },
                                      )),
                                ),
                              ),
                              if (is_everyday_selected)
                                Column(
                                  children: const [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    BlurryContainer(
                                      padding: EdgeInsets.all(7),
                                      color: Colors.white10,
                                      blur: 25,
                                      child: Text(
                                        "You will receive notifications on daily basis. To get notification on a particular day in every week uncheck everyday & select days you would like",
                                        style: TextStyle(
                                            fontFamily: 'Quattrocento',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          )
                        : !is_everyday_selected
                            ? Container(
                                margin: const EdgeInsets.only(top: 5),
                                child: BlurryContainer(
                                  // padding: EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.only(top: 3),
                                  color: Colors.white10,
                                  blur: 25,
                                  width:
                                      MediaQuery.of(context).size.width / 1.2,
                                  height:
                                      MediaQuery.of(context).size.height / 18,
                                  child: ListTile(
                                      leading: Text(
                                        days[index],
                                        style: const TextStyle(
                                            fontFamily: 'Quattrocento',
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      trailing: Checkbox(
                                        activeColor: const Color.fromARGB(
                                            133, 118, 47, 3),
                                        side: const BorderSide(
                                            color:
                                                Color.fromARGB(133, 118, 47, 3),
                                            width: 2),
                                        // fillColor: MaterialStateProperty.resolveWith(Col),
                                        // shape: ContinuousRectangleBorder(
                                        //   borderRadius: BorderRadius.zero
                                        // ),
                                        checkColor: Colors.white,
                                        value: check.elementAt(index),
                                        onChanged: (val) {
                                          // print("Valeee heeeee" + val.toString());
                                          setState(() {
                                            check[index] = val!;
                                          });
                                        },
                                      )),
                                ),
                              )
                            : Container()),
              ),
              const SizedBox(
                height: 2,
              ),
              InkWell(
                child: Container(
                  margin: const EdgeInsets.all(7),
                  // child: const Text(
                  //   "Skip for now",
                  //   style: TextStyle(
                  //     fontFamily: 'Quattrocento',
                  //     fontSize: 12,
                  //     color: Colors.blue,
                  //     decoration: TextDecoration.underline,
                  //   ),
                  // ),
                ),
              ),
              InkWell(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  List<String> preferencesList =
                      pref.getStringList("my_subscription")!;
                  var today = DateTime.now();
                  if (hour == null && minute == null) {
                    print(
                        "hours is not selected by user by default it is selected to current time");
                    hour = DateTime.now().hour.toInt();
                    minute = DateTime.now().minute.toInt();
                    print(
                        "here is the selected hour $hour & selected min $minute");
                  }
                  // print(today);
                  // print(today.next(DateTime.monday));

                  if (is_everyday_selected) {
                    //setup notification on daily basis
                    String selectedcatagory = preferencesList
                        .elementAt(Random().nextInt(preferencesList.length));
                    LocalNotificationService().excutingworkmanager(
                        0,
                        "New $selectedcatagory Daily quotes",
                        "To Checkout click here",
                        "$selectedcatagory",
                        "everyday",
                        hour!,
                        minute!,
                        DateTime.now());
                    //print toast that the daily notifications has been successfully scheduled
                    final snackBar = SnackBar(
                        content: Text(
                            "Your regular notification has been scheduled at $hour:$minute"));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else {
                    for (int i = 1; i < check.length; i++) {
                      if (check[i] == true) {
                        String selectedcatagory = preferencesList.elementAt(
                            Random().nextInt(preferencesList.length));
                        if (i == 1) {
                          LocalNotificationService().excutingworkmanager(
                              i,
                              "Weekly $selectedcatagory Quotes",
                              "Tab to view",
                              "$selectedcatagory",
                              "specific",
                              hour!,
                              minute!,
                              today.next(DateTime.monday));
                        } else if (i == 2) {
                          LocalNotificationService().excutingworkmanager(
                              i,
                              "Weekly $selectedcatagory Quotes",
                              "Tab to view",
                              "$selectedcatagory",
                              "specific",
                              hour!,
                              minute!,
                              today.next(DateTime.tuesday));
                        } else if (i == 3) {
                          LocalNotificationService().excutingworkmanager(
                              i,
                              "Weekly $selectedcatagory Quotes",
                              "Tab to view",
                              "$selectedcatagory",
                              "specific",
                              hour!,
                              minute!,
                              today.next(DateTime.wednesday));
                        } else if (i == 4) {
                          LocalNotificationService().excutingworkmanager(
                              i,
                              "Weekly $selectedcatagory Quotes",
                              "Tab to view",
                              "$selectedcatagory",
                              "specific",
                              hour!,
                              minute!,
                              today.next(DateTime.thursday));
                        } else if (i == 5) {
                          LocalNotificationService().excutingworkmanager(
                              i,
                              "Weekly $selectedcatagory Quotes",
                              "Tab to view",
                              "$selectedcatagory",
                              "specific",
                              hour!,
                              minute!,
                              today.next(DateTime.friday));
                        } else if (i == 6) {
                          LocalNotificationService().excutingworkmanager(
                              i,
                              "Weekly $selectedcatagory Quotes",
                              "Tab to view",
                              "$selectedcatagory",
                              "specific",
                              hour!,
                              minute!,
                              today.next(DateTime.saturday));
                        } else if (i == 7) {
                          LocalNotificationService().excutingworkmanager(
                              i,
                              "Weekly $selectedcatagory Quotes",
                              "Tab to view",
                              "$selectedcatagory",
                              "specific",
                              hour!,
                              minute!,
                              today.next(DateTime.sunday));
                        }
                      }
                    }
                    final snackBar = SnackBar(
                        content: Text(
                            "Your weekly notification has been scheduled at  $hour:$minute"));

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }

                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: const CategoriesScreen(),
                      duration: const Duration(milliseconds: 1000),
                    ),
                  );
                  // Navigator.pushNamed(context, '/stage_of_life');
                  //}
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
              )
            ],
          ),
        ),
      ),
    );
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }
}

void testfucntion() {
  print("execute commands");
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    return this.add(
      Duration(
        days: (day - this.weekday) % DateTime.daysPerWeek,
      ),
    );
  }
}
