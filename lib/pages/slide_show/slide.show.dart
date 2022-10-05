import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:positify_project/Models/Quotes.dart';
import 'package:positify_project/businessLogic/QuotesByCategories.dart';
import 'package:positify_project/common_methods/common_methods.dart';
import 'package:positify_project/common_widgets/CommonWidgets.dart';
import 'package:positify_project/pages/Get_started_page/GetStardedController.dart';
import 'package:positify_project/services/firebase_service/authentication.dart';

// import '../services/firebase_service/firestore.dart';

class SlideShowScreen extends StatefulWidget {
  const SlideShowScreen({Key? key, required this.bg, required this.name})
      : super(key: key);
  final String bg;
  final String name;
  @override
  State<SlideShowScreen> createState() => _SlideShowScreenState();
}

class _SlideShowScreenState extends State<SlideShowScreen> {
  int index = 0;
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  bool tapAgain = false;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    // index = QuoteByCategories().illustrationBG.indexOf(args);
    return Scaffold(
      // drawer: SizedBox(
      //     width: MediaQuery.of(context).size.width * 0.85,
      //     child: Drawer(
      //         backgroundColor: Colors.white, child: Drawerr.drawerr(context))),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                CommonWdget.confirmBox(
                    "Logout", "Are you sure you wanna loout?", () {
                  AuthServices.logOutUser();
                });
              },
              icon: const Icon(Icons.logout))
        ],
        backgroundColor: Colors.transparent,
        elevation: 1,
        title: Text(
          "Slide Show",
          // Illustration.categories[Illustration.images.indexOf(args)].toString(),
          style:
              const TextStyle(fontFamily: 'Quattrocento', color: Colors.white),
        ),
        // leading: InkWell(
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        //   child: const Padding(
        //     padding: EdgeInsets.all(8.0),
        //     child: Icon(
        //       Icons.arrow_back_ios_new_rounded,
        //       color: Colors.white,
        //       size: 19,
        //     ),
        //   ),
        // ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/background_splash.jpg'),
              fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: BlurryContainer(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                color: Colors.white38,
                blur: 6,
                child: Text(
                  Quotes.listQuotes[index]['name']
                      // QuoteByCategories.categoriesAndQuotes[index][quoteIndex]
                      .toString(),
                  style: const TextStyle(
                      fontFamily: 'Quattrocento',
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: BlurryContainer(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                color: Colors.white38,
                blur: 6,
                child: Text(
                  '"' +
                      Quotes.listQuotes[index]['author']
                          // QuoteByCategories.categoriesAndQuotes[index][quoteIndex]
                          .toString() +
                      '"',
                  style: const TextStyle(
                      fontFamily: 'Quattrocento',
                      color: Colors.black,
                      fontSize: 21,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                    onPressed: () {
                      if (index > 0) {
                        setState(() {
                          index = index - 1;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 50,
                    ),
                    label: Text(
                      "",
                    )),
                SizedBox(
                  width: 50,
                ),
                TextButton.icon(
                    onPressed: () {
                      print(Quotes.listQuotes.length);
                      print(Quotes.listQuotes);
                      if (index < Quotes.listQuotes.length - 1) {
                        setState(() {
                          index = index + 1;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                      size: 50,
                    ),
                    label: Text(""))
              ],
            )
          ],
        ),
      ),
      // bottomNavigationBar: Obx(
      //   (() => BottomNavigationBar(
      //         currentIndex: _currentIndex,
      //         selectedItemColor: Colors.white,
      //         unselectedItemColor: Colors.white.withOpacity(0.5),
      //         elevation: 0,
      //         items: [
      //           const BottomNavigationBarItem(
      //               backgroundColor: Colors.black54,
      //               icon: Icon(Icons.home),
      //               label: 'Home'),
      //           BottomNavigationBarItem(
      //               backgroundColor: Colors.black54,
      //               icon: InkWell(
      //                   onTap: () {
      //                     CommonMethodst.onShareWithResult(
      //                         context,
      //                         "",
      //                         '"' +
      //                             Quotes.quote_name +
      //                             '"' +
      //                             "\nAuthor:" +
      //                             Quotes.quote_auther,
      //                         "subject");
      //                   },
      //                   child: const Icon(Icons.share)),
      //               label: 'Share'),
      //           BottomNavigationBarItem(
      //               backgroundColor: Colors.black54,
      //               icon: checkFriens() != true
      //                   ? InkWell(
      //                       onTap: () {
      //                         CommonWdget.toastShow("Already add");
      //                       },
      //                       child: const Icon(
      //                         Icons.favorite,
      //                         color: Colors.red,
      //                       ),
      //                     )
      //                   : InkWell(
      //                       onTap: () {
      //                         var faveData = {
      //                           "name": Quotes.quote_name,
      //                           "cat": Quotes.quote_cat,
      //                           "author": Quotes.quote_auther,
      //                         };

      //                         checkFriens()
      //                             ? FirestoreMethods.updateActivities(
      //                                 faveData)
      //                             : CommonWdget.toastShow("Already add");
      //                       },
      //                       child: const Icon(Icons.favorite_outline)),
      //               label: 'Favourite'),
      //           const BottomNavigationBarItem(
      //               backgroundColor: Colors.black54,
      //               icon: Icon(Icons.arrow_back),
      //               label: 'Back'),
      //           const BottomNavigationBarItem(
      //               backgroundColor: Colors.black54,
      //               icon: Icon(Icons.arrow_forward),
      //               label: 'Next'),
      //         ],
      //         onTap: (i) {
      //           setState(() {
      //             _currentIndex = i;
      //             if (_currentIndex == 2) {
      //               bool l = (QuoteByCategories
      //                               .isCategoriesAndQuotesFavourite[index]
      //                           [quoteIndex] ==
      //                       false
      //                   ? true
      //                   : false);
      //               QuoteByCategories.makeItFavQuote(index, quoteIndex, l);
      //               print(QuoteByCategories
      //                   .isCategoriesAndQuotesFavourite[index]);
      //             }
      //             // if(_currentIndex==2)
      //             if (_currentIndex == 4) {
      //               if (QuoteByCategories
      //                           .categoriesAndQuotes[index][quoteIndex]
      //                           .length -
      //                       1 >
      //                   quoteIndex) {
      //                 quoteIndex++;
      //               } else {
      //                 quoteIndex = 0;
      //               }
      //             } else if (_currentIndex == 3) {
      //               if (quoteIndex <=
      //                       QuoteByCategories
      //                               .categoriesAndQuotes[index][quoteIndex]
      //                               .length -
      //                           1 &&
      //                   quoteIndex > 0) {
      //                 quoteIndex--;
      //               } else {
      //                 quoteIndex = QuoteByCategories
      //                         .categoriesAndQuotes[index][quoteIndex].length -
      //                     1;
      //               }
      //             }
      //             // else if (_currentIndex == 0) {
      //             //   Navigator.push(
      //             //     context,
      //             //     PageTransition(
      //             //       type: PageTransitionType.fade,
      //             //       child: const CategoriesScreen(),
      //             //
      //             //       duration: const Duration(milliseconds: 500),
      //             //     ),
      //             //   );
      //             // }

      //             // print(_currentIndex);
      //           });
      //         },
      //       )),
      // )
    );
  }

  // bool checkFriens() {
  //   bool a = false;
  //   for (var map in Get.find<GetStartedController>().fav_quotes.value) {
  //     if (map?.containsKey("email") ?? false) {
  //       if (map!["name"] == Quotes.quote_name) {
  //         print("^^^^^^^^Present^^^^^^^^^^");
  //         a = true;
  //         // your list of map contains key "id" which has value 3
  //       }
  //     }
  //   }

  //   return a;
//  }
}

















// // ignore_for_file: unused_field, prefer_interpolation_to_compose_strings, avoid_print

// import 'package:blurrycontainer/blurrycontainer.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:positify_project/Models/Quotes.dart';
// import 'package:positify_project/businessLogic/QuotesByCategories.dart';
// import 'package:positify_project/common_methods/common_methods.dart';
// import 'package:positify_project/common_widgets/CommonWidgets.dart';
// import 'package:positify_project/pages/Get_started_page/GetStardedController.dart';
// import 'package:positify_project/pages/drawer/drawer.dart';
// import 'package:positify_project/services/firebase_service/authentication.dart';

// import '../../services/firebase_service/firestore.dart';

// class SlideShowScreen extends StatefulWidget {
//   const SlideShowScreen({Key? key}) : super(key: key);
//   @override
//   State<SlideShowScreen> createState() => _SlideShowScreenState();
// }

// class _SlideShowScreenState extends State<SlideShowScreen> {
//   final GetStartedController _controller = Get.put(GetStartedController());
//   int _currentIndex = 0;
//   int quoteIndex = 0;
//   int index = 0;
//   // List images = [
//   //   '1.png',
//   //   '2.png',
//   //   '3.png',
//   //   '4.png',
//   //   '5.png',
//   //   '6.png',
//   //   '7.png',
//   //   '8.png',
//   // ];
//   @override
//   void initState() {
//     setState(() {});
//     super.initState();
//   }

//   bool tapAgain = false;
//   @override
//   Widget build(BuildContext context) {
//     final args = ModalRoute.of(context)!.settings.arguments as dynamic;
//     index = QuoteByCategories().illustrationBG.indexOf(args);
//     return Scaffold(
//         drawer: SizedBox(
//             width: MediaQuery.of(context).size.width * 0.85,
//             child: Drawer(
//                 backgroundColor: Colors.white,
//                 child: Drawerr.drawerr(context))),
//         extendBodyBehindAppBar: true,
//         appBar: AppBar(
//           actions: [
//             IconButton(
//                 onPressed: () {
//                   CommonWdget.confirmBox(
//                       "Logout", "Are you sure you wanna loout?", () {
//                     AuthServices.logOutUser();
//                   });
//                 },
//                 icon: const Icon(Icons.logout))
//           ],
//           backgroundColor: Colors.transparent,
//           elevation: 1,
//           title: Text(
//             "Slide Show",
//             // Illustration.categories[Illustration.images.indexOf(args)].toString(),
//             style: const TextStyle(
//                 fontFamily: 'Quattrocento', color: Colors.white),
//           ),
//           // leading: InkWell(
//           //   onTap: () {
//           //     Navigator.pop(context);
//           //   },
//           //   child: const Padding(
//           //     padding: EdgeInsets.all(8.0),
//           //     child: Icon(
//           //       Icons.arrow_back_ios_new_rounded,
//           //       color: Colors.white,
//           //       size: 19,
//           //     ),
//           //   ),
//           // ),
//         ),
//         body: Container(
//           decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: AssetImage('assets/images/background_splash.jpg'),
//                 fit: BoxFit.cover),
//           ),
//           child: Stack(
//             children: [
//               Container(
//                 // alignment: Alignment.center,
//                 // height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100),
//                   image: DecorationImage(
//                       image: AssetImage(args),
//                       // image: AssetImage("assets/Artwork/"+images[imagesIndex]),
//                       fit: BoxFit.contain),
//                 ),
//               ),
//               InkWell(
//                 onTap: () {
//                   CommonMethodst.onShareWithResult(
//                       context, "", Quotes.quote_name, "subject");
//                 },
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       alignment: Alignment.center,
//                       child: BlurryContainer(
//                         padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
//                         color: Colors.white38,
//                         blur: 6,
//                         child: Text(
//                           Quotes.quote_name
//                               // QuoteByCategories.categoriesAndQuotes[index][quoteIndex]
//                               .toString(),
//                           style: const TextStyle(
//                               fontFamily: 'Quattrocento',
//                               color: Colors.black,
//                               fontSize: 21,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       alignment: Alignment.center,
//                       child: BlurryContainer(
//                         padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
//                         color: Colors.white38,
//                         blur: 6,
//                         child: Text(
//                           '"${Quotes.quote_auther}"',
//                           style: const TextStyle(
//                               fontFamily: 'Quattrocento',
//                               color: Colors.black,
//                               fontSize: 21,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         bottomNavigationBar: Obx(
//           (() => BottomNavigationBar(
//                 currentIndex: _currentIndex,
//                 selectedItemColor: Colors.white,
//                 unselectedItemColor: Colors.white.withOpacity(0.5),
//                 elevation: 0,
//                 items: [
//                   const BottomNavigationBarItem(
//                       backgroundColor: Colors.black54,
//                       icon: Icon(Icons.home),
//                       label: 'Home'),
//                   BottomNavigationBarItem(
//                       backgroundColor: Colors.black54,
//                       icon: InkWell(
//                           onTap: () {
//                             CommonMethodst.onShareWithResult(
//                                 context,
//                                 "",
//                                 '"' +
//                                     Quotes.quote_name +
//                                     '"' +
//                                     "\nAuthor:" +
//                                     Quotes.quote_auther,
//                                 "subject");
//                           },
//                           child: const Icon(Icons.share)),
//                       label: 'Share'),
//                   BottomNavigationBarItem(
//                       backgroundColor: Colors.black54,
//                       icon: checkFriens() == true
//                           ? InkWell(
//                               onTap: () {
//                                 CommonWdget.toastShow("Already add");
//                               },
//                               child: const Icon(
//                                 Icons.favorite,
//                                 color: Colors.red,
//                               ),
//                             )
//                           : InkWell(
//                               onTap: () {
//                                 var faveData = {
//                                   "name": Quotes.quote_name,
//                                   "cat": Quotes.quote_cat,
//                                   "author": Quotes.quote_auther,
//                                 };
//                                 FirestoreMethods.updateActivities(faveData);
//                               },
//                               child: const Icon(Icons.favorite_outline)),
//                       label: 'Favourite'),
//                   const BottomNavigationBarItem(
//                       backgroundColor: Colors.black54,
//                       icon: Icon(Icons.arrow_back),
//                       label: 'Back'),
//                   const BottomNavigationBarItem(
//                       backgroundColor: Colors.black54,
//                       icon: Icon(Icons.arrow_forward),
//                       label: 'Next'),
//                 ],
//                 onTap: (i) {
//                   setState(() {
//                     _currentIndex = i;
//                     if (_currentIndex == 2) {
//                       bool l = (QuoteByCategories
//                                       .isCategoriesAndQuotesFavourite[index]
//                                   [quoteIndex] ==
//                               false
//                           ? true
//                           : false);
//                       QuoteByCategories.makeItFavQuote(index, quoteIndex, l);
//                       // print(QuoteByCategories
//                       //     .isCategoriesAndQuotesFavourite[index]);
//                     }
//                     // if(_currentIndex==2)
//                     if (_currentIndex == 4) {
//                       if (QuoteByCategories
//                                   .categoriesAndQuotes[index][quoteIndex]
//                                   .length -
//                               1 >
//                           quoteIndex) {
//                         quoteIndex++;
//                       } else {
//                         quoteIndex = 0;
//                       }
//                     } else if (_currentIndex == 3) {
//                       if (quoteIndex <=
//                               QuoteByCategories
//                                       .categoriesAndQuotes[index][quoteIndex]
//                                       .length -
//                                   1 &&
//                           quoteIndex > 0) {
//                         quoteIndex--;
//                       } else {
//                         quoteIndex = QuoteByCategories
//                                 .categoriesAndQuotes[index][quoteIndex].length -
//                             1;
//                       }
//                     }
//                     // else if (_currentIndex == 0) {
//                     //   Navigator.push(
//                     //     context,
//                     //     PageTransition(
//                     //       type: PageTransitionType.fade,
//                     //       child: const CategoriesScreen(),
//                     //
//                     //       duration: const Duration(milliseconds: 500),
//                     //     ),
//                     //   );
//                     // }

//                     // print(_currentIndex);
//                   });
//                 },
//               )),
//         ));
//   }

//   bool checkFriens() {
//     bool a = false;
//     for (var map in Get.find<GetStartedController>().fav_quotes) {
//       if (map?.containsKey("name") ?? false) {
//         if (map!["name"] == Quotes.quote_name) {
//           print("^^^^^^^^Present^^^^^^^^^^");
//           a = true;
//           // break;
//           // your list of map contains key "id" which has value 3
//         }
//       }
//     }

//     return a;
//   }
// }
