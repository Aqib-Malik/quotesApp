// ignore_for_file: dead_code

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:positify_project/services/firebase_service/firestore.dart';

class AddReview extends StatefulWidget {
  const AddReview({Key? key}) : super(key: key);

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  final formkey1 = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool isButtonEnable = true;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Add Review',
              style: TextStyle(fontFamily: 'Quattrocento', color: Colors.black),
            ),
            centerTitle: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);

                // Navigator.pushNamed(context, '/quote_screen');
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
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
                    borderRadius: BorderRadius.circular(0),
                    image: const DecorationImage(
                        image: AssetImage("assets/images/girl_background.jpg"),
                        fit: BoxFit.cover)),
              ),
              Container(
                padding: const EdgeInsets.only(top: 120),
                decoration: const BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage("assets/images/girl_background.jpg"),
                    //   fit: BoxFit.cover,
                    // ),
                    ),
                child: BlurryContainer(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(40)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Form(
                            key: formkey1,
                            child: Column(
                              children: [
                                TextFormField(
                                  // controller: email,
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'must enter title';
                                    }
                                    return null;
                                  },
                                  controller: titlecontroller,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 10, 10, 10),
                                      hintText: "Title",
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Quattrocento',
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  controller: descontroller,
                                  minLines: 10,
                                  maxLines: 20,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.transparent,
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          20, 10, 10, 10),
                                      hintText: "Discription",
                                      hintStyle: const TextStyle(
                                        fontFamily: 'Quattrocento',
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          borderSide: const BorderSide(
                                              color: Colors.white, width: 1)),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (formkey1.currentState!.validate()) {
                                FirestoreMethods.addReview({
                                  'title': titlecontroller.text,
                                  'description': descontroller.text,
                                });
                                FocusScope.of(context).unfocus();
                              }
                            },
                            child: Container(
                              width: 150,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isButtonEnable
                                    ? const Color.fromARGB(133, 118, 47, 3)
                                    : Colors.white10,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  'Post Review',
                                  style: TextStyle(
                                      fontFamily: 'Quattrocento',
                                      fontSize: 17,
                                      color: isButtonEnable
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
