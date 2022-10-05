import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:positify_project/pages/payment_screen/payment_methods.dart';
// payment_screen.dart
import 'dart:convert';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:positify_project/services/firebase_service/firestore.dart';

class Support extends StatefulWidget {
  const Support({Key? key}) : super(key: key);

  @override
  State<Support> createState() => _SupportState();
}

class _SupportState extends State<Support> {
  late Map<String, dynamic> paymentIntentData;
  @override
  Widget build(BuildContext context) {
    List euros = ["15", "20", "25"];
    List supportOptions = [
      "Buy us a coffee",
      "Help us continue our efforts",
      "Invite us for a lunch"
    ];
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: false,
        elevation: 1,
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
        title: const Text(
          "Support Us",
          style: TextStyle(fontFamily: 'Quattrocento', color: Colors.white),
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
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //
      //   elevation: 1,
      //   title: Text(
      //       "Support"
      //   ),
      //   leading: InkWell(
      //     onTap: (){
      //       Navigator.pop(context);
      //     },
      //     child: Icon(
      //         Icons.arrow_back_ios_new
      //     ),
      //   ),
      // ),
      body: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/girl_background.jpg"),
          fit: BoxFit.cover,
        )),
        child: Column(
          children: <Widget>[
            const Spacer(),
            Container(
              alignment: Alignment.center,
              // width: MediaQuery.of(context).size.width/1.2,
              child: const Text(
                "Support us in our efforts to encourage people to be the better version of themselves",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: "Quattrocento",
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                ),
              ),
            ),
            const Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: BlurryContainer(
                color: Colors.white38,
                blur: 6,
                child: Column(
                  children: List.generate(
                      3,
                      (index) => Container(
                            margin: const EdgeInsets.all(10),
                            // decoration: BoxDecoration(
                            // color: Colors.white,
                            // borderRadius: BorderRadius.circular(20),
                            //   border: Border.all(
                            //     color: Colors.transparent,
                            //     width: 1,
                            //   )
                            // ),
                            child: InkWell(
                              onTap: () async {
                                print(index);
                                if (index == 0) {
                                  await makePayment("15");
                                }
                                if (index == 1) {
                                  await makePayment("20");
                                }
                                if (index == 2) {
                                  await makePayment("25");
                                }
                              },
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1,
                                        )),
                                    child: Text(
                                      euros[index] + '\$',
                                      style: const TextStyle(
                                          fontFamily: 'Quattrocento',
                                          color: Colors.black,
                                          fontSize: 19),
                                    ),
                                  ),
                                  Text(
                                    supportOptions[index],
                                    style: const TextStyle(
                                        fontFamily: 'Quattrocento',
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
                          )),
                ),
              ),
            ),
            const Spacer(flex: 2),
            // Padding(
            //   padding: const EdgeInsets.all(10),
            //   child: InkWell(
            //     onTap: () {
            //       Navigator.push(
            //         context,
            //         PageTransition(
            //           type: PageTransitionType.fade,
            //           child: const CategoriesScreen(),
            //
            //           duration: const Duration(milliseconds: 1000),
            //         ),
            //       );
            //     },
            //     child: const Icon(
            //       Icons.home,
            //       color: Colors.black,
            //       size: 60,
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    ));
  }

  Future<void> makePayment(var amount) async {
    try {
      paymentIntentData = await createPaymentIntent(amount.toString(), 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        //applePay: true,
        //googlePay: PaymentSheetGooglePay.fromJson("{sdjh:dsj}"),

        merchantDisplayName: 'Prospects',
        customerId: paymentIntentData!['customer'],
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        //  customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
      ));
      displayPaymentSheet();
    } catch (e) {
      print("Exception" + e.toString());
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet(
          parameters: PresentPaymentSheetParameters(
              clientSecret: paymentIntentData!['client_secret'],
              confirmPayment: true));

      setState(() {
        paymentIntentData = {};
      });
      FirestoreMethods.updatePrimeUser();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LjKcuBKgMvxmN7mV1y0lnBYFE3N23ciPAi6vPeb5fYTmywIuIuoOJUEPCgfmiXt7znD3CaOrMGiQwsv62bly7DF000Uvei3OF',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (e) {
      print("Exception" + e.toString());
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
