// ignore_for_file: unused_field, recursive_getters, unused_element, prefer_typing_uninitialized_variables, unused_local_variable

import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:paginate_firestore/bloc/pagination_listeners.dart';
import 'package:paginate_firestore/paginate_firestore.dart';

class ForumMain extends StatefulWidget {
  const ForumMain({Key? key, required this.illustration}) : super(key: key);
  final dynamic illustration;
  @override
  State<ForumMain> createState() => _ForumMainState();
}

class _ForumMainState extends State<ForumMain> {
  String? _selectedTime;

  get illustration => illustration;

  // We don't need to pass a context to the _show() function
  // You can safety use context as below
  Future<void> _show() async {
    final TimeOfDay? result =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        _selectedTime = result.format(context);
      });
    }
  }

  final bool _isSelected = false;
  List<String> data = ["Mathew", "Deon", "Sara", "Yeu"];
  List<String> userChecked = [];
  void _onSelected(bool selected, String dataName) {
    if (selected == true) {
      setState(() {
        selected == !selected;
        // print('asdsa');

        userChecked.add(dataName);
      });
    } else {
      setState(() {
        userChecked.remove(dataName);
      });
    }
  }

  TimeOfDay selectedTime = TimeOfDay.now();

  List days = [
    "Every day",
    "Every Monday",
    "Every Tuesday",
    "Every Wednesday",
    "Every Thursday",
    "Every Friday",
    "Every Saturday",
    "Every Sunday",
  ];
  List check = [false, false, false, false, false, false, false, false];
  List checkedDays = [
    false,
    false,
    true,
    false,
    true,
    false,
    false,
    false,
  ];
  var _checked;

  List images = [
    'assets/categories_images/Group 4712.png',
    'assets/categories_images/Group 4730.png',
    'assets/categories_images/Group 4727.png',
    'assets/categories_images/Group 4741.png',
    'assets/categories_images/Group 4732.png',
    'assets/categories_images/Group 4728.png'
  ];

  List<String> imageCaption = [
    "Recovering from life hardship",
    "Recovering from a heartbreak",
    "Self-improvement and reaching goals",
    "Spirituality experience",
    "Inspirational stories",
    "Parenthood challenges",
    "Learning difficulties",
  ];
  @override
  Widget build(BuildContext context) {
    PaginateRefreshedChangeListener refreshChangeListener =
        PaginateRefreshedChangeListener();
    DateTime dt = DateTime.now();
    String h = dt.hour.toString();
    String m = dt.minute.toString();
    final args = ModalRoute.of(context)!.settings.arguments as dynamic;
    int index = images.indexOf(args);

    // print("G Hogya : "+args);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        title: const Text(
          "Forums",
          style: TextStyle(fontFamily: 'Quattrocento', color: Colors.white),
        ),
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
        // title:  Text(
        //   "go back to set daily reminder",
        //   style: TextStyle(
        //     // fontSize: 16,
        //     fontSize: MediaQuery.of(context).size.width/22,
        //     color: Colors.white,
        //     fontFamily: 'Quattrocento',
        //   ),
        // ),
      ),
      body: GestureDetector(
        child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            // padding: const EdgeInsets.only(top: 25),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background_splash.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(args.toString()),
                ),
              ),
              child: BlurryContainer(
                blur: 5,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.only(top: 120),
                  child: RefreshIndicator(
                    child: PaginateFirestore(
                      itemBuilder: (context, documentSnapshots, index) {
                        return forumWidget(documentSnapshots[index]["name"],
                            documentSnapshots[index]["desc"]);
                      },
                      query: FirebaseFirestore.instance.collection('forums'),
                      // .orderBy('starting_date', descending: true),
                      listeners: [
                        refreshChangeListener,
                      ],
                      itemBuilderType: PaginateBuilderType.listView,
                      itemsPerPage: 3,
                      isLive: false,
                    ),
                    onRefresh: () async {
                      refreshChangeListener.refreshed = true;
                    },
                  ),
                ),
                // ListView.builder(
                //   itemCount: 5,
                //   itemBuilder: (context, index) {
                //     return forumWidget();
                //   },
                // ),
              ),
            )),
      ),
    );
  }

  forumWidget(title, description) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
      child: Container(
          padding: const EdgeInsets.only(top: 15),
          width: MediaQuery.of(context).size.width * 0.9,
          height: 100,
          decoration: const BoxDecoration(
              color: Color(0xfff2efd8),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: ListTile(
            leading: Image.asset('assets/images/logo.png'),
            title: Text(
              title,
              style: const TextStyle(
                  fontFamily: 'Quattrocento',
                  fontSize: 18,
                  color: Colors.black),
            ),
            subtitle: Text(
              description,
              style: const TextStyle(
                  fontFamily: 'Quattrocento',
                  fontSize: 14,
                  color: Colors.black),
            ),
          )

          // Column(
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: const [
          //     // SizedBox(
          //     //   width: MediaQuery.of(context).size.width * 0.7,
          //     //   height: 100,
          //     //   child: Image.network(
          //     //     'https://captiv8.com.au/wp-content/uploads/why_are_blogs_such_a_big_deal.jpg',
          //     //   ),
          //     // ),
          //     Text(
          //       'Blog Title Here',
          //       style: TextStyle(
          //           fontFamily: 'Quattrocento',
          //           fontSize: 18,
          //           color: Colors.white),
          //     ),
          //     Text(
          //       'Blog Description Here',
          //       style: TextStyle(
          //           fontFamily: 'Quattrocento',
          //           fontSize: 14,
          //           color: Colors.white),
          //     ),
          //   ],
          // ),
          ),
    );
  }
}
