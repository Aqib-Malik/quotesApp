// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api, prefer_interpolation_to_compose_strings, prefer_final_fields, avoid_print

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:positify_project/pages/EditProfile/edit_profile_controller.dart';

import '../../services/firebase_service/firestore.dart';
import '../../services/firebase_service/storage.dart';
import '../Get_started_page/GetStardedController.dart';

// ignore: camel_case_types
class EditProfileView extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

// ignore: camel_case_types
class _EditProfileState extends State<EditProfileView> {
  final EditProfileController editcontroller = Get.put(EditProfileController());
  final GetStartedController controller = Get.put(GetStartedController());
  static void deleteFireBaseStorageItem() {
    var storageReferance = FirebaseStorage.instance.ref();

    storageReferance
        .child('images')
        .child(Get.find<GetStartedController>().email.value.toString() + ".jpg")
        .delete()
        .then((_) => print('Successfully deleted  storage item'));
  }

  File? _image;
  final _formkey = GlobalKey<FormState>();
  Map<String, dynamic>? userInfi;
  TextEditingController _usernamecontroller = TextEditingController(
      text: Get.find<GetStartedController>().name.value.toString());
  TextEditingController _emailcontroller = TextEditingController(
      text: Get.find<GetStartedController>().email.value.toString());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 1,
            title: Text(
              Get.find<GetStartedController>().email.toString(),
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
          child: Center(
              child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 90,
                                child: ClipOval(
                                    child: _image == null
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                Get.find<GetStartedController>()
                                                    .image
                                                    .value
                                                    .toString(),
                                            width: 180,
                                            height: 180,
                                            fit: BoxFit.cover,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 4,
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    const Icon(Icons.error),
                                          )
                                        : Image.file(
                                            _image!,
                                            fit: BoxFit.cover,
                                            width: 180,
                                            height: 180,
                                          )
                                    // :
                                    ),
                              ),
                              Positioned(
                                top: 135,
                                left: 120,
                                child: GestureDetector(
                                    onTap: () async {
                                      _image = await StorageFirebaseServices
                                          .getImage();
                                      setState(() {
                                        _image = _image;
                                      });
                                      // _image =
                                      //     await context.read<AccountProvider>().getImage();
                                      // print("setstate");

                                      // _image =
                                      //     await StorageFirebaseServices.getImage();
                                      // Provider.of<AccountProvider>(context,
                                      //         listen: false)
                                      //     .acSetImg = _image;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                            133, 118, 47, 3), //<-- SEE HERE

                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.image,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    )),
                              ),
                              Positioned(
                                top: 135,
                                right: 120,
                                child: GestureDetector(
                                    onTap: () async {
                                      _image = await StorageFirebaseServices
                                          .getCameraImage();
                                      setState(() {
                                        _image = _image;
                                      });
                                      // _image =
                                      //     await context.read<AccountProvider>().getImage();
                                      // print("setstate");

                                      // _image =
                                      //     await StorageFirebaseServices.getImage();
                                      // Provider.of<AccountProvider>(context,
                                      //         listen: false)
                                      //     .acSetImg = _image;
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(
                                            133, 118, 47, 3), //<-- SEE HERE

                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Icon(
                                          Icons.camera,
                                          color: Colors.white,
                                          size: 25,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 15,
                          ),
                          Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'must enter user name';
                                      }
                                      return null;
                                    },
                                    controller: _usernamecontroller,
                                    //onChanged: onChanged,
                                    cursorColor: Color.fromARGB(
                                        133, 118, 47, 3), //<-- SEE HERE

                                    decoration: InputDecoration(
                                      fillColor: Colors.white,
                                      filled: true,
                                      hintText: '        Name',
                                      suffix: const Icon(Icons.account_box,
                                          color:
                                              Color.fromARGB(255, 136, 78, 24)),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(40.0),
                                      ),
                                      hintStyle: const TextStyle(
                                        color: Color(0xff8ad2d5),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 23,
                                ),
                                // SizedBox(
                                //   width: MediaQuery.of(context).size.width * 0.9,
                                //   child: TextFormField(
                                //     readOnly: true,
                                //     keyboardType: TextInputType.emailAddress,
                                //     validator: (value) {
                                //       if (value == null || value.isEmpty) {
                                //         return 'must enter email address';
                                //       }
                                //       return null;
                                //     },
                                //     controller: _emailcontroller,
                                //     //onChanged: onChanged,
                                //     cursorColor: Color.fromARGB(133, 118, 47, 3),
                                //     decoration: InputDecoration(
                                //       fillColor: Colors.white,
                                //       filled: true,
                                //       hintText: '        Email',
                                //       suffix: const Icon(Icons.email,
                                //           color:
                                //               Color.fromARGB(255, 136, 78, 24)),
                                //       border: OutlineInputBorder(
                                //         borderRadius: BorderRadius.circular(40.0),
                                //       ),
                                //       hintStyle: const TextStyle(
                                //         color: Color(0xff8ad2d5),
                                //       ),
                                //     ),
                                //   ),
                                // ),
                                // const SizedBox(
                                //   height: 23,
                                // ),
                                Obx(
                                  () => Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.white),
                                        color: Color.fromARGB(133, 118, 47, 3),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    width:
                                        MediaQuery.of(context).size.width * 0.7,

                                    //size.width * 0.8,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(29),
                                      // ignore: deprecated_member_use
                                      child: TextButton(
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20, horizontal: 40),
                                          ),

                                          //color: Color(0xFF6F35A5), //(0xFF6F35A5),
                                          onPressed: () async {
                                            if (_formkey.currentState!
                                                .validate()) {
                                              if (_image != null) {
                                                Get.find<
                                                        EditProfileController>()
                                                    .isLoad
                                                    .value = true;
                                                FocusManager
                                                    .instance.primaryFocus!
                                                    .unfocus();
                                                deleteFireBaseStorageItem();
// Delete the file

                                                var imagestatus = await FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child('images')
                                                    .child(Get.find<
                                                                GetStartedController>()
                                                            .email
                                                            .value
                                                            .toString() +
                                                        ".jpg")
                                                    .putFile(
                                                        _image!) //await StorageFirebaseServices.getImage())
                                                    .then((value) => value);
                                                String imageUrl =
                                                    await imagestatus.ref
                                                        .getDownloadURL();
                                                FirestoreMethods.updatePhoto(
                                                    _usernamecontroller.text,
                                                    imageUrl,
                                                    FirebaseAuth.instance
                                                        .currentUser!.email
                                                        .toString());
                                                Get.find<
                                                        EditProfileController>()
                                                    .isLoad
                                                    .value = false;
                                              } else {
                                                Get.find<
                                                        EditProfileController>()
                                                    .isLoad
                                                    .value = true;

                                                FocusManager
                                                    .instance.primaryFocus!
                                                    .unfocus();
                                                FirestoreMethods.updateUserName(
                                                    _usernamecontroller.text,
                                                    FirebaseAuth.instance
                                                        .currentUser!.email
                                                        .toString());
                                                Get.find<
                                                        EditProfileController>()
                                                    .isLoad
                                                    .value = false;
                                              }
                                            } else {
                                              // CommonWdget.toastShow("Admin Can't change credentials");
                                            }
                                          },
                                          child: Get.find<EditProfileController>()
                                                      .isLoad
                                                      .value ==
                                                  false
                                              ? const Text(
                                                  "Update",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                )
                                              : const CircularProgressIndicator(
                                                  color: Colors.white,
                                                )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          //Image.network(_controller.photoUrl),
                          // Text("Name : " + _controller.name,
                          //     style: TextStyle(
                          //         fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(
                            height: 5,
                          ),

                          // Center(
                          //   child: GestureDetector(
                          //     onTap: () async {
                          //       // if (await authServices.checkConnection()) {
                          //       //   // setState(() async {
                          //       //   //   _isloading = true;
                          //       //   // });
                          //       //   if (_image != null) {
                          //       //     Provider.of<IsLoadingProvider>(context,
                          //       //             listen: false)
                          //       //         .setSt = true;
                          //       //     var imagestatus = await FirebaseStorage.instance
                          //       //         .ref()
                          //       //         .child('images')
                          //       //         .child(_controller.email)
                          //       //         .putFile(
                          //       //             _image) //await StorageFirebaseServices.getImage())
                          //       //         .then((value) => value);
                          //       //     String imageUrl =
                          //       //         await imagestatus.ref.getDownloadURL();
                          //       //     authServices.updatePhoto(
                          //       //         imageUrl, _controller.email);
                          //       //     Provider.of<IsLoadingProvider>(context,
                          //       //             listen: false)
                          //       //         .setSt = false;

                          //       //     // /setState(() {

                          //       //     //   _isloading = false;
                          //       //     // });

                          //       //     SomeMethods.toastShow(
                          //       //         "Change Profile Photo successfully");
                          //       //   }
                          //       // } else {
                          //       //   SomeMethods.toastShow(
                          //       //       "Make sure your internet in enabled");
                          //       // }
                          //     },
                          //     child: Padding(
                          //       padding: const EdgeInsets.all(3.0),
                          //       child: SpinKitFadingCircle(
                          //         itemBuilder:
                          //             (BuildContext context, int index) {
                          //           return DecoratedBox(
                          //             decoration: BoxDecoration(
                          //               color: index.isEven
                          //                   ? Colors.white
                          //                   : Colors.amber,
                          //             ),
                          //           );
                          //         },
                          //       ),
                          //     ),
                          //   ),
                          // ),
                        ]),
                  ))),
        ));
  }

  // ignore: unused_element
  // void _showModal() {
  //   showModalBottomSheet<void>(
  //     shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(25.0))),
  //     enableDrag: true,
  //     isScrollControlled: true,
  //     context: context,
  //     builder: (BuildContext context) {
  //       return Card(
  //         color: Colors.white,
  //         child: Container(
  //           height: MediaQuery.of(context).size.height / 3 +
  //               MediaQuery.of(context).viewInsets.bottom,
  //           child: Column(
  //             children: <Widget>[
  //               TextFieldContainer(
  //                 child: TextFormField(
  //                     controller: _updateuserNameController,
  //                     validator: (value) {
  //                       if (value == null || value.isEmpty) {
  //                         return 'Please must enter User Name';
  //                       }
  //                       return null;
  //                     },
  //                     //onChanged: onChanged,
  //                     cursorColor: kPrimaryColor,
  //                     //autofocus: false,
  //                     //readOnly: true,
  //                     decoration: InputDecoration(
  //                       icon: Icon(Icons.account_circle, color: kPrimaryColor),
  //                       hintText: 'userName',
  //                       border: InputBorder.none,
  //                     )),
  //               ),
  //               RoundedButton(
  //                   text: "Update User Name",
  //                   press: () async {
  //                     if (await CommonMethodst.checkConnection()) {
  //                       authServices.updateName(
  //                           _updateuserNameController.text, _controller.email);
  //                       _userNameController.text =
  //                           _updateuserNameController.text;
  //                     } else {
  //                       CommonWdget.toastShow(
  //                           "Make sure Your internet is enabled");
  //                     }
  //                   }),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nikis_app/Views/_controller/_controller.dart';

// class EditProfileView extends StatefulWidget {
//   @override
//   State<EditProfileView> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfileView> {
//   Widget textfield({@required hintText}) {
//     return Material(
//       elevation: 4,
//       shadowColor: Colors.grey,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: TextField(
//         decoration: InputDecoration(
//             hintText: hintText,
//             hintStyle: TextStyle(
//               letterSpacing: 2,
//               color: Colors.black54,
//               fontWeight: FontWeight.bold,
//             ),
//             fillColor: Colors.white30,
//             filled: true,
//             border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide.none)),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0.0,
//         backgroundColor: Color(0xff555555),
//         leading: IconButton(
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             Get.back();
//           },
//         ),
//       ),
//       body: Stack(
//         alignment: Alignment.center,
//         children: [
//           SingleChildScrollView(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SizedBox(height: 200),
//                 Container(
//                   height: 450,
//                   width: double.infinity,
//                   margin: EdgeInsets.symmetric(horizontal: 10),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       //SizedBox(height: 100,),
//                       textfield(
//                         hintText: 'Username',
//                       ),
//                       textfield(
//                         hintText: 'Email',
//                       ),
//                       textfield(
//                         hintText: 'Password',
//                       ),
//                       textfield(
//                         hintText: 'Confirm password',
//                       ),
//                       Container(
//                         height: 55,
//                         width: double.infinity,
//                         // ignore: deprecated_member_use
//                         child: RaisedButton(
//                           onPressed: () {},
//                           color: Colors.black54,
//                           child: Center(
//                             child: Text(
//                               "Update",
//                               style: TextStyle(
//                                 fontSize: 23,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//           CustomPaint(
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height,
//             ),
//             painter: HeaderCurvedContainer(),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: EdgeInsets.all(20),
//                 child: Text(
//                   _controller.name==null?"Profile":_controller.name.toString(),
//                   style: TextStyle(
//                     fontSize: 35,
//                     letterSpacing: 1.5,
//                     color: Colors.white,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               Container(
//                 padding: EdgeInsets.all(10.0),
//                 width: MediaQuery.of(context).size.width / 2,
//                 height: MediaQuery.of(context).size.width / 2,
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white, width: 5),
//                   shape: BoxShape.circle,
//                   color: Colors.white,
//                   image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: NetworkImage(_controller.image.toString()),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 270, left: 184),
//             child: CircleAvatar(
//               backgroundColor: Colors.black54,
//               child: IconButton(
//                 icon: Icon(
//                   Icons.edit,
//                   color: Colors.white,
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

// class HeaderCurvedContainer extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()..color = Color(0xff555555);
//     Path path = Path()
//       ..relativeLineTo(0, 150)
//       ..quadraticBezierTo(size.width / 2, 225, size.width, 150)
//       ..relativeLineTo(0, -150)
//       ..close();
//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) => false;
// }
