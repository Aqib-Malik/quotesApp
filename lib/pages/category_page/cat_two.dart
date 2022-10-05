// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CatTwo extends StatefulWidget {
  @override
  _CatTwoState createState() => _CatTwoState();
}

class _CatTwoState extends State<CatTwo> {
  @override
  Widget build(BuildContext context) {
    // Trip photo widget template
    Widget tripPhotos = StreamBuilder<QuerySnapshot>(
        stream:
            FirebaseFirestore.instance.collection('stagesoflife').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Error in receiving data: ${snapshot.error}');
          }

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('Not connected to the Stream or null');

            case ConnectionState.waiting:
              return const Text('Awaiting for interaction');

            case ConnectionState.active:
              // print("Stream has started but not finished");

              var totalPhotosCount = 0;
              List<DocumentSnapshot> tripPhotos;

              if (snapshot.hasData) {
                tripPhotos = snapshot.data!.docs;
                totalPhotosCount = tripPhotos.length;

                if (totalPhotosCount > 0) {
                  return GridView.builder(
                      itemCount: totalPhotosCount,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Center(
                          child: Card(
                            child: InkWell(
                              splashColor: Colors.blue.withAlpha(30),
                              onTap: () {
                                // print('Tapped on thumbnail.');
                                // print(
                                //     'Photo doc id: ${tripPhotos[index]}');
                              },
                              child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ClipRect(
                                      child: Align(
                                          alignment: Alignment.topCenter,
                                          heightFactor: 0.7,
                                          child: Text(
                                              "tripPhotos[index].data!['name']"
                                                  .toString())),
                                    ),
                                  ]),
                            ),
                          ),
                        );
                      });
                }
              }

              return Center(
                  child: Column(
                children: const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 50.0),
                  ),
                  Text(
                    "No trip photos found.",
                  )
                ],
              ));

            case ConnectionState.done:
              return const Text('Streaming is done');
          }
        });

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the CatTwo object that was created by
        // the App.build method, and use it to set our appbar title.
        title: const Text("widget"),
      ),
      body: Column(
        children: <Widget>[
          tripPhotos,
        ],
      ),
    );
  }
}
