import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:positify_project/Models/Quotes.dart';
import 'package:positify_project/businessLogic/QuotesByCategories.dart';
import 'package:positify_project/common_widgets/CommonWidgets.dart';
import 'package:positify_project/Forums/forumView.dart';
import 'package:positify_project/pages/EditProfile/edit_profile.dart';
import 'package:positify_project/pages/slide_show/slide.show.dart';
import 'package:positify_project/pages/support.dart';

import 'Get_started_page/GetStardedController.dart';

class QuotesScreen extends StatefulWidget {
  const QuotesScreen(
    illustration, {
    Key? key,
    required this.illustration_,
    required this.name,
    required this.category_image,
  }) : super(key: key);

  final dynamic illustration_;
  final String name;
  final String category_image;

  @override
  State<QuotesScreen> createState() => _QuotesScreenState();
}

class _QuotesScreenState extends State<QuotesScreen> {
  // List<String> quotes = [
  List<String> illustrationBG = [
    'assets/Artwork/Life hardships.jpg',
    'assets/Artwork/Heartbreak.png',
    'assets/Artwork/Life goals.jpg',
    'assets/Artwork/Spirituality.jpg',
    'assets/Artwork/Inspiring storie.png',
    'assets/Artwork/Parenthood.JPG',
    'assets/Artwork/Learning Difficulty.jpg',
  ];

  List<String> imageCaption = [
    "Recovering from life hardship",
    "Recovering from a heartbreak",
    "Self-improvement and reaching goals",
    "Spirituality experience",
    "Inspirational stories",
    "Parenthood challenges",
    "Learning difficulties",
  ];
  String dropdownvalue = 'Filter by subcategory';

  // List of items in our dropdown menu
  var items = [
    'Filter by subcategory',
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
  ];
  final List<Category> _categories = [
    Category(id: 1, name: "Category 1"),
    Category(id: 2, name: "Category 2"),
    Category(id: 3, name: "Category 3"),
    Category(id: 4, name: "Category 4"),
    Category(id: 5, name: "Category 5"),
  ];

  var show = false;
  var selectAll = false;

  @override
  void initState() {
    super.initState();
    Quotes.listQuotes = [];
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        show = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    PaginateRefreshedChangeListener refreshChangeListener =
        PaginateRefreshedChangeListener();
    // print(widget.illustration_);

    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              widget.name.toString(),
              style: const TextStyle(
                  fontFamily: 'Quattrocento', color: Colors.white),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) => ForumView(),
                // ));
                // Navigator.pushNamed(context, '/quote_screen');
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: Colors.white,
                  size: 19,
                ),
              ),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/background_splash.jpg'),
            fit: BoxFit.cover,
          )),
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image:
                            // AssetImage(widget.illustration_)
                            NetworkImage(
                                this.widget.category_image.toString()))),
              ),
              if (show)
                Container(
                  padding: const EdgeInsets.only(top: 110),
                  decoration: const BoxDecoration(
                      // image: DecorationImage(
                      //   image: AssetImage("assets/images/girl_background.jpg"),
                      //   fit: BoxFit.cover,
                      // ),
                      ),
                  child: BlurryContainer(
                    blur: 5,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(40)),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        children: [
                          //  Padding(
                          //   padding: EdgeInsets.all(8.0),
                          //   child: Text(
                          //     artwork.bgTitle[index].toString(),
                          //     style: TextStyle(
                          //       fontFamily: 'Quattrocento',
                          //       fontSize: MediaQuery.of(context).size.width/26
                          //     ),
                          //   ),
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 0, bottom: 5, left: 4, right: 4),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Expanded(
                                  // flex: 3,
                                  child: ButtonTheme(
                                    // minWidth: double.infinity,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: OutlinedButton(
                                        onPressed: () {
                                          // Quotes.listQuotes = listQuote;
                                          Get.to(
                                            SlideShowScreen(
                                              bg: '',
                                              name: '',
                                            ),
                                          );
                                          // Navigator.pushNamed(
                                          //     context, '/illustration_screen',
                                          //     arguments: widget.illustration_
                                          //     // PageTransition(
                                          //     //   type: PageTransitionType.fade,
                                          //     //   child: IllustrationScreen(
                                          //     //     bg: '' + illustration_,
                                          //     //   ),
                                          //     //
                                          //     //   duration: const Duration(
                                          //     //       milliseconds: 500),
                                          //     // ),
                                          //     );
                                        },
                                        style: OutlinedButton.styleFrom(
                                          backgroundColor: const Color.fromARGB(
                                              133, 118, 47, 3), //<-- SEE HERE
                                        ),
                                        child: Text(
                                          'Slide Show',
                                          style: TextStyle(
                                              fontFamily: 'Quattrocento',
                                              color: Colors.white,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  27),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  // flex: 1,
                                  child: ButtonTheme(
                                    // minWidth: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        if (Get.find<GetStartedController>()
                                                .is_primeuser
                                                .value ==
                                            true) {
                                          Get.to(ForumView(
                                            name: this.widget.name,
                                            category_image:
                                                this.widget.category_image,
                                          ));
                                          // Navigator.pushNamed(
                                          //     context, '/forum_main',
                                          //     arguments: widget.illustration_
                                          //     // PageTransition(
                                          //     //   type: PageTransitionType.fade,
                                          //     //   child: IllustrationScreen(
                                          //     //     bg: '' + illustration_,
                                          //     //   ),
                                          //     //
                                          //     //   duration: const Duration(
                                          //     //       milliseconds: 500),
                                          //     // ),
                                          //     );
                                        } else {
                                          if (Get.find<GetStartedController>()
                                                  .name
                                                  .value ==
                                              "not mentioned") {
                                            CommonWdget.toastShow(
                                                "UserName is mandatory for prime user");
                                            Get.to(EditProfileView());
                                          } else {
                                            CommonWdget.toastShow(
                                                "You are not a prime user");
                                            Navigator.push(
                                              context,
                                              PageTransition(
                                                type: PageTransitionType.fade,
                                                child: const Support(),
                                                duration: const Duration(
                                                    milliseconds: 1000),
                                              ),
                                            );
                                          }
                                        }
                                      },
                                      style: OutlinedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            133, 118, 47, 3), //<-- SEE HERE
                                      ),
                                      child: Text(
                                        'Members Forum',
                                        style: TextStyle(
                                            fontFamily: 'Quattrocento',
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                30),
                                      ),
                                    ),
                                    // child: OutlinedButton(
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //       context,
                                    //       PageTransition(
                                    //         type: PageTransitionType.fade,
                                    //         child: ForumMain(illustration: illustration_,),
                                    //
                                    //         duration:const Duration(milliseconds: 1000),
                                    //       ),
                                    //     );
                                    //   },
                                    //   style: OutlinedButton.styleFrom(
                                    //     backgroundColor: const Color.fromARGB(
                                    //         133, 118, 47, 3), //<-- SEE HERE
                                    //   ),
                                    //   child: const Text(
                                    //     'Forum',
                                    //     style: TextStyle(
                                    //         fontFamily: 'Quattrocento',
                                    //         color: Colors.white),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.end,
                          //   children: [
                          //     Checkbox(
                          //       activeColor:
                          //           const Color.fromARGB(133, 118, 47, 3),
                          //       side: const BorderSide(
                          //           color: Color.fromARGB(133, 118, 47, 3),
                          //           width: 2),
                          //       // fillColor: MaterialStateProperty.resolveWith(Col),
                          //       // shape: ContinuousRectangleBorder(
                          //       //   borderRadius: BorderRadius.zero
                          //       // ),
                          //       checkColor: Colors.white,
                          //       value: selectAll,
                          //       onChanged: (val) {
                          //         // print("Valeee heeeee" + val.toString());
                          //         setState(() {
                          //           selectAll = val!;
                          //         });
                          //       },
                          //     ),
                          //     const Text(
                          //       'Select All',
                          //       style: TextStyle(
                          //           fontFamily: 'Quattrocento',
                          //           color: Colors.black),
                          //     )
                          //   ],
                          // ),

                          const SizedBox(
                            height: 5,
                          ),

                          // SizedBox(
                          //   width: 250,
                          //   child: MultiSelectDialogField(
                          //     title: const Text(
                          //       'Select Your Category',
                          //       style: TextStyle(
                          //           fontFamily: 'Quattrocento',
                          //           color: Colors.white,
                          //           fontSize: 20),
                          //     ),
                          //     backgroundColor: const Color(0xffb08159),
                          //     decoration: const BoxDecoration(
                          //         color: Color.fromARGB(133, 118, 47, 3),
                          //         borderRadius:
                          //             BorderRadius.all(Radius.circular(5))),
                          //     selectedColor: const Color(0xfff2efd8),
                          //     selectedItemsTextStyle: const TextStyle(
                          //       color: Colors.black,
                          //       fontFamily: 'Quattrocento',
                          //     ),
                          //     buttonText: Text(
                          //       'Filter by subcategory',
                          //       style: TextStyle(
                          //           fontFamily: 'Quattrocento',
                          //           color: Colors.white,
                          //           fontSize:
                          //               MediaQuery.of(context).size.width / 30),
                          //     ),
                          //     buttonIcon:
                          //         const Icon(Icons.arrow_drop_down_outlined),
                          //     items: _categories
                          //         .map((e) => MultiSelectItem(e, e.name!))
                          //         .toList(),
                          //     listType: MultiSelectListType.CHIP,
                          //     onConfirm: (values) {},
                          //     chipDisplay: MultiSelectChipDisplay(
                          //       chipColor:
                          //           const Color.fromARGB(133, 118, 47, 3),
                          //       textStyle: const TextStyle(
                          //           fontFamily: 'Quattrocento',
                          //           color: Colors.white,
                          //           fontSize: 12),
                          //     ),
                          //   ),
                          // ),

                          const Spacer(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                            child: SingleChildScrollView(
                              child: Column(children: [
                                SizedBox(
                                  height: Get.height / 2,
                                  child: RefreshIndicator(
                                    child: PaginateFirestore(
                                      itemBuilder:
                                          (context, documentSnapshots, index) {
                                        Quotes.listQuotes.add({
                                          'name': documentSnapshots[index]
                                                  ['name']
                                              .toString(),
                                          'author': documentSnapshots[index]
                                                  ['author']
                                              .toString(),
                                          'cat': documentSnapshots[index]['cat']
                                              .toString()
                                        });
                                        // print(listQuote);

                                        return InkWell(
                                            onTap: () {
                                              // Get.toNamed('/training-detail', arguments: {
                                              //   "title": documentSnapshots[index]['title'].toString(),
                                              //   "week_plan":
                                              //       documentSnapshots[index]['week_plan'].toString(),
                                              //   "image": documentSnapshots[index]['image'].toString(),
                                              //   "runs_type":
                                              //       documentSnapshots[index]['runs_type'].toString(),
                                              //   "exp_level":
                                              //       documentSnapshots[index]['exp_level'].toString(),
                                              //   "description": documentSnapshots[index]['description']
                                              //       .toString(),
                                              //   "createdAt": documentSnapshots[index]['createdAt']
                                              //       .toDate()
                                              //       .toString(),
                                              // });
                                            },
                                            child:
                                                // Text(""),
                                                InkWell(
                                                    onTap: () {
                                                      Quotes.quote_name =
                                                          documentSnapshots[
                                                                  index]['name']
                                                              .toString();
                                                      Quotes.quote_auther =
                                                          documentSnapshots[
                                                                      index]
                                                                  ['author']
                                                              .toString();
                                                      Quotes.quote_cat =
                                                          documentSnapshots[
                                                                  index]['cat']
                                                              .toString();
                                                      // Quotes.listQuotes =
                                                      //     listQuote;
                                                      // Get.to(IllustrationScreen(
                                                      //     bg: "bg"));
                                                      Navigator.pushNamed(
                                                          context,
                                                          '/illustration_screen',
                                                          arguments: widget
                                                              .illustration_);
                                                    },
                                                    child: quoteWidget(
                                                        "${documentSnapshots[index]['name'].toString()}..."

                                                        // ['name']
                                                        ))
                                            // training_widget(
                                            //     documentSnapshots[index]['image'].toString(),
                                            //     documentSnapshots[index]['week_plan'].toString(),
                                            //     documentSnapshots[index]['title'].toString(), {
                                            //   "title": documentSnapshots[index]['title'].toString(),
                                            //   "week_plan":
                                            //       documentSnapshots[index]['week_plan'].toString(),
                                            //   "image": documentSnapshots[index]['image'].toString(),
                                            //   "runs_type":
                                            //       documentSnapshots[index]['runs_type'].toString(),
                                            //   "exp_level":
                                            //       documentSnapshots[index]['exp_level'].toString(),
                                            //   "description":
                                            //       documentSnapshots[index]['description'].toString(),
                                            //   "createdAt": documentSnapshots[index]['createdAt']
                                            //       .toDate()
                                            //       .toString(),
                                            // })
                                            );
                                      },
                                      query: FirebaseFirestore.instance
                                          .collection('Quotes')
                                          .where("cat", isEqualTo: widget.name),
                                      // .orderBy('createdAt'),
                                      listeners: [
                                        refreshChangeListener,
                                      ],
                                      itemBuilderType:
                                          PaginateBuilderType.listView,
                                      itemsPerPage: 3,
                                      isLive: false,
                                    ),
                                    onRefresh: () async {
                                      refreshChangeListener.refreshed = true;
                                    },
                                  ),
                                ),
                              ]
                                  //  List.generate(
                                  //     QuoteByCategories.categoriesAndQuotes[index]
                                  //         .length, (i) {
                                  //   return quoteWidget(QuoteByCategories
                                  //       .categoriesAndQuotes[index][i]);
                                  // }),
                                  ),
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                )
              else
                Container(),
            ],
          ),
        ));
  }

  /////quote Widget
  ///
  quoteWidget(quote) {
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 8),
      decoration: const BoxDecoration(
        color: Color(0xfff2efd8),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: ListTile(
        leading: const Image(
          height: 35,
          image: AssetImage("assets/images/icon.png"),
        ),
        title: Text(
          quote.toString(),
          // 'Hello World Quote '+(index+1).toString(),
          style: TextStyle(
              fontFamily: 'Quattrocento',
              fontSize: MediaQuery.of(context).size.width / 23),
        ),
        trailing: const Image(
          height: 35,
          image: AssetImage("assets/images/icon.png"),
        ),
      ),
    );
  }
}
