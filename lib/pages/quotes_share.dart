import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';

class QuotesShare extends StatelessWidget {
  const QuotesShare({Key? key}) : super(key: key);
  Future<void> share(var title) async {
    await FlutterShare.share(title: title);
  }

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
              'Share Quote',
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
                        Column(
                          children: List.generate(6, (index) {
                            return Container(
                              margin: const EdgeInsets.only(top: 8, bottom: 8),
                              decoration: const BoxDecoration(
                                color: Color(0xfff2efd8),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: ListTile(
                                onTap: () async {
                                  //share Plugin Here
                                  await FlutterShare.share(
                                      title: 'Hello World Quote ${index + 1}');
                                },
                                leading: const Image(
                                  height: 35,
                                  image: AssetImage("assets/images/icon.png"),
                                ),
                                title: Text(
                                  'Hello World Quote ${index + 1}',
                                  style: TextStyle(
                                      fontFamily: 'Quattrocento',
                                      fontSize:
                                          MediaQuery.of(context).size.width /
                                              23),
                                ),
                                trailing: const Image(
                                  height: 35,
                                  image: AssetImage("assets/images/icon.png"),
                                ),
                              ),
                            );
                          }),
                        ),
                        const Spacer(),
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
