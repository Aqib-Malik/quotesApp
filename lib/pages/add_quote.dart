// ignore_for_file: use_key_in_widget_constructors

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../services/firebase_service/firestore.dart';

class AddQuote extends StatefulWidget {
  @override
  State<AddQuote> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddQuote> {
  TextEditingController quotecontroller = TextEditingController();
  TextEditingController authercontroller = TextEditingController();

  final formkey1 = GlobalKey<FormState>();
  String textUpdated = 'Select the theme of your quote';
  bool isChecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
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
        title: const Text(
          "Add Quote",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Quattrocento',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/girl_background.jpg'),
                  fit: BoxFit.cover),
            ),
            child: BlurryContainer(
              child: SizedBox(
                // padding: EdgeInsets.zero,
                // width: MediaQuery.of(context).size.width * 0.45,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Get.height / 3.6),
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text("Add Quote Your own Quote",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.black,
                                fontFamily: 'Quattrocento',
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: formkey1,
                            child: Column(
                              children: [
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'must enter quote';
                                    }
                                    return null;
                                  },
                                  controller: quotecontroller,

                                  // keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: 'Add your own quote here',
                                    hintStyle: TextStyle(
                                      fontFamily: 'Quattrocento',
                                    ),
                                  ),
                                ),
                                TextFormField(
                                  keyboardType: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'must enter authername';
                                    }
                                    return null;
                                  },
                                  controller: authercontroller,

                                  // keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(
                                      fontFamily: 'Quattrocento',
                                    ),
                                    hintText: 'Author\'s name',
                                  ),
                                ),
                                ListTile(
                                  leading: DropdownButton<String>(
                                    hint: SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          1.9,
                                      child: Text(
                                        textUpdated.toString(),
                                        style: const TextStyle(
                                          fontFamily: 'Quattrocento',
                                        ),
                                      ),
                                    ),
                                    items: getDropdownItems(),
                                    onChanged: (value) {
                                      setState(() {
                                        textUpdated = value.toString();
                                      });
                                      // print(value);
                                    },
                                  ),
                                ),
                                ListTile(
                                  leading: Checkbox(
                                      activeColor:
                                          const Color.fromARGB(133, 118, 47, 3),
                                      value: isChecked,
                                      onChanged: (val) {
                                        setState(() {
                                          isChecked = !isChecked;
                                        });
                                      }),
                                  title: const Text(
                                    'Make it Visible to everyone',
                                    style:
                                        TextStyle(fontFamily: 'Quattrocento'),
                                  ),
                                ),
                                ButtonTheme(
                                  // minWidth: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      if (formkey1.currentState!.validate()) {
                                        FirestoreMethods.addQuote({
                                          'author': authercontroller.text,
                                          'cat': textUpdated.toString(),
                                          'name': quotecontroller.text,
                                          'fav': [],
                                          // 'uid': "qwe"
                                          // 'uid': descontroller.text,
                                        });
                                        FocusScope.of(context).unfocus();
                                      }

                                      // Navigator.push(
                                      //   context,
                                      //   PageTransition(
                                      //     type: PageTransitionType.fade,
                                      //     child: const ForumMain(),
                                      //
                                      //     duration:
                                      //     const Duration(milliseconds: 500),
                                      //   ),
                                      // );
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          133, 118, 47, 3), //<-- SEE HERE
                                    ),
                                    child: const Text(
                                      'Upload',
                                      style: TextStyle(
                                          fontFamily: 'Quattrocento',
                                          color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropdownItems() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    List<String> stages = [
      "Recovering from life hardship",
      "Recovering from a heartbreak",
      "Self-improvement and reaching goals",
      "Spirituality experience",
      "Inspirational stories",
      "Parenthood challenges",
      "Learning difficulties",
    ];
    for (String stage in stages) {
      var newDropdown = DropdownMenuItem(
        value: stage,
        child: SizedBox(width: 200, child: Text(stage)),
      );

      dropDownItems.add(newDropdown);
    }
    return dropDownItems;
  }
}
