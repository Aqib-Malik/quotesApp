import 'dart:io';

import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:positify_project/pages/signup_screen/signup_controller.dart';

import '../Get_started_page/GetStardedController.dart';

class addimage extends StatefulWidget {
  const addimage({Key? key}) : super(key: key);

  @override
  State<addimage> createState() => _addimageState();
}

class _addimageState extends State<addimage> {
  File? _image;
  var imagelink = SignupController.imagelink.value;
  @override
  Widget build(BuildContext context) {
    final sigupcontroller = Get.put(SignupController());
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile Photo',
              style: TextStyle(
                  fontFamily: 'Quattrocento',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        CircleAvatar(
          backgroundColor: Color.fromARGB(150, 247, 160, 45),
          radius: 80,
          child: ClipOval(
              child: imagelink.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: imagelink,
                      width: 160,
                      height: 160,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            strokeWidth: 4,
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.white,
                    )
              // :
              ),
        ),
        SizedBox(
          height: 30,
        ),
        imagelink.isEmpty
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BouncingWidget(
                      scaleFactor: 8,
                      duration: Duration(milliseconds: 100),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 7),
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
                        child: Text(
                          'Camera',
                          style: TextStyle(
                              fontFamily: 'Quattrocento',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        final picker = ImagePicker();

                        await picker
                            .getImage(source: ImageSource.camera)
                            .then((value) async {
                          await SignupController.uploadimage(
                                  await compressFile(File(value!.path)),
                                  "profileImages")
                              .then((value) {
                            setState(() {
                              imagelink = value!;
                            });
                            print("here is the value : $value");
                          });
                        });
                      }),
                  SizedBox(
                    width: 10,
                  ),
                  BouncingWidget(
                      scaleFactor: 8,
                      duration: Duration(milliseconds: 100),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 7),
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
                        child: Text(
                          'Gallery',
                          style: TextStyle(
                              fontFamily: 'Quattrocento',
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                      onPressed: () async {
                        final picker = ImagePicker();

                        await picker
                            .getImage(source: ImageSource.gallery)
                            .then((value) async {
                          await SignupController.uploadimage(
                                  await compressFile(File(value!.path)),
                                  "profileImages")
                              .then((value) {
                            setState(() {
                              imagelink = value!;
                            });
                            print("here is the value : $value");
                          });
                        });
                      })
                ],
              )
            : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  "assets/tick.gif",
                  height: 40,
                )
              ]),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
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

class EnterUserName extends StatefulWidget {
  const EnterUserName({Key? key}) : super(key: key);

  @override
  State<EnterUserName> createState() => _EnterUserNameState();
}

class _EnterUserNameState extends State<EnterUserName> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Enter your name',
              style: TextStyle(
                  fontFamily: 'Quattrocento',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 7,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.2))
              ]),
          child: TextFormField(
            validator: (value) {},
            controller: Get.find<SignupController>().usernamecontroller,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                hintText: "here..",
                hintStyle: const TextStyle(
                  fontFamily: 'Quattrocento',
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
        ),
      ],
    );
  }
}

class UserContactNumber extends StatefulWidget {
  const UserContactNumber({Key? key}) : super(key: key);

  @override
  State<UserContactNumber> createState() => _UserContactNumberState();
}

class _UserContactNumberState extends State<UserContactNumber> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Enter Contact no#',
              style: TextStyle(
                  fontFamily: 'Quattrocento',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
          ],
        ),
        SizedBox(
          height: 12,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 7,
                    offset: const Offset(1, 1),
                    color: Colors.grey.withOpacity(0.2))
              ]),
          child: TextFormField(
            keyboardType: TextInputType.phone,
            validator: (value) {},
            controller: Get.find<SignupController>().contactcontroller,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(20, 10, 10, 10),
                hintText: "i.e (+92) 34...",
                hintStyle: const TextStyle(
                  fontFamily: 'Quattrocento',
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30))),
          ),
        ),
      ],
    );
  }
}
