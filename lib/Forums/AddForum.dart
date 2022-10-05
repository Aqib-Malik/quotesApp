// ignore_for_file: use_key_in_widget_constructors

import 'dart:io';

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:positify_project/Forums/uploadbuttonstatus.dart';
import 'package:positify_project/common_widgets/CommonWidgets.dart';
import 'package:positify_project/services/firebase_service/authentication.dart';
import 'package:positify_project/services/firebase_service/firestore.dart';

import '../pages/Get_started_page/GetStardedController.dart';

class AddForum extends StatefulWidget {
  @override
  State<AddForum> createState() => _AddQuoteState();
}

class _AddQuoteState extends State<AddForum> {
  static File? imagee;
  String? imagelink;
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String textUpdated = 'Select the theme of your forum';
  bool isChecked = true;
  final updatebuttonstatus = Get.put(uploadingButton());
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
          "Add Post",
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Quattrocento',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                            child: Text("Add Post",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontFamily: 'Quattrocento',
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(14.0),
                                  child: TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'must enter description';
                                      }
                                      return null;
                                    },
                                    controller: descriptionController,

                                    // keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      hintText: 'Description',
                                      hintStyle: TextStyle(
                                        fontFamily: 'Quattrocento',
                                      ),
                                    ),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton.icon(
                                      onPressed: () async {
                                        final picker = ImagePicker();

                                        await picker
                                            .getImage(
                                                source: ImageSource.camera)
                                            .then((value) async {
                                          imagee = await compressFile(
                                              File(value!.path));
                                          //   .then((value) async {
                                          // await FirebaseStorage.instance
                                          //     .ref()
                                          //     .child("ForumImages")
                                          //     .putFile(value!)
                                          //     .then((uploadeddetails) async {
                                          //   if (uploadeddetails.isBlank!) {
                                          //     print(
                                          //         "uploaded details are blank ");
                                          //   } else {
                                          //     imagelink =
                                          //         await uploadeddetails.ref
                                          //             .getDownloadURL();
                                          //     print(imagelink);
                                          //   }
                                          // });
                                          // });
                                        });

                                        //CommonMethodst.imagee=image as Future<File>?;
                                      },
                                      icon: const Icon(
                                        Icons.camera_alt,
                                        color: Color(0xFFF23E5C),
                                      ),
                                      label: const Text(
                                        "Camera",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(133, 118, 47, 3),
                                        ),
                                      ),
                                    ),
                                    TextButton.icon(
                                      onPressed: () async {
                                        final picker = ImagePicker();

                                        await picker
                                            .getImage(
                                                source: ImageSource.gallery)
                                            .then((value) async {
                                          imagee = await compressFile(
                                              File(value!.path));
                                        });
                                        //       .then((value) async {
                                        //     await FirebaseStorage.instance
                                        //         .ref()
                                        //         .child("ForumImages")
                                        //         .child(
                                        //             Timestamp.now().toString())
                                        //         .putFile(value!)
                                        //         .then((uploadeddetails) async {
                                        //       if (uploadeddetails.isBlank!) {
                                        //         print(
                                        //             "uploaded details are blank ");
                                        //       } else {
                                        //         imagelink =
                                        //             await uploadeddetails.ref
                                        //                 .getDownloadURL();
                                        //         print(imagelink);
                                        //       }
                                        //     });
                                        //   });
                                        // });
                                        //CommonMethodst.imagee=image as Future<File>?;
                                      },
                                      icon: const Icon(
                                        Icons.image,
                                        color: Color(0xFF58C472),
                                      ),
                                      label: const Text(
                                        "Picture",
                                        style: TextStyle(
                                          color:
                                              Color.fromARGB(133, 118, 47, 3),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                ButtonTheme(
                                  // minWidth: double.infinity,
                                  child: OutlinedButton(
                                    onPressed: () {
                                      if (updatebuttonstatus
                                          .isbuttonpressed.isFalse) {
                                        updatebuttonstatus
                                            .isbuttonpressed.value = true;
                                        if (textUpdated !=
                                            "Select the theme of your forum") {
                                          if (imagee == null &&
                                              descriptionController.text ==
                                                  "") {
                                            CommonWdget.toastShow(
                                                "Incomplete data");
                                            updatebuttonstatus
                                                .isbuttonpressed.value = false;
                                          } else {
                                            if (imagee != null) {
                                              uploadStorage(
                                                      imagee, "ForumImages")
                                                  .whenComplete(() {
                                                final postjson = {
                                                  "cat": textUpdated,
                                                  "description":
                                                      descriptionController.text
                                                          .trim()
                                                          .toString(),
                                                  "fav": [],
                                                  "image": imagelink.toString(),
                                                  "reported by": [],
                                                  "total comments":
                                                      0.toString(),
                                                  "user name": Get.find<
                                                          GetStartedController>()
                                                      .name
                                                      .value
                                                      .toString(),
                                                  "user profile": Get.find<
                                                          GetStartedController>()
                                                      .image
                                                      .value,
                                                  "publishingTime":
                                                      DateTime.now(),
                                                };
                                                FirestoreMethods.addForum(
                                                        postjson)
                                                    .whenComplete(() {
                                                  imagelink = null;
                                                  descriptionController.clear();
                                                  FocusScope.of(context)
                                                      .unfocus();
                                                });
                                                imagelink = null;
                                                imagee = null;
                                                descriptionController.clear();
                                                FocusScope.of(context)
                                                    .unfocus();
                                              });
                                              updatebuttonstatus.isbuttonpressed
                                                  .value = false;
                                            } else {
                                              final postjson = {
                                                "cat": textUpdated,
                                                "description":
                                                    descriptionController.text
                                                        .trim()
                                                        .toString(),
                                                "fav": [],
                                                "image": "no image",
                                                //  imagelink == null
                                                //     ? "no image"
                                                //     : imagelink.toString(),
                                                "reported by": [],
                                                "total comments": 0.toString(),
                                                "user name": Get.find<
                                                        GetStartedController>()
                                                    .name
                                                    .value
                                                    .toString(),
                                                "user profile": Get.find<
                                                        GetStartedController>()
                                                    .image
                                                    .value,
                                                "publishingTime":
                                                    DateTime.now(),
                                              };
                                              FirestoreMethods.addForum(
                                                      postjson)
                                                  .whenComplete(() {
                                                imagelink = null;
                                                imagee = null;
                                                descriptionController.clear();
                                                FocusScope.of(context)
                                                    .unfocus();
                                              });
                                              updatebuttonstatus.isbuttonpressed
                                                  .value = false;
                                            }
                                          }
                                        } else {
                                          CommonWdget.toastShow(
                                              "select category");
                                          updatebuttonstatus
                                              .isbuttonpressed.value = false;
                                        }
                                      } else {
                                        CommonWdget.toastShow(
                                            "content is uploading");
                                      }
                                    },
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          133, 118, 47, 3), //<-- SEE HERE
                                    ),
                                    child: Obx(
                                      () => Text(
                                        updatebuttonstatus
                                                .isbuttonpressed.isTrue
                                            ? 'loading..'
                                            : 'Upload',
                                        style: TextStyle(
                                            fontFamily: 'Quattrocento',
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ),
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

  uploadStorage(image, childname) async {
    await FirebaseStorage.instance
        .ref()
        .child("childname")
        .child(Timestamp.now().toString())
        .putFile(image!)
        .then((uploadeddetails) async {
      if (uploadeddetails.isBlank!) {
        print("uploaded details are blank ");
      } else {
        imagelink = await uploadeddetails.ref.getDownloadURL();
        print(imagelink);
      }
    });
  }

  Future<File?> compressFile(File file) async {
    File compressedFile = await FlutterNativeImage.compressImage(
      file.path,
      percentage: 80,
      // targetHeight: 500,
      // targetWidth: 700,
      quality: 80,
    );
    return compressedFile;
  }
}
