import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class Payment {
  late Map<String, dynamic> paymentIntentData;
  Future<void> makePayment(String amount) async {
    try {
      await createPaymentIntent(amount, 'USD');
      // print("++++++++++++++++++++++++");
      // print(paymentIntentData);
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

      // setState(() {
      //   paymentIntentData = {};
      // });
      // kidr gea ???

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
      print("********************************************");
      print(response.body);
      return jsonDecode(response.statusCode.toString());
    } catch (e) {
      print("Exception" + e.toString());
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
