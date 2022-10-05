import 'package:flutter/material.dart';
import 'package:jelly_anim/jelly_anim.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePage();
  }
}

class _MyHomePage extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(40, 40, 40, 1),
      body: Column(children: [
        SizedBox(
          height: 500,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80),
                child: JellyAnim(
                  radius: 100,
                  colors: [Color.fromRGBO(255, 237, 59, 1)],
                  allowOverFlow: true,
                  viewPortSize: Size(MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height),
                  jellyPosition: JellyPosition.bottomCenter,
                ),
              )
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => DemoScreen()),
            // );
          },
          child: Padding(
              padding: EdgeInsets.only(top: 250),
              child: Text(
                "Let’s Go",
                textAlign: TextAlign.center,
              )),
        )
      ]),
    ));
  }
}
