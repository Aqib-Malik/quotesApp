import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              'Privacy Policy',
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
                  child: Center(
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: MediaQuery.of(context).size.height * 0.8,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(15.0)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(.6),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                      "1. Lorem Ipsum",
                                      style: TextStyle(
                                          fontFamily: 'Quattrocento',
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                      style: TextStyle(
                                          fontFamily: 'Quattrocento',
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                      "2. Lorem Ipsum",
                                      style: TextStyle(
                                          fontFamily: 'Quattrocento',
                                          color: Colors.black,
                                          fontSize: 20),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(14.0),
                                    child: Text(
                                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                                      style: TextStyle(
                                          fontFamily: 'Quattrocento',
                                          color: Colors.black,
                                          fontSize: 16),
                                    ),
                                  ),
                                ],
                              ),
                            ))),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
