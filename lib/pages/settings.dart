import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'login_screen/loginView.dart';

class Settings extends StatelessWidget {
  const Settings({Key? key}) : super(key: key);

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
              'Settings',
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
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xfff2efd8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/privacy_policy');
                              },
                              leading: const Image(
                                height: 35,
                                image: AssetImage("assets/images/icon.png"),
                              ),
                              title: Text(
                                "Privacy Policy",
                                style: TextStyle(
                                    fontFamily: 'Quattrocento',
                                    fontSize:
                                        MediaQuery.of(context).size.width / 23),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 25,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xfff2efd8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/terms_conditions');
                              },
                              leading: const Image(
                                height: 35,
                                image: AssetImage("assets/images/icon.png"),
                              ),
                              title: Text(
                                "Terms & Conditions",
                                style: TextStyle(
                                    fontFamily: 'Quattrocento',
                                    fontSize:
                                        MediaQuery.of(context).size.width / 23),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 25,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xfff2efd8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(context, '/help');
                              },
                              leading: const Image(
                                height: 35,
                                image: AssetImage("assets/images/icon.png"),
                              ),
                              title: Text(
                                "Help",
                                style: TextStyle(
                                    fontFamily: 'Quattrocento',
                                    fontSize:
                                        MediaQuery.of(context).size.width / 23),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 25,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xfff2efd8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ListTile(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/change_password');
                              },
                              leading: const Image(
                                height: 35,
                                image: AssetImage("assets/images/icon.png"),
                              ),
                              title: Text(
                                "Change Password",
                                style: TextStyle(
                                    fontFamily: 'Quattrocento',
                                    fontSize:
                                        MediaQuery.of(context).size.width / 23),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 25,
                              )),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xfff2efd8),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          child: ListTile(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.fade,
                                    child: const loginView(),
                                    duration:
                                        const Duration(milliseconds: 1000),
                                  ),
                                );
                              },
                              leading: const Image(
                                height: 35,
                                image: AssetImage("assets/images/icon.png"),
                              ),
                              title: Text(
                                "Log Out",
                                style: TextStyle(
                                    fontFamily: 'Quattrocento',
                                    fontSize:
                                        MediaQuery.of(context).size.width / 23),
                              ),
                              trailing: const Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 25,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
