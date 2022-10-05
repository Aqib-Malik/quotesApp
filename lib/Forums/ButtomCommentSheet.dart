import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:positify_project/pages/Get_started_page/GetStardedController.dart';
import 'package:progressive_image/progressive_image.dart';

class ButtomModelSheet extends StatefulWidget {
  const ButtomModelSheet({Key? key, required this.docid}) : super(key: key);
  final String docid;
  @override
  State<ButtomModelSheet> createState() => _ButtomModelSheetState();
}

class _ButtomModelSheetState extends State<ButtomModelSheet> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2efd8),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 1,
          title: Text(
            "Comments",
            style: const TextStyle(
                fontFamily: 'Quattrocento', color: Colors.white),
          ),
          centerTitle: true,
        ),
      ),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/background_splash.jpg'),
            fit: BoxFit.cover,
          )),
          child: CommentBox(
            userImage: Get.find<GetStartedController>().image.toString(),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: commentdata(widget.docid),
                ),
              ],
            ),
            labelText: 'Write a comment...',
            withBorder: false,
            errorText: 'Comment cannot be blank',
            sendButtonMethod: () async {
              print("send button is pressed");
              if (formKey.currentState!.validate()) {
                var commentdata = {
                  "comment description":
                      commentController.text.trim().toString(),
                  "fav list": [],
                  "user image":
                      Get.find<GetStartedController>().image.toString(),
                  "user name": Get.find<GetStartedController>().name.toString(),
                };
                await FirebaseFirestore.instance
                    .collection("forum testing")
                    .doc(widget.docid)
                    .get()
                    .then((value) {
                  value.reference.update({
                    "total comments":
                        (int.parse(value.get("total comments")) + 1).toString()
                  }).then((nestedvalue) {
                    value.reference
                        .collection("Comments")
                        .add(commentdata)
                        .then((value) {
                      commentController.clear();
                    });
                  });
                });

                FocusScope.of(context).unfocus();
              } else {
                print("Not validated");
              }
            },
            formKey: formKey,
            commentController: commentController,
            backgroundColor: Colors.black,
            textColor: Colors.black,
            sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.black),
          )),
    );
  }

  Widget commentdata(String doc) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("forum testing")
            .doc(doc)
            .collection("Comments")
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator(
              color: Colors.grey.withOpacity(.5),
            );
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              final DocumentSnapshot curdoc = snapshot.data!.docs[index];
              return Container(
                margin: EdgeInsets.only(top: 12),
                child: BlurryContainer(
                    padding: EdgeInsets.all(7),
                    color: Colors.white10,
                    blur: 55,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: ProgressiveImage(
                            blur: 40,
                            fadeDuration: const Duration(milliseconds: 400),
                            placeholder:
                                const AssetImage('assets/images/logo.png'),
                            // size: 1.87KB
                            thumbnail:
                                const AssetImage('assets/images/logo.png'),
                            // size: 1.29MB
                            image: NetworkImage(curdoc.get("user image")),
                            height: 90,
                            width: 70,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BlurryContainer(
                                  blur: 60,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 7),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        curdoc.get("user name"),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Quattrocento',
                                            color: Colors.black),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Text(
                                        curdoc.get("comment description"),
                                        overflow: TextOverflow.clip,
                                        style: const TextStyle(
                                            fontFamily: 'Quattrocento',
                                            color: Colors.black),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      if (curdoc.get("fav list").contains(
                                          FirebaseAuth.instance.currentUser!.uid
                                              .toString())) {
                                        curdoc.reference.update({
                                          "fav list": FieldValue.arrayRemove([
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                                .toString()
                                          ])
                                        });
                                      } else {
                                        curdoc.reference.update({
                                          "fav list": FieldValue.arrayUnion([
                                            FirebaseAuth
                                                .instance.currentUser!.uid
                                                .toString()
                                          ])
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Text(
                                        curdoc.get("fav list").contains(
                                                FirebaseAuth
                                                    .instance.currentUser!.uid
                                                    .toString())
                                            ? "Liked"
                                            : "like",
                                        style: TextStyle(
                                            fontFamily: 'Quattrocento',
                                            color: curdoc
                                                    .get("fav list")
                                                    .contains(FirebaseAuth
                                                        .instance
                                                        .currentUser!
                                                        .uid
                                                        .toString())
                                                ? Colors.red
                                                : Colors.black),
                                      ),
                                    ),
                                  ),
                                  if (curdoc.get("fav list").isNotEmpty)
                                    Row(
                                      children: [
                                        Text(
                                          curdoc
                                              .get("fav list")
                                              .length
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Quattrocento',
                                              color: Colors.black),
                                        ),
                                        SizedBox(
                                          width: 1.3,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 4, vertical: 1),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              shape: BoxShape.circle),
                                          child: const Icon(Icons.favorite,
                                              color: Colors.white, size: 9),
                                        ),
                                      ],
                                    )
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    )),
              );
            },
          );
        });
  }
}
