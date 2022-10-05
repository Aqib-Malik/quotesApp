// ignore_for_file: file_names

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../common_widgets/CommonWidgets.dart';

class CommonMethodst {
  //static Future <File>? imagee;
  static bool isImg = false;

  ///Tost
  static Future<bool> checkConnection() async {
    bool a = false;
    var result = await Connectivity().checkConnectivity();
    if (result == ConnectivityResult.none) {
      CommonWdget.toastShow("make sure your internet is connected");
      a = false;
      return false;
    } else if (result == ConnectivityResult.mobile) {
      //toastShow("You are using mobile data");
      a = true;
      return true;
    } else if (result == ConnectivityResult.wifi) {
      //toastShow("You are using Wifi");
      a = true;
      return true;
    }
    return a;
  }

  static void onShareWithResult(context, imagePaths, text, subject) async {
    final box = context.findRenderObject() as RenderBox?;
    ShareResult result;
    if (imagePaths.isNotEmpty) {
      result = await Share.shareFilesWithResult(imagePaths,
          text: text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      result = await Share.shareWithResult(text,
          subject: subject,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Share result: ${result.status}"),
    ));
  }
}
