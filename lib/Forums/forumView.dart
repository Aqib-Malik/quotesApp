import 'package:auto_animated/auto_animated.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:positify_project/Forums/AddForum.dart';
import 'package:positify_project/Forums/ButtomCommentSheet.dart';

class ForumView extends StatefulWidget {
  const ForumView({Key? key, required this.name, required this.category_image})
      : super(key: key);
  final String name;
  final String category_image;

  @override
  State<ForumView> createState() => _ForumViewState();
}

class _ForumViewState extends State<ForumView> {
  final options = LiveOptions(
    // Start animation after (default zero)
    delay: Duration(seconds: 1),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 500),

    // Animation duration (default 250)
    showItemDuration: Duration(seconds: 1),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: false,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Get.to(AddForum());
        },
        child: Icon(Icons.add),
      ),
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 1,
          title: Text(
            this.widget.name,
            style: const TextStyle(
                fontFamily: 'Quattrocento', color: Colors.white),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/background_splash.jpg'),
          fit: BoxFit.cover,
        )),
        child: ListView(
          shrinkWrap: true,
          children: [
            dropdownbutton(),
            StreamBuilder<QuerySnapshot>(
                stream: selectedValue == null
                    ? FirebaseFirestore.instance
                        .collection("forum testing")
                        .where("cat", isEqualTo: widget.name.toString())
                        .snapshots()
                    : selectedValue == "Latest"
                        ? FirebaseFirestore.instance
                            .collection("forum testing")
                            .where("cat", isEqualTo: widget.name.toString())
                            .orderBy("publishingTime", descending: true)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("forum testing")
                            .where("fav",
                                arrayContains:
                                    FirebaseAuth.instance.currentUser!.uid)
                            .where("cat", isEqualTo: widget.name.toString())
                            .snapshots(),
                // : FirebaseFirestore.instance
                //     .collection("forum testing")
                //     .where("cat", isEqualTo: widget.name.toString())
                //     .orderBy("fav", descending: true)
                //     .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                          color: Colors.grey.withOpacity(.5)),
                    );
                  }
                  return LiveList(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index, Animation<double> animator) {
                      final DocumentSnapshot curdoc =
                          snapshot.data!.docs[index];
                      return AnimateIfVisible(
                        key: Key(index.toString()),
                        builder: (context, Animation<double> visibleanimator) {
                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: .3,
                              end: 1,
                            ).animate(visibleanimator),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4,
                              ),
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              decoration: const BoxDecoration(
                                color: Color(0xfff2efd8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 25.0,
                                          backgroundColor: Colors.white,
                                          child: ClipOval(
                                            child: curdoc.get("user profile") !=
                                                    ""
                                                ? CachedNetworkImage(
                                                    imageUrl: curdoc
                                                        .get("user profile")
                                                        .toString(),
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                    progressIndicatorBuilder:
                                                        (context, url,
                                                                downloadProgress) =>
                                                            const Center(
                                                      child: Padding(
                                                        padding: EdgeInsets.all(
                                                            16.0),
                                                        child:
                                                            CircularProgressIndicator(),
                                                        // CircularProgressIndicator(

                                                        //     backgroundColor: Colors.white,
                                                        //     strokeWidth: strokeWidth,
                                                        //     value: downloadProgress.progress),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        const Icon(Icons.error),
                                                  )
                                                : const Icon(
                                                    Icons.person,
                                                    color: Colors.grey,
                                                  ),
                                          ),
                                        ),
                                        // Container(
                                        //     height: 60,
                                        //     padding: EdgeInsets.symmetric(
                                        //         horizontal: 5, vertical: 2),
                                        //     decoration: BoxDecoration(
                                        //       border: Border.all(color: Colors.black),
                                        //       shape: BoxShape.circle,
                                        //     ),
                                        //     child: CachedNetworkImage(
                                        //       imageUrl: curdoc.get("user profile"),
                                        //       height: 50,
                                        //       width: 50,
                                        //       fit: BoxFit.cover,
                                        //       progressIndicatorBuilder:
                                        //           (context, url, downloadProgress) =>
                                        //               const Center(
                                        //         child: Padding(
                                        //           padding: EdgeInsets.all(16.0),
                                        //           child: CircularProgressIndicator(),
                                        //           // CircularProgressIndicator(

                                        //           //     backgroundColor: Colors.white,
                                        //           //     strokeWidth: strokeWidth,
                                        //           //     value: downloadProgress.progress),
                                        //         ),
                                        //       ),
                                        //       errorWidget: (context, url, error) =>
                                        //           const Icon(Icons.error),
                                        //     )
                                        //     // Icon(Icons.person),
                                        //     ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              curdoc.get("user name"),
                                              style: const TextStyle(
                                                  fontFamily: 'Quattrocento',
                                                  color: Colors.black),
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Icon(
                                              Icons.people,
                                              size: 16,
                                              color:
                                                  Colors.black.withOpacity(.4),
                                            )
                                          ],
                                        ),
                                        Spacer(),
                                        Icon(
                                          Icons.more_horiz_outlined,
                                          color: Colors.black.withOpacity(.4),
                                          size: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Divider(
                                      thickness: .1,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7),
                                    child: Text(
                                      curdoc.get("description"),
                                      style: const TextStyle(
                                          fontFamily: 'Quattrocento',
                                          color: Colors.black),
                                    ),
                                  ),
                                  if (curdoc.get("image") != "no image")
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                3,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: CachedNetworkImage(
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    'assets/loading.gif',
                                                    fit: BoxFit.cover),
                                            fadeOutCurve: Curves.easeInOutCubic,
                                            placeholderFadeInDuration:
                                                const Duration(
                                                    milliseconds: 200),
                                            imageUrl: curdoc.get(
                                              "image",
                                            ),
                                            fit: BoxFit.cover)),
                                  SizedBox(height: 6),
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                        child: const Icon(Icons.favorite,
                                            color: Colors.white, size: 16),
                                      ),
                                      Text(
                                        "${curdoc.get("fav").length}",
                                        style: const TextStyle(
                                            fontFamily: 'Quattrocento',
                                            color: Colors.black),
                                      ),
                                      Spacer(),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: ButtomModelSheet(
                                                  docid: curdoc.id),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          "${curdoc.get("total comments")} comments",
                                          style: const TextStyle(
                                              fontFamily: 'Quattrocento',
                                              color: Colors.black),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 12,
                                      )
                                    ],
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: .1,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          if (curdoc.get("fav").contains(
                                              FirebaseAuth
                                                  .instance.currentUser!.uid
                                                  .toString())) {
                                            curdoc.reference.update({
                                              "fav": FieldValue.arrayRemove([
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString()
                                              ])
                                            });
                                          } else {
                                            curdoc.reference.update({
                                              "fav": FieldValue.arrayUnion([
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString()
                                              ])
                                            });
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.favorite,
                                                color: curdoc
                                                        .get("fav")
                                                        .contains(FirebaseAuth
                                                            .instance
                                                            .currentUser!
                                                            .uid
                                                            .toString())
                                                    ? Colors.red.withOpacity(.5)
                                                    : Colors.grey
                                                        .withOpacity(.5)),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              "Like",
                                              style: const TextStyle(
                                                  fontFamily: 'Quattrocento',
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType
                                                  .bottomToTop,
                                              child: ButtomModelSheet(
                                                  docid: curdoc.id),
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(Icons.comment,
                                                color: Colors.black
                                                    .withOpacity(.55)),
                                            SizedBox(
                                              width: 7,
                                            ),
                                            Text(
                                              "Comment",
                                              style: const TextStyle(
                                                  fontFamily: 'Quattrocento',
                                                  color: Colors.black),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget dropdownbutton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Row(
            children: const [
              Icon(
                Icons.filter_list_sharp,
                size: 16,
                color: Colors.black,
              ),
              SizedBox(
                width: 4,
              ),
              Expanded(
                child: Text(
                  'Filter',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          items: items
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Row(
                      children: [
                        if (item == "Latest")
                          Icon(Icons.trending_up, color: Colors.amber),
                        if (item == "Favorite")
                          Icon(Icons.favorite, color: Colors.red),
                        if (item == "Famous")
                          Icon(Icons.people,
                              color: Colors.grey.withOpacity(.5)),
                        SizedBox(
                          width: 6,
                        ),
                        Text(
                          item,
                          style: const TextStyle(
                              fontFamily: 'Quattrocento', color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ))
              .toList(),
          value: selectedValue,
          onChanged: (value) {
            print("$value");

            setState(() {
              selectedValue = value as String;
            });
          },
          icon: const Icon(
            Icons.arrow_downward,
            color: Colors.black,
          ),
          iconSize: 14,
          iconEnabledColor: Colors.yellow,
          iconDisabledColor: Colors.grey,
          buttonHeight: 50,
          buttonWidth: 140,
          dropdownDecoration: BoxDecoration(
            color: Color(0xfff2efd8),
          ),
          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
          buttonDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Color(0xfff2efd8),
          ).copyWith(
            boxShadow: kElevationToShadow[2],
          ),
          itemHeight: 50,
          itemPadding: const EdgeInsets.only(left: 14, right: 14),
          dropdownMaxHeight: 200,
          dropdownPadding: null,
          scrollbarRadius: const Radius.circular(40),
          scrollbarThickness: 1,
          scrollbarAlwaysShow: true,
          offset: const Offset(-20, 0),
        ),
      ),
    );
  }

  String? selectedValue;
  final items = [
    'Latest',
    'Favorite',
  ];
}
