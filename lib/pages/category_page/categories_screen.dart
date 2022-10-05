// ignore_for_file: unused_local_variable, sized_box_for_whitespace, avoid_unnecessary_containers, non_constant_identifier_names

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/pages/profile_screen.dart';
import 'package:positify_project/pages/quotes_screen.dart';
import 'package:positify_project/pages/support.dart';

import '../../businessLogic/illustrationBG.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List images = [
      'assets/categories_images/Group 4712.png',
      'assets/categories_images/Group 4730.png',
      'assets/categories_images/Group 4727.png',
      'assets/categories_images/Group 4741.png',
      'assets/categories_images/Group 4732.png',
      'assets/categories_images/Group 4728.png'
    ];
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
    Illustration artwork = Illustration(illustrationBG, imageCaption);

    Widget tripCategiry = StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('stagesoflife').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error in receiving data: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Expanded(
                  child: Container(
                      height: 700,
                      child:
                          const Text('Not connected to the Stream or null')));

            case ConnectionState.waiting:
              return Container(
                  height: Get.height / 1.1,
                  child: const Text('Awaiting for interaction'));

            case ConnectionState.active:
              // print("Stream has started but not finished");

              var totalCategories = 0;
              List<DocumentSnapshot> tripCategiry;

              if (snapshot.hasData) {
                tripCategiry = snapshot.data!.docs;
                totalCategories = tripCategiry.length;

                if (totalCategories > 0) {
                  return
                      // GridView.count(
                      //   childAspectRatio: (1.1 / .7),
                      //   primary: false,
                      //   padding: const EdgeInsets.all(6),
                      //   crossAxisSpacing: 20,
                      //   mainAxisSpacing: 15,
                      //   crossAxisCount: 2,
                      //   children: <Widget>[
                      //     cat_widget(context, artwork, imageCaption)
                      //   ],
                      // );

                      Container(
                    height: Get.height / 1.1,
                    child: GridView.builder(
                        itemCount: totalCategories,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        primary: false,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 1.3, crossAxisCount: 2),
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                              padding: const EdgeInsets.all(10),
                              child: InkWell(
                                  onTap: () {
                                    // CommonWdget.toastShow(
                                    //     tripCategiry[index]['art']);
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: QuotesScreen(
                                          artwork.bgIllustrations[0],
                                          illustration_:
                                              artwork.bgIllustrations[0],
                                          name: tripCategiry[index]['name'],
                                          category_image: tripCategiry[index]
                                              ['art'],
                                        ),
                                        duration:
                                            const Duration(milliseconds: 1000),
                                      ),
                                    );
                                  },
                                  child: cat_widget(
                                      context,
                                      artwork,
                                      tripCategiry[index]['name'],
                                      tripCategiry[index]['image'])));
                        }),
                  );
                }
              }

              return Center(
                  child: Column(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                  ),
                  Text(
                    "No trip Categiry found.",
                  )
                ],
              ));

            case ConnectionState.done:
              return const Center(child: Text('Streaming is done'));
          }
        });
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text(
            'Categories',
            style: TextStyle(fontFamily: 'Quattrocento', color: Colors.black),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: const ProfileScreen(),
                  duration: const Duration(milliseconds: 1000),
                ),
              );
              // Navigator.pushNamed(context, '/profile_screen');
            },
            child: Container(
              padding: const EdgeInsets.all(9.0),
              margin: const EdgeInsets.only(top: 8, left: 8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/profile_bg.jpeg'),
                  )),
              child: const ImageIcon(
                AssetImage(
                  'assets/acc_option/circle-user.png',
                ),
                // size: 11,
                color: Colors.white,
              ),
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                // print(imageCaption[0]);
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: const Support(),
                    duration: const Duration(milliseconds: 1000),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.only(top: 8, right: 8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/profile_bg1.png'),
                        fit: BoxFit.contain)),
                child: const ImageIcon(
                  AssetImage('assets/acc_option/Group 4711.png'),
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 120,
          ),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/girl_background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: BlurryContainer(
            padding: const EdgeInsets.only(top: 25, left: 10, right: 10),
            blur: 40,
            color: Colors.white.withOpacity(0.1),
            width: MediaQuery.of(context).size.width,
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(40)),
            child: Container(
              child: Column(
                children: <Widget>[
                  tripCategiry,
                ],
              ),
            ),
            // GridView.count(
            //   childAspectRatio: (1.1 / .7),
            //   primary: false,
            //   padding: const EdgeInsets.all(6),
            //   crossAxisSpacing: 20,
            //   mainAxisSpacing: 15,
            //   crossAxisCount: 2,
            //   children: <Widget>[cat_widget(context, artwork, imageCaption)],
            // ),
          ),
        ),
      ),
    );
  }

  cat_widget(context, artwork, name, image) {
    return Container(
      // height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(.6),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ImageIcon(
              size: MediaQuery.of(context).size.height / 25,
              NetworkImage(
                image.toString(),
              ),
            ),
          ),
          Text(
            name.toString(),
            style: TextStyle(
                fontFamily: 'Quattrocento',
                fontSize: MediaQuery.of(context).size.width / 26),
          ),
        ],
      ),
    );
  }
}
