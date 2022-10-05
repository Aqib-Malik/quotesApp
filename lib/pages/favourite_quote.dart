import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:positify_project/common_widgets/CommonWidgets.dart';
import 'package:positify_project/pages/Get_started_page/GetStardedController.dart';
import '../services/firebase_service/firestore.dart';

class FavourateQuotes extends StatefulWidget {
  const FavourateQuotes({Key? key}) : super(key: key);

  @override
  State<FavourateQuotes> createState() => _FavourateQuotesState();
}

class _FavourateQuotesState extends State<FavourateQuotes> {
  final GetStartedController _controller = Get.put(GetStartedController());
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
              'Favourites',
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
        body: Obx(
          () => Container(
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
                          image:
                              AssetImage("assets/images/girl_background.jpg"),
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
                            children: List.generate(
                                _controller.fav_quotes.length, (index) {
                              return favWidget(index, _controller.fav_quotes);
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
          ),
        ));
  }

  favWidget(index, fav) {
    return InkWell(
      onTap: () {
        CommonWdget.confirmBox(
            "remove", "Are u sure u wanna remove this quote?", () {
          var faveData = {
            "name": fav[index]['name'],
            "cat": fav[index]['cat'],
            "author": fav[index]['author'],
          };
          FirestoreMethods.removeFav(faveData);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 8, bottom: 8),
        decoration: const BoxDecoration(
          color: Color(0xfff2efd8),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: ListTile(
          leading: const Image(
            height: 35,
            image: AssetImage("assets/images/icon.png"),
          ),
          title: Text(
            fav[index]['name'].toString(),
            style: TextStyle(
                fontFamily: 'Quattrocento',
                fontSize: MediaQuery.of(context).size.width / 23),
          ),
          trailing: const Image(
            height: 35,
            image: AssetImage("assets/images/icon.png"),
          ),
        ),
      ),
    );
  }
}
